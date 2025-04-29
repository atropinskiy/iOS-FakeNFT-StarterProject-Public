//
//  NetworkService.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev on 28.04.2025.
//

import Foundation


final class NetworkService: NetworkServiceProtocol, ObservableObject {
    private let apiHeaders: [String: String] = ["Accept": "application/json", "X-Practicum-Mobile-Token": "\(RequestConstants.token)"]
    
    /// This method is a template for queries that return data
    func fetchRequest<T: Decodable>(
        endpoint: Endpoint,
        method: HTTPMethod,
        idNumber: Int? = nil
    ) async throws -> T {
        
        let urlString = "\(RequestConstants.baseURL)\(endpoint.rawValue)" + (idNumber.map { "\($0)" } ?? "")
        guard let url = URL(string: urlString) else {
            print("fetchRequest - Invalid URL")
            throw URLError(.badURL)
        }
            
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        var modifiedHeaders = apiHeaders
        
        if method == .put {
            modifiedHeaders["Content-Type"] = "application/json"
        }
        
        modifiedHeaders.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
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
