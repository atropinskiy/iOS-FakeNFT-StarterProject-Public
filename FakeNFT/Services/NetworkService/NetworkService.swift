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
        idNumber: Int? = nil,
        encodableData: Encodable? = nil
    ) async throws -> T? {
        
        guard let url = URL(string: "\(RequestConstants.baseURL)\(endpoint.rawValue) + \(String(describing: idNumber ?? nil))") else {
            print("fetchRequest - Invalid URL")
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        var modifiedHeaders = apiHeaders
        
        if method == .put {
            modifiedHeaders["Content-Type"] = "application/x-www-form-urlencoded"
        }
        
        modifiedHeaders.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let encodableData = encodableData {
            do {
                request.httpBody = try JSONEncoder().encode(encodableData)
            } catch {
                print("JSON coding error: \(error.localizedDescription)")
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid server response: \(response)")
            throw URLError(.badServerResponse)
        }
        
        if !(200...299).contains(httpResponse.statusCode) {
            print("Server error: \(httpResponse.statusCode)")
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("JSON decoding error: \(error.localizedDescription)")
            throw error
        }
    }
    
}

