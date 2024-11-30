// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SwiftUIGoodies",
    platforms: [
      .iOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftUIGoodies",
            targets: ["SwiftUIGoodies"]),
    ],
    targets: [
        .target(
            name: "SwiftUIGoodies")
    ]
)
