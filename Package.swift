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
            checksum: "770ed2351665c59da6c7037c1f009e8496e5bee05f380cbf044367d8f37522ac"
        ),
    ]
)
