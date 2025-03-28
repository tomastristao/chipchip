//
//  BreedImagesViewModel.swift
//  ChipDogs
//
//  Created by Tomas Tristao on 28/03/2025.
//

import Foundation

final class BreedImagesViewModel: ObservableObject {
    
    @Published var images: [BreedImage] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    lazy var navigationBarTitle: String = {
        guard breed.type != breed.subType else {
            return breed.type.capitalized
        }
        return breed.type.capitalized + " " + breed.subType.capitalized
    }()
    
    private let dogRepository: DogRepository
    private let coordinator: MainCoordinator
    let breed: Breed

    init(
        coordinator: MainCoordinator,
        dogRepository: DogRepository = DefaultRepository(),
        breed: Breed
    ) {
        self.coordinator = coordinator
        self.dogRepository = dogRepository
        self.breed = breed
    }
    
    @MainActor
    func fetchImages() async {
        isLoading = true
        do {
            images = try await dogRepository.fetchImages(for: breed, limit: 10)
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = "Failed fetching images for breed type \(breed.type)"
        }
    }
    
    func dismiss() {
        coordinator.dismissSheet()
    }
}
