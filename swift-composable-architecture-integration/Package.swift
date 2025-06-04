// swift-tools-version: 6.0

import PackageDescription

let swiftComposableArchitectureVersion: Version = "1.20.2"

let swiftComposableArchitectureRemote = Package.Dependency.package(
  url: "https://github.com/pointfreeco/swift-composable-architecture.git",
  exact: swiftComposableArchitectureVersion
)

let swiftComposableArchitectureBinary = Package.Dependency.package(
  url: "https://github.com/pointfreeco/swift-composable-architecture.git",
  exact: swiftComposableArchitectureVersion
)

//let swiftComposableArchitecture = swiftComposableArchitectureRemote
let swiftComposableArchitecture = #{DEPENDENCY}


let package = Package(
  name: "swift-composable-architecture-integration",
  platforms: [
    .iOS(.v13),
    .macOS(.v13),
    .tvOS(.v13),
    .watchOS(.v6)
  ],
  products: [
    .library(
      name: "swift-composable-architecture-integration",
      targets: [
        "swift-composable-architecture-integration"
      ]
    ),
  ],
  dependencies: [
    swiftComposableArchitecture
  ],
  targets: [
    .target(
      name: "swift-composable-architecture-integration",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ]
    ),
    .testTarget(
      name: "swift-composable-architecture-integrationTests",
      dependencies: [
        "swift-composable-architecture-integration"
      ]
    ),
  ]
)
