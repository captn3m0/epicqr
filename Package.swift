// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "EpicQR",
    products: [
        .library(
            name: "EpicQR",
            targets: ["EpicQR"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto.git",  from:"3.1.0")
    ],
    targets: [
        .target(
            name: "EpicQR",
            dependencies: [
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "_CryptoExtras", package: "swift-crypto"),
            ]
        ),
        .testTarget(
            name: "EpicQRTests",
            dependencies: ["EpicQR"]),
    ]
)