// swift-tools-version: 5.10
import PackageDescription

let package = Package(
  name: "Path",
  platforms: [.iOS(.v17)],
  products: [
    .library(name: "ChildFeature", targets: ["ChildFeature"]),
    .library(name: "FeatureStates", targets: ["FeatureStates"]),
    .library(name: "Root", targets: ["Root"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.8.0"),
  ],
  targets: [
    .target(
      name: "ChildFeature",
      dependencies: [
        "FeatureStates",
        .composableArchitecture
      ]
    ),
    .target(
      name: "FeatureStates",
      dependencies: [
        .composableArchitecture
      ]
    ),
    .target(
      name: "Root",
      dependencies: [
        "ChildFeature",
        "FeatureStates",
        .composableArchitecture
      ]
    ),
  ]
)

extension Target.Dependency {
  static let composableArchitecture = Target.Dependency.product(
    name: "ComposableArchitecture",
    package: "swift-composable-architecture"
  )
}
