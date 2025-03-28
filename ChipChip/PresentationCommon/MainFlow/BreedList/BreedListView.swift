//
//  BreedListView.swift
//  ChipDogs
//
//  Created by Tomas Tristao on 28/03/2025.
//

import SwiftUI

struct BreedListView: View {
    
    @ObservedObject var viewModel: BreedListViewModel

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading breeds...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                } else {
                    List(viewModel.breeds, id: \.id) { breed in
                        Button(action: {
                            viewModel.tapOn(breed: breed)
                        }) {
                            if breed.type == breed.subType {
                                Text(breed.type.capitalized)
                            } else {
                                VStack(alignment: .leading) {
                                    Text(breed.type.capitalized)
                                    Text(breed.subType.capitalized)
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Breeds")
        }
        .task {
            await viewModel.fetchBreeds()
        }
    }
}

#Preview {
    BreedListView(viewModel: .init(coordinator: .init()))
}
