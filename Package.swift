// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "mail-aws-driver",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        .library(name: "MailAwsDriver", targets: ["MailAwsDriver"]),
    ],
    dependencies: [
        .package(url: "https://github.com/binarybirds/mail-kit.git", from: "0.0.1"),
        .package(url: "https://github.com/soto-project/soto.git", from: "5.11.0"),
    ],
    targets: [
        .target(name: "MailAwsDriver", dependencies: [
            .product(name: "MailKit", package: "mail-kit"),
            .product(name: "SotoSES", package: "soto"),
        ]),
        .testTarget(name: "MailAwsDriverTests", dependencies: [
            .target(name: "MailAwsDriver"),
        ]),
    ]
)
