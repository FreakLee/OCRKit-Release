# OCRKit

iOS OCR SDK，基于 Apple Vision 框架，纯Swift，一行代码搞定银行卡、身份证、二维码、条形码实时检测与识别。

- ✅ 实时矩形检测
- ✅ 银行卡
- ✅ 身份证
- ✅ 二维码
- ✅ 条形码
- ✅ 支持实时扫描、相册两种模式
- ✅ 支持深色/低对比度卡片、模糊 + 凸印卡、倾斜拍摄等复杂场景
- ✅ 纯 Swift，无第三方依赖
- ✅ iOS 15+，支持 arm64 真机与模拟器
- ✅ 动态显示手动拍照按钮
- ✅ 自动曝光

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
    .package(url: "https://github.com/FreakLee/OCRKit-Release", from: "1.1.1"),
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

## 速度

常规卡基本秒识别。
![速度](https://github.com/FreakLee/OCRKit-Release/blob/main/Example/Snapshots/SD.JPG)

---

## 复杂场景

**模糊 + 凸印卡**：浮雕数字光线不均匀，识别失败后自动切换增强模式，并显示拍照按钮让用户主动补拍。

![模糊](https://github.com/FreakLee/OCRKit-Release/blob/main/Example/Snapshots/MS.PNG)

**倾斜拍摄**：内置透视矫正，歪着拍也能识别，最大支持 45° 倾斜。

![倾斜](https://github.com/FreakLee/OCRKit-Release/blob/main/Example/Snapshots/IDCard.PNG)

**深色 / 低对比度卡**：自适应分析图像亮度和对比度，黑卡、白金卡各自使用不同的增强参数，不靠固定值硬猜。

![深色](https://github.com/FreakLee/OCRKit-Release/blob/main/Example/Snapshots/ABC.PNG)

---

## 顶级场景
自有卡片30多张，以及网上试过超百张卡片，属我的中行卡最难。

**中行弱光情况下:**
![中行_dark](https://github.com/FreakLee/OCRKit-Release/blob/main/Example/Snapshots/BOC_dark.JPG)

**中行强光情况下:**
![中行_light](https://github.com/FreakLee/OCRKit-Release/blob/main/Example/Snapshots/BOC_light.JPG)

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

## 一个有意思的偶发现象
晚上关闭灯光，仅靠电脑屏幕和手机手电筒，上面那张复杂民生卡在这个 SDK 里可以识别成功，而微信连续错了两次。

**当时的环境：**
![背景](https://github.com/FreakLee/OCRKit-Release/blob/main/Example/Snapshots/BJ_dark.JPG)

**本 SDK 识别结果：**
![民生_暗光](https://github.com/FreakLee/OCRKit-Release/blob/main/Example/Snapshots/MS_dark.JPG)

**微信添加银行卡识别结果：**

* 微信一
![微信一](https://github.com/FreakLee/OCRKit-Release/blob/main/Example/Snapshots/WeChat_1.JPG)

* 微信二
![微信二](https://github.com/FreakLee/OCRKit-Release/blob/main/Example/Snapshots/WeChat_2.JPG)

---

## 文章介绍
1.[iOS 银行卡识别，我把最难的部分都替你踩过了](https://mp.weixin.qq.com/s/NRMe4QRZFA-radsw2XeOcQ)
2.[两个改动，让这个iOS SDK识别成功率翻了一倍](https://mp.weixin.qq.com/s/AnZRUtEvdmlDVMY-UQi0ig)

## 版本历史

请查看 [Releases](https://github.com/FreakLee/OCRKit-Release/releases)。
