//
//  BreedDataModel.swift
//  ChipDogs
//
//  Created by Tomas Tristao on 28/03/2025.
//

import Foundation

struct BreedListDataModel: Codable {
    let message: [String: [String]]
    let status: String
}
