//
//  BreedImageView.swift
//  ChipDogs
//
//  Created by Tomas Tristao on 28/03/2025.
//

import SwiftUI

struct BreedImagesView: View {
    
    @ObservedObject var viewModel: BreedImagesViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading images...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(viewModel.images, id: \.imageURL) { item in
                                AsyncImage(url: URL(string: item.imageURL)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                } placeholder: {
                                    Color
                                        .gray
                                        .opacity(0.2)
                                }
                                .frame(height: 150)
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.3)
                                .clipped()
                                .cornerRadius(4)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(viewModel.navigationBarTitle)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .bold()
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .task {
            Task {
                await viewModel.fetchImages()
            }
        }
    }
}

#Preview {
    BreedImagesView(viewModel: .init(coordinator: .init(), breed: .init(type: "Test", subType: "SubType Test")))
}
