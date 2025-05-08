// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "test1package",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(
      name: "test1package",
      targets: ["test1package"]
    ),
  ],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      exact: "1.19.1"
    ),
  ],
  targets: [
    .target(
      name: "test1package",
      dependencies: [
        .product(
          name: "ComposableArchitecture",
          package: "swift-composable-architecture"
        )
      ]
    ),
    .testTarget(
      name: "test1packageTests",
      dependencies: ["test1package"]
    ),
  ]
)
