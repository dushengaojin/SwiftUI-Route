# SwiftUI-Route
An route practice on Swift UI

## How to install

```
pod 'SwiftUIRoute'
```


## How to use

### generate your route

```

enum MyRoute: String, Route {
    case pushOne
    case pushTwo
    case pushThree
    case uriPush = "domain/order/detail"
    case sheet
    case fullScreenCover
    
    var routeType: RouteType {
        switch self {
        case .sheet:
            return .sheet
        case .fullScreenCover:
            return .fullScreenCover
        default:
            return .push
        }
    }
    
    func start(context: Any?) -> some View {
        switch self {
        case .pushOne:
            return PushOne(context: context as? String).anyView
        case .pushTwo:
            return PushTwo().anyView
        case .pushThree, .uriPush:
            if let context = context as? [String: Any] {
                return PushThree(id: context["id"] as? String, type: context["type"] as? String).anyView
            }
            return PushThree(id: nil, type: nil).anyView
        case .sheet, .fullScreenCover:
            return PresentView().anyView
        }
    }
}

```

### regist your route

```
MyRoute.regist()
```

### using it

```
RouteView(uri: MyRoute.pushOne.rawValue, context: { "hello world" }) { _ in
    Text("Text Push with context: hello world")
}
                
RouteView(uri: MyRoute.pushOne.rawValue) { isActive in
    Button("Button push") {
        isActive.wrappedValue.toggle()
    }
}

RouteView(uri: MyRoute.sheet.rawValue) { isActive in
    Button("Present sheet") {
        isActive.wrappedValue.toggle()
    }
}

RouteView(uri: MyRoute.fullScreenCover.rawValue) { isActive in
    Button("Present fullScreenCover") {
        isActive.wrappedValue.toggle()
    }
}

RouteView(uri: "https://domain/order/detail?id=1&type=2") { _ in
    Text("Push uri: https://domain/order/detail?id=1&type=2")
}

```


### back to root

```
MyRoute.backToRoot()
```

### back to path

```
MyRoute.backTo(path: MyRoute.pushTwo.rawValue)
```
*notice*: this path is not your object path, is the path which pushed from your obj page, this method is controling the isActive of the path, so be careful


[Demo address](https://github.com/dushengaojin/SwiftUIRouteDemo.git)
