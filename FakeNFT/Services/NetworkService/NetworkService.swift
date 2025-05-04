//
//  NetworkService.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev on 28.04.2025.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    private let apiHeaders: [String: String] = [
        "Accept": "application/json",
        "X-Practicum-Mobile-Token": "\(RequestConstants.token)"
    ]
    
    // MARK: Decode body for x-www-form-urlencoded
    private func createFormURLEncodedBody(from data: [String], key: String) -> Data? {
        let bodyString = data
            .compactMap { item in
                item.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            }
            .map { "\(key)=\($0)" }
            .joined(separator: "&")
        return bodyString.data(using: .utf8)
    }
    
    /// This method is a template for queries that return data
    func fetchRequest<T: Decodable>(
        endpoint: Endpoint,
        method: HTTPMethod,
        id: String? = "",
        encodableData: Encodable? = nil
    ) async throws -> T {
        
        let urlString: String
        if let id = id, !id.isEmpty {
            urlString = "\(RequestConstants.baseURL)\(endpoint.rawValue)\(id)"
        } else {
            urlString = "\(RequestConstants.baseURL)\(endpoint.rawValue)"
        }

        guard let url = URL(string: urlString) else {
            print("fetchRequest - Invalid URL")
            throw URLError(.badURL)
        }
            
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        var headers = apiHeaders
        
        if method == .put {
            headers["Content-Type"] = "application/x-www-form-urlencoded"
        }
        
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        if let encodableData = encodableData {
            let mirror = Mirror(reflecting: encodableData)
            for child in mirror.children {
                if let arrayKey = child.label, let arrayValue = child.value as? [String] {
                    request.httpBody = createFormURLEncodedBody(from: arrayValue, key: arrayKey)
                    break
                }
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid server response: \(response)")
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            print("Server error: \(httpResponse.statusCode)")
            print("Response body: \(String(data: data, encoding: .utf8) ?? "N/A")")
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("JSON decoding error: \(error.localizedDescription)")
            print("Raw response: \(String(data: data, encoding: .utf8) ?? "N/A")")
            throw error
        }
    }
}
