// swift-tools-version:6.0
import PackageDescription

let package:Package = .init(name: "test",
    products: [
        .executable(name: "bson-inspect", targets: ["BSONViewer"]),
        .executable(name: "bson-inspect-frontend", targets: ["BSONViewerFrontend"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
        .package(url: "https://github.com/swiftwasm/JavaScriptKit", from: "0.21.0"),
        .package(url: "https://github.com/tayloraswift/swift-bson", branch: "swift-78802"),
        .package(url: "https://github.com/tayloraswift/swift-dom", from: "1.1.2"),
    ],
    targets: [
        .executableTarget(name: "BSONViewer",
            dependencies: [
                .product(name: "JavaScriptKit", package: "JavaScriptKit"),
                .product(name: "BSON", package: "swift-bson"),
            ]),

        .executableTarget(name: "BSONViewerFrontend",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "HTML", package: "swift-dom"),
            ]),
    ])
