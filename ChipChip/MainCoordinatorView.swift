//
//  MainCoordinator.swift
//  ChipDogs
//
//  Created by Tomas Tristao on 28/03/2025.
//

import SwiftUI

public struct MainCoordinatorView: View {
    
    @StateObject var coordinator = MainCoordinator()
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                coordinator.build(page: .home)
                    .sheet(item: $coordinator.sheet) { sheet in
                        coordinator.build(sheet: sheet)
                    }
            }
        }
        .accentColor(.white)
    }
}
