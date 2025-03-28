//
//  NetworkEngine.swift
//  ChipDogs
//
//  Created by Tomas Tristao on 28/03/2025.
//

import Foundation

protocol NetworkEngineProtocol {
    func request<T: Decodable>(_ url: URL, responseType: T.Type) async throws -> T
}

final class NetworkEngine: NetworkEngineProtocol {
    
    func request<T: Decodable>(_ url: URL, responseType: T.Type) async throws -> T {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("☁️❌ - Request failed for URL: \(url) with error: \(error)")
            throw error
        }
    }
}
