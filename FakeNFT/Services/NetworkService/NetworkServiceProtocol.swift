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
        idNumber: String?,
        currencyID: Int?,
        encodableData: Encodable?
    ) async throws -> T
}
