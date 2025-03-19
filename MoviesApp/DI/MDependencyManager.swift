//
//  MDependencyManager.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 18/09/2024.
//

import Foundation
import Swinject

class MDependencyManager {
    static let shared = MDependencyManager()
    let container: Container
    
    private init() {
        container = Container()
        initContainer()
    }
    
    private func initContainer() {
        container.register(URLSession.self) { _ in
            let config = URLSessionConfiguration.default
            config.protocolClasses = [MURLProtocol.self]
            return URLSession(configuration: config)
        }
        container.register(MoviesNetworkingService.self) { r in
            guard let urlSession = r.resolve(URLSession.self) else { fatalError("Failed to resolve URLSession") }
            return MoviesNetworkingServiceImpl(urlSession: urlSession, urlCache: URLCache.shared)
        }
        container.register(MImageManager.self) { _ in MImageManagerImpl() }
        container.register(MErrorHandler.self) { _ in MErrorHandlerImpl() }
        container.register(MScreenRecorder.self) { _ in MScreenRecorderImpl() }
    }
}

@propertyWrapper
struct Injected<Dependency> {
    var wrappedValue: Dependency
    
    init(wrappedValue: Dependency) {
        self.wrappedValue = MDependencyManager.shared.container.resolve(Dependency.self)!
    }
}
