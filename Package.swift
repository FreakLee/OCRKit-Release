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
            url: "https://github.com/FreakLee/OCRKit-Release/releases/download/v1.1.0/OCRKit.xcframework.zip",
            checksum: "cfca8ad94deec5b0a90506dfe636775d21445002136c2e3c6212d4e707f7e142"
        ),
    ]
)
