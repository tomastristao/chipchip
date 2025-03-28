//
//  BreedImage.swift
//  ChipDogs
//
//  Created by Tomas Tristao on 28/03/2025.
//

import Foundation

struct BreedImageList {
    let images: [BreedImage]
}

struct BreedImage {
    let imageURL: String
}

extension BreedImageListDataModel {
    
    func mapToDomainModel() -> BreedImageList {
        BreedImageList(images: self.message.map { BreedImage(imageURL: $0) })
    }
}
