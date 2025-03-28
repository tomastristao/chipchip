//
//  ChipChipTests.swift
//  ChipChipTests
//
//  Created by Tomas Tristao on 28/03/2025.
//

import XCTest
@testable import ChipChip

final class ChipChipTests: XCTestCase {
    
    func testFetchBreedsSuccess() async {
        let mockBreeds: [Breed] = [.mocked1, .mocked2]
        let sut = makeSUT(with: mockBreeds)
        
        await sut.fetchBreeds()
        
        XCTAssertEqual(sut.breeds, mockBreeds)
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testFetchBreedsFailure() async {
        let mockBreeds: [Breed] = [.mocked1, .mocked2]
        let sut = makeSUT(with: mockBreeds, shouldFail: true)
        
        await sut.fetchBreeds()
        
        XCTAssertEqual(sut.breeds, [])
        XCTAssertEqual(sut.errorMessage, "Failed fetching breads...")
        XCTAssertFalse(sut.isLoading)
    }
    
    func testTapOnBreedNavigatesToDetail() {
        let mockBreeds: [Breed] = []
        let sut = MockMainCoordinator()
        let viewModel = makeSUT(with: mockBreeds, coordinator: sut)
        
        viewModel.tapOn(breed: .mocked1)
        
        XCTAssertTrue(sut.didNavigateToDetail)
        XCTAssertEqual(sut.didTapOnBreed?.type, "AAA")
    }
}

extension ChipChipTests {
    
    func makeSUT(
        with data: [Breed],
        coordinator: MockMainCoordinator = MockMainCoordinator(),
        shouldFail: Bool = false
    ) -> BreedListViewModel {
        let mockRepo = MockDogRepository()
        mockRepo.mockBreeds = data
        mockRepo.shouldFail = shouldFail
        return BreedListViewModel(coordinator: coordinator, dogRepository: mockRepo)
    }
}

final class MockDogRepository: DogRepository {
    
    var mockBreeds: [Breed] = []
    var shouldFail = false

    func fetchBreeds() async throws -> [Breed] {
        if shouldFail { throw URLError(.unknown) }
        return mockBreeds
    }

    func fetchImages(for breed: Breed, limit: Int) async throws -> [BreedImage] {
        return []
    }
}

final class MockMainCoordinator: MainCoordinator {
    
    var didNavigateToDetail = false
    var didTapOnBreed: Breed? = nil

    override func goToDetailView(for breed: Breed) {
        didNavigateToDetail = true
        didTapOnBreed = breed
    }
}

