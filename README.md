# OCRKit

iOS OCR SDK，基于 Apple Vision 框架，支持银行卡实时检测与识别。

- ✅ 实时矩形检测（自动对焦、稳定触发）
- ✅ 银行卡号、有效期识别
- ✅ 支持深色/低对比度卡片
- ✅ 纯 Swift，无第三方依赖
- ✅ iOS 15+，支持 arm64 真机与模拟器

---

## 安装

### Swift Package Manager（推荐）

在 Xcode 中：**File → Add Package Dependencies**，填入：

```
https://github.com/FreakLee/OCRKit-Release
```

或在 `Package.swift` 中添加：

```swift
dependencies: [
    .package(url: "https://github.com/FreakLee/OCRKit-Release", from: "1.0.0"),
],
targets: [
    .target(name: "YourApp", dependencies: ["OCRKit"]),
]
```

### CocoaPods

在 `Podfile` 中添加：

```ruby
pod 'OCRKit', '~> 1.0'
```

然后运行：

```bash
pod install
```

### 手动集成

1. 前往 [Releases](https://github.com/FreakLee/OCRKit-Release/releases) 下载最新的 `OCRKit.xcframework.zip`
2. 解压，将 `OCRKit.xcframework` 拖入 Xcode 项目
3. 在 Target → General → Frameworks, Libraries, and Embedded Content 中设置为 **Embed & Sign**

---

## 快速开始

```swift
import OCRKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startScan()
    }

    func startScan() {
        let config = OCRScannerConfig(mode: .bankCard)
        let scanner = OCRScannerViewController(config: config)
        scanner.onResult = { result in
            switch result {
            case .success(let card):
                print("卡号：\(card.cardNumber ?? "未识别")")
                print("有效期：\(card.expiryDate ?? "未识别")")
            case .failure(let error):
                print("识别失败：\(error)")
            }
        }
        present(scanner, animated: true)
    }
}
```

---

## 系统要求

| 要求 | 版本 |
|------|------|
| iOS | 15.0+ |
| Xcode | 14.0+ |
| Swift | 5.7+ |

所需系统权限（在 `Info.plist` 中声明）：

```xml
<key>NSCameraUsageDescription</key>
<string>需要访问相机以扫描银行卡</string>
```

---

## 版本历史

请查看 [Releases](https://github.com/FreakLee/OCRKit-Release/releases)。
