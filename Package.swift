// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "apns-cli",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "apns", targets: ["apns-cli"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.3.0"),
        .package(url: "https://github.com/swift-server-community/APNSwift.git", from: "5.0.0"),
        .package(url: "https://github.com/Flight-School/AnyCodable", from: "0.6.0"),
    ],
    targets: [
        .executableTarget(
            name: "apns-cli",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "APNS", package: "apnswift"),
                .product(name: "AnyCodable", package: "AnyCodable"),
            ]
        ),
    ]
)
