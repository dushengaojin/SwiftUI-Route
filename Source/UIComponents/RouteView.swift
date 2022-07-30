//
//  RouteView.swift
//  SwiftUIRoute
//
//  Created by Daolang Huang on 2022/6/13.
//
import SwiftUI

public struct RouteView<Content: View>: View {
    let builder: ((Binding<Bool>) -> Content)
    let uri: String
    var routeUri: RouteUri!
    let context: (() -> Any?)?

    var correctContext: Any? {
        context?() ?? routeUri.parameters
    }
    
    var path: String {
        routeUri.routeRawValue ?? uri
    }
    
    @State var isActive: Bool = false

    public init(uri: String, context: (() -> Any?)? = nil, @ViewBuilder builder: @escaping (Binding<Bool>) -> Content) {
        self.uri = uri
        self.context = context
        self.builder = builder
        self.routeUri = RouteUri(uri: uri)
    }
    
    public var body: some View {
        switch BasicRouter.getRouteType(path: path) {
        case .push:
            return NavigationLink(isActive: $isActive) {
                NavigationLazyView(
                    BasicRouter.resolveView(path: path, context: correctContext, isActive: $isActive)
                )
            } label: {
                builder($isActive)
            }
            .isDetailLink(false)
            .anyView
        case .sheet:
            return builder($isActive)
                .sheet(isPresented: $isActive, onDismiss: nil) {
                    BasicRouter.resolveView(path: path, context: correctContext, isActive: $isActive)
                }
                .anyView
        case .fullScreenCover:
            return builder($isActive)
                .fullScreenCover(isPresented: $isActive, onDismiss: nil) {
                    BasicRouter.resolveView(path: path, context: correctContext, isActive: $isActive)
                }
                .anyView
        }
    }
}
