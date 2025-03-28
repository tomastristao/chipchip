//
//  BaseCoordinator.swift
//  ChipDogs
//
//  Created by Tomas Tristao on 28/03/2025.
//

import Foundation
import SwiftUI

public protocol Coordinator {
    associatedtype PageType
    associatedtype SheetType
    associatedtype FullScreenCoverType
    
    var path: NavigationPath { get }
    var sheet: SheetType? { get }
    var fullScreenCover: FullScreenCoverType? { get }
    
    func push(_ page: PageType)
    func present(sheet: SheetType)
    func present(fullScreenCover: FullScreenCoverType)
    func pop()
    func popToRoot()
    func dismissSheet()
    func dismissFullScreenCover()
}

class BaseCoordinator<PageType: Hashable, SheetType, FullScreenCoverType>: Coordinator, ObservableObject {
      
    public typealias PageType = PageType
    public typealias SheetType = SheetType
    public typealias FullScreenCoverType = FullScreenCoverType
    
    @Published public var path: NavigationPath
    @Published public var sheet: SheetType?
    @Published public var fullScreenCover: FullScreenCoverType?
    
    public init(
        path: NavigationPath = NavigationPath(),
        sheet: SheetType? = nil,
        fullScreenCover: FullScreenCoverType? = nil
    ) {
        self.path = path
        self.sheet = sheet
        self.fullScreenCover = fullScreenCover
    }
   
    public func push(_ page: PageType) {
        path.append(page)
    }
    
    public func present(sheet: SheetType) {
        self.sheet = sheet
    }
    
    public func present(fullScreenCover: FullScreenCoverType) {
        self.fullScreenCover = fullScreenCover
    }
    
    public func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    public func popToRoot() {
        path.removeLast(path.count)
    }
    
    public func dismissSheet() {
        self.sheet = nil
    }
    
    public func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
}
