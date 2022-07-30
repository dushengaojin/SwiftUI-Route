//
//  RouteUri.swift
//  SwiftUIRoute
//
//  Created by Daolang Huang on 2022/6/13.
//
import Foundation

struct RouteUri {
    let uri: String
    var routeRawValue: String?
    var parameters: [String: Any] = [:]

    init(uri: String) {
        self.uri = uri
        guard let url = URLComponents(string: uri) else { return }
        routeRawValue = (url.host ?? "") + url.path
        
        guard let items = url.queryItems, !items.isEmpty else { return }
        
        items.forEach({
            parameters.updateValue($0.value ?? "", forKey: $0.name)
        })
    }
    
    func getRoute<RouteType: Route>(type: RouteType.Type) -> RouteType? {
        guard let routeRawValue = routeRawValue else { return nil}
        return RouteType(rawValue: routeRawValue)
    }
}

extension Dictionary {
    func getModel<ModelType: Decodable>(type: ModelType.Type) -> ModelType? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed) else {
            return nil
        }
        
        return try? JSONDecoder().decode(ModelType.self, from: data)
    }
}

struct DefaultModel: Decodable {
    let id: String
}

