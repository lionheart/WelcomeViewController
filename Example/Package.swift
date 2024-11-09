// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "WelcomeViewController",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "WelcomeViewController",
            targets: ["WelcomeViewController"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/lionheart/SuperLayout.git", from: "4.0.0"),
        .package(url: "https://github.com/lionheart/LionheartExtensions.git", from: "6.0.0")
    ],
    targets: [
        .target(
            name: "WelcomeViewController",
            dependencies: [
                .product(name: "SuperLayout", package: "SuperLayout"),
                .product(name: "LionheartExtensions", package: "LionheartExtensions")
            ],
            path: "WelcomeViewController",
            sources: ["Classes", "Protocols"],
            publicHeadersPath: ""
        ),
        .testTarget(
            name: "WelcomeViewControllerTests",
            dependencies: ["WelcomeViewController"]
        ),
    ]
)
