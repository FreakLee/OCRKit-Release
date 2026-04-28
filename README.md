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
pod 'OCRKit'
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
import UIKit
import OCRKit

class ViewController: UIViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startScan()
    }

    func startScan() {
        Task {
            do {
                let result = try await OCRKitSDK.shared.scanBankCard(from: self)
                print("卡号：\(result.info.cardNumber)")
                print("发卡行：\(result.info.bankName ?? "未识别")")
            } catch OCRError.cancelled {
                // 用户取消
            } catch {
                print("识别失败：\(error)")
            }
        }
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
<string>需要访问相机以扫描身份证和银行卡</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>需要访问相册以选择身份证和银行卡图片</string>
```

---

## 版本历史

请查看 [Releases](https://github.com/FreakLee/OCRKit-Release/releases)。
