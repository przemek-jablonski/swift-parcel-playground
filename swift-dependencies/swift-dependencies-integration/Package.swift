// swift-tools-version: 5.10.0

import PackageDescription

// Use external tools (or manual modification) to replace $VERSION$ placeholder with valid tag / version. Eg.
let swiftDependenciesVersion: Version = "1.9.2"
//let swiftDependenciesVersion: Version = #{VERSION}

let swiftDependenciesUrl = "https://github.com/pointfreeco/swift-dependencies.git"


let isUsingLocalBinary = false

let swiftDependenciesTarget: Target.Dependency = isUsingLocalBinary
? "Dependencies"
: .product(name: "Dependencies", package: "swift-dependencies")

// let swiftDependenciesRemote = Package.Dependency.package(
//   url: "https://github.com/pointfreeco/swift-dependencies.git",
//   exact: swiftDependenciesVersion
// )

// let swiftDependenciesBinary = Package.Dependency.package(

// )

// Use external tools (or manual modification) to replace $DEPENDENCY$ placeholder with valid dependency definition. Eg.
// let swiftDependencies = swiftDependenciesRemote
//let swiftDependencies = swiftDependenciesBinary
//let swiftDependencies = #{DEPENDENCY}

let package = Package(
  name: "swift-dependencies-integration",
  platforms: [
    .iOS(.v13),
    .macOS(.v14),
    .tvOS(.v13),
    .watchOS(.v6)
  ],
  products: [
    .library(
      name: "swift-dependencies-integration",
      targets: [
        "swift-dependencies-integration"
      ]
    ),
  ],
  dependencies:
    isUsingLocalBinary ? [] : [
    .package(url: swiftDependenciesUrl, exact: swiftDependenciesVersion)
  ],
  targets: [
    .target(
      name: "swift-dependencies-integration",
      dependencies: isUsingLocalBinary
      ? ["Dependencies"]
      : [.product(name: "Dependencies", package: "swift-dependencies")]
    ),
    .testTarget(
      name: "swift-dependencies-integrationTests",
      dependencies: [
        "swift-dependencies-integration"
      ]
    ),
  ] + (isUsingLocalBinary ? [
    .binaryTarget(
      name: "Dependencies",
      path: "./Dependencies.xcframework"
    )
  ] : []
  )
)
