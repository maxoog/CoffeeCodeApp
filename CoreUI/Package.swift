// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "CoreUI",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "CoreUI",
            targets: ["CoreUI"]),
    ],
    dependencies: [
        .package(path: "../Core")
    ],
    targets: [
        .target(
            name: "CoreUI",
            dependencies: [
                .product(name: "Core", package: "Core")
            ])
    ]
)
