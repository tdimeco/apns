// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "apns-cli",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .executable(name: "apns", targets: ["APNSCli"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.8.0"),
        .package(url: "https://github.com/swift-server-community/APNSwift.git", from: "7.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "APNSCli",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "APNS", package: "apnswift"),
            ],
        ),
    ],
)
