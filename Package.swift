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
            url: "https://github.com/FreakLee/OCRKit-Release/releases/download/v1.1.1/OCRKit.xcframework.zip",
            checksum: "e1445ea3fb10c8ce877d1982926ebe73133c2518ceb9069b6fb0f1bd4d76b19d"
        ),
    ]
)
