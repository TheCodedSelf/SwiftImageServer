// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "SwiftImageServer",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1)
    ])
