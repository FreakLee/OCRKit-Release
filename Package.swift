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
            checksum: "d028c6ad1b20f5628410115b630eed6c9feb457c88741351963af7bc89294963"
        ),
    ]
)
