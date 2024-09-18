//
//  MDependencyManager.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 18/09/2024.
//

import Swinject

class MDependencyManager {
    static let shared = MDependencyManager()
    let container: Container

    private init() {
        container = Container()
        initContainer()
    }

    private func initContainer() {
        container.register(MoviesNetworkingService.self) { _ in MoviesNetworkingServiceImpl() }
        container.register(MImageManager.self) { _ in MImageManagerImpl() }
        container.register(MErrorHandler.self) { _ in MErrorHandlerImpl() }
    }
}

@propertyWrapper
struct Injected<Dependency> {
    var wrappedValue: Dependency
    
    init(wrappedValue: Dependency) {
        self.wrappedValue = MDependencyManager.shared.container.resolve(Dependency.self)!
    }
}
