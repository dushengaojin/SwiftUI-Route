//
//  DefaultErrorPage.swift
//  SwiftUIRoute
//
//  Created by Daolang Huang on 2022/6/14.
//
import SwiftUI

struct DefaultErrorPage: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        Text("Page Not Found Error")
        Button("Back To Last Page") {
            mode.wrappedValue.dismiss()
        }
    }
}
