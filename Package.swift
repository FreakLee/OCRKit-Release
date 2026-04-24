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
            checksum: "ef59e3506c3deaef5b2f9af4e03021e9f19753c11212a8828b43b6279a7e5fb6"
        ),
    ]
)
