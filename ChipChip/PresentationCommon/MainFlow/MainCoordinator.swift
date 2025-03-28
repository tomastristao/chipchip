//
//  MainCoordinator.swift
//  ChipDogs
//
//  Created by Tomas Tristao on 28/03/2025.
//

import Foundation
import SwiftUI

// MARK: Default Page screens
enum MainFlowPage: Hashable, Identifiable {
    case home
    var id: Self { self }
}

// MARK: Sheet screens
enum MainFlowSheet: Hashable, Identifiable {
    case detailView(BreedImagesViewModel)
    var id: Self { self }
}

class MainCoordinator: BaseCoordinator<MainFlowPage, MainFlowSheet, Any> {
    
    private lazy var mainViewModel = BreedListViewModel(coordinator: self)
    
    public init() {}
    
    func goToDetailView(for breed: Breed) {
        let viewModel = BreedImagesViewModel(coordinator: self, breed: breed)
        present(sheet: .detailView(viewModel))
    }

    @ViewBuilder
    func build(page: MainFlowPage) -> some View {
        switch page {
        case .home:
            BreedListView(viewModel: mainViewModel)
        }
    }
    
    @ViewBuilder
    func build(sheet: MainFlowSheet) -> some View {
        switch sheet {
        case .detailView(let viewModel):
            BreedImagesView(viewModel: viewModel)
        }
    }
}

// MARK: Helper
extension MainFlowSheet: Equatable {
    static func == (lhs: MainFlowSheet, rhs: MainFlowSheet) -> Bool {
        switch (lhs, rhs) {
        case (.detailView(let lhsVM), .detailView(let rhsVM)):
            return lhsVM.breed.id == rhsVM.breed.id
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .detailView(let vm):
            hasher.combine(vm.breed.id)
        }
    }
}
