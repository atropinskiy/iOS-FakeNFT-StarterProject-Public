//
//  NetworkServiceProtocol.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev on 28.04.2025.
//

protocol NetworkServiceProtocol {
    func fetchRequest<T: Decodable>(
        endpoint: Endpoint,
        method: HTTPMethod,
        id:String?,
        encodableData: Encodable?
    ) async throws -> T
}
