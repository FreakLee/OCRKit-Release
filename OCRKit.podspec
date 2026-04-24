Pod::Spec.new do |s|
  # ⚠️ 此文件由 CI 自动生成，请勿手动修改。
  s.name             = 'OCRKit'
  s.version          = '1.0.0'
  s.summary          = 'iOS OCR SDK — 银行卡、身份证实时识别。'
  s.description      = <<-DESC
    OCRKit 基于 Apple Vision 框架，提供实时卡片检测与 OCR 识别能力，
    支持银行卡、身份证等证件的自动拍摄与信息提取。
  DESC

  s.homepage         = 'https://github.com/FreakLee/OCRKit-Release'
  s.license          = { :type => 'Commercial', :text => 'Copyright © 2026 All rights reserved.' }
  s.author           = { 'Lee min' => '1279316181@qq.com' }

  # 二进制分发：直接指向 GitHub Release 的 zip
  s.source           = {
    :http => 'https://github.com/FreakLee/OCRKit-Release/releases/download/v1.0.0/OCRKit.xcframework.zip'
  }

  s.ios.deployment_target = '15.0'
  s.vendored_frameworks   = 'OCRKit.xcframework'

  # OCRKit 使用的系统框架（CocoaPods 需要显式声明）
  s.frameworks = 'Vision', 'AVFoundation', 'UIKit'

  # Swift 版本要求
  s.swift_versions = ['5.7', '5.8', '5.9', '5.10']
end
