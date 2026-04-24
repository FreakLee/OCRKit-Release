Pod::Spec.new do |s|
  s.name             = 'OCRKit'
  s.version          = '1.0.0'
  s.summary          = 'OCR scanning SDK for iOS — bank card, ID card recognition.'
  s.description      = <<-DESC
    OCRKit provides real-time card detection and OCR recognition using Apple Vision framework.
  DESC
  s.homepage         = 'https://github.com/FreakLee/OCRKit-Release'
  s.license          = { :type => 'Commercial', :text => 'Copyright 2026 All rights reserved.' }
  s.author           = { 'Lee min' => '1279316181@qq.com' }
  s.source           = { :http => 'https://github.com/FreakLee/OCRKit-Release/releases/download/v1.0.0/OCRKit.xcframework.zip' }
  s.ios.deployment_target = '15.0'
  s.vendored_frameworks = 'OCRKit.xcframework'
  s.frameworks = 'Vision', 'AVFoundation', 'UIKit'
end
