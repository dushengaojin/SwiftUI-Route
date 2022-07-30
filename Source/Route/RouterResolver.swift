//
//  RouterResolver.swift
//  SwiftUIRoute
//
//  Created by Daolang Huang on 2022/6/8.
//

import SwiftUI

class RouterResolver {
    static let shared = RouterResolver()
    var noPageViewBuilder: (() -> AnyView)?
    private var factory: [String: (Any?) -> Any] = [:]
    private var routeTypes: [String: RouteType] = [:]
    private var routePaths: [IsActive] = []
    private init() {}
    
    func add<T>(key: String, _ factoryBlock: @escaping (Any?) -> T) {
        factory.updateValue(factoryBlock, forKey: key)
    }

    func resolve<T>(_ key: String, context: Any?) -> T {
        guard let view = factory[key]?(context) as? T else {
            return (noPageViewBuilder?() ?? DefaultErrorPage().anyView) as! T
        }
        
        return view
    }
    
    func addRouteType(key: String, routeType: RouteType) {
        routeTypes.updateValue(routeType, forKey: key)
    }
    
    func resolveRouteType(key: String) -> RouteType {
        routeTypes[key] ?? .push
    }
    
    func keyIsAvailable(_ key: String) -> Bool {
        factory[key] != nil
    }
    
    func addRouterPath(isActive: IsActive) {
        routePaths.removeAll(where: { !$0.isActive })
        routePaths.append(isActive)
    }
    
    func getIsActiveBy(path: String) -> IsActive? {
        routePaths.last(where: { $0.path == path })
    }
    
    func backToRoot() {
        for item in routePaths {
            switch routeTypes[item.path] {
            case .sheet, .fullScreenCover:
                item.$isActive.wrappedValue = true
            default:
                break
            }
        }
        
        if let firstPage = routePaths.first(where: { $0.isActive }) {
            firstPage.$isActive.wrappedValue.toggle()
            routePaths.removeAll()
        }
    }
    
    func clearPathBy(path: String) {
        if let index = routePaths.lastIndex(where: { $0.path == path }),
           index != routePaths.count - 1 {
            routePaths.removeSubrange(index + 1 ..< routePaths.count)
        }
    }
}
