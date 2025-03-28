//
//  BreedListViewModel.swift
//  ChipDogs
//
//  Created by Tomas Tristao on 28/03/2025.
//

import Foundation

final class BreedListViewModel: ObservableObject {
    
    @Published var breeds: [Breed] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    private let dogRepository: DogRepository
    private weak var coordinator: MainCoordinator?

    init(
        coordinator: MainCoordinator,
        dogRepository: DogRepository = DefaultRepository()
    ) {
        self.coordinator = coordinator
        self.dogRepository = dogRepository
    }

    @MainActor
    func fetchBreeds() async {
        isLoading = true
        errorMessage = nil
        do {
            breeds = try await dogRepository.fetchBreeds()
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = "Failed fetching breads..."
        }
    }
    
    func tapOn(breed: Breed) {
        coordinator?.goToDetailView(for: breed)
    }
}
