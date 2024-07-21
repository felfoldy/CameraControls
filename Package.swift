// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CameraControls",
    platforms: [.iOS(.v18), .macOS(.v15), .visionOS(.v2)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CameraControls",
            targets: ["CameraControls"]
        ),
    ],
    targets: [
        .target(name: "CameraControls"),
    ]
)
