// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "OCRKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "OCRKit", targets: ["OCRKit"]),
    ],
    targets: [
        .binaryTarget(
            name: "OCRKit",
            url: "https://github.com/FreakLee/OCRKit-Release/releases/download/v1.0.0/OCRKit.xcframework.zip",
            checksum: "ebcce07bc8ea91fdb67cf71e7dc79360d62d2839c5c6e97e50bc41c435a9308f"
        ),
    ]
)
