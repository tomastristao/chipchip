//
//  Breed.swift
//  ChipDogs
//
//  Created by Tomas Tristao on 28/03/2025.
//

import Foundation

struct BreedList {
    let items: [Breed]
}

struct Breed: Identifiable, Equatable {
    var id: String { type+subType }
    let type: String
    let subType: String
}

extension BreedListDataModel {
    
    func mapToDomainModel() -> BreedList {
        let breeds: [Breed] = message.flatMap { (type, subtypes) in
            if subtypes.isEmpty {
                return [Breed(type: type, subType: type)]
            } else {
                return subtypes.map { Breed(type: type, subType: $0) }
            }
        }.sorted(by: { $0.type < $1.type })
        
        return BreedList(items: breeds)
    }
}

// MARK: Helpers

extension Breed {
    
    static var mocked1 = Breed(type: "AAA", subType: "A+")
    static var mocked2 = Breed(type: "BBB", subType: "B-")
}
