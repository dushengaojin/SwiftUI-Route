//
//  Router.swift
//  SwiftUIRoute
//
//  Created by Daolang Huang on 2022/6/8.
//

import Foundation
import SwiftUI
import Combine

public protocol Route: RawRepresentable, CaseIterable where Self.RawValue == String {
    associatedtype T: View
    func start(context: Any?) -> T
    var routeType: RouteType { get }
}

public enum RouteType {
    case push
    case sheet
    case fullScreenCover
}

public extension Route {
    ///  regist to global for decoupling
    static func regist() {
        allCases.forEach({ item in
            RouterResolver.shared.addRouteType(key: item.rawValue, routeType: item.routeType)
            RouterResolver.shared.add(key: item.rawValue) { context in
                item.start(context: context)
            }
        })
    }
    
    static func getRouteType(path: String) -> RouteType {
        RouterResolver.shared.resolveRouteType(key: path)
    }
    
    static func registNoPageView(@ViewBuilder builder: @escaping () -> AnyView) {
        RouterResolver.shared.noPageViewBuilder = builder
    }

    static func resolveView(path: String, context: Any?, isActive: Binding<Bool>) -> some View {
        guard RouterResolver.shared.keyIsAvailable(path) else {
            return RouterResolver.shared.noPageViewBuilder?() ?? DefaultErrorPage().anyView
        }
        
        RouterResolver.shared.addRouterPath(isActive: .init(path: path, isActive: isActive))
        return (RouterResolver.shared.resolve(path, context: context) as Self.T).anyView
    }

    static func backTo(path: String) {
        if let isActive = RouterResolver.shared.getIsActiveBy(path: path) {
            isActive.$isActive.wrappedValue = false
            RouterResolver.shared.clearPathBy(path: path)
        }
    }
    
    static func backToRoot() {
        RouterResolver.shared.backToRoot()
    }
}

struct IsActive {
    let path: String
    @Binding var isActive : Bool
}


public enum BasicRouter: String, Route {
    case global
    
    public func start(context: Any?) -> some View {
        EmptyView().anyView
    }
    
    public var routeType: RouteType { .push }
}
