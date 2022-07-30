//
//  View+Modifier.swift
//  SwiftUIRoute
//
//  Created by Daolang Huang on 2022/6/8.
//

import Foundation
import SwiftUI

struct AnyViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        AnyView(content)
    }
}

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}

public extension View {
    var anyView: AnyView {
        AnyView(self)
    }
}
