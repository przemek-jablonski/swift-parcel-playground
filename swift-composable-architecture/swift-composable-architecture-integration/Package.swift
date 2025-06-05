// swift-tools-version: 5.10.0

import PackageDescription

// Use external tools (or manual modification) to replace $VERSION$ placeholder with valid tag / version. Eg.
let swiftComposableArchitectureVersion: Version = "1.20.2"
//let swiftComposableArchitectureVersion: Version = #{VERSION}


let isUsingLocalBinary = true

let swiftComposableArchitectureTarget: Target.Dependency = isUsingLocalBinary
? "ComposableArchitecture"
: .product(name: "ComposableArchitecture", package: "swift-composable-architecture")

// let swiftComposableArchitectureRemote = Package.Dependency.package(
//   url: "https://github.com/pointfreeco/swift-composable-architecture.git",
//   exact: swiftComposableArchitectureVersion
// )

// let swiftComposableArchitectureBinary = Package.Dependency.package(

// )

// Use external tools (or manual modification) to replace $DEPENDENCY$ placeholder with valid dependency definition. Eg.
// let swiftComposableArchitecture = swiftComposableArchitectureRemote
//let swiftComposableArchitecture = swiftComposableArchitectureBinary
//let swiftComposableArchitecture = #{DEPENDENCY}

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
  dependencies:
    isUsingLocalBinary ? [] : [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.20.2")
  ],
  targets: [
    .target(
      name: "swift-composable-architecture-integration",
      dependencies: isUsingLocalBinary
      ? ["ComposableArchitecture"]
      : [.product(name: "ComposableArchitecture", package: "swift-composable-architecture")]
    ),
    .testTarget(
      name: "swift-composable-architecture-integrationTests",
      dependencies: [
        "swift-composable-architecture-integration"
      ]
    ),
  ] + (isUsingLocalBinary ? [
    .binaryTarget(
      name: "ComposableArchitecture",
      path: "./ComposableArchitecture.xcframework"
    )
  ] : []
  )
)
