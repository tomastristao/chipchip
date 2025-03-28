//
//  DogRepository.swift
//  ChipDogs
//
//  Created by Tomas Tristao on 28/03/2025.
//

import Foundation

protocol DogRepository {
    func fetchBreeds() async throws -> [Breed]
    func fetchImages(for breed: Breed, limit: Int) async throws -> [BreedImage]
}

final class DefaultRepository: DogRepository {
    
    private let networkEngine: NetworkEngineProtocol
    
    init(networkEngine: NetworkEngineProtocol = NetworkEngine()) {
        self.networkEngine = networkEngine
    }
    
    func fetchBreeds() async throws -> [Breed] {
        guard let url = URL(string: "https://dog.ceo/api/breeds/list/all") else { return [] }
        let data = try await networkEngine.request(url, responseType: BreedListDataModel.self)
        return data.mapToDomainModel().items
    }

    func fetchImages(for breed: Breed, limit: Int) async throws -> [BreedImage] {
        let urlString: String
        if breed.type == breed.subType {
            urlString = "https://dog.ceo/api/breed/\(breed.type)/images/random/10"
        } else {
            urlString = "https://dog.ceo/api/breed/\(breed.type)/\(breed.subType)/images/random/\(limit)"
        }
        guard let url = URL(string: urlString) else { return [] }
        let data = try await networkEngine.request(url, responseType: BreedImageListDataModel.self)
        return data.mapToDomainModel().images
    }
}
