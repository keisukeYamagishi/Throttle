#
#  Be sure to run `pod spec lint throttle.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "Throtlle"
  spec.version      = "1.0.0"
  spec.summary      = "The throttle"
  spec.description  = <<-DESC
                          The throttle function prevents the execution of a specified process for a designated time interval after the initial execution.
                   DESC
  spec.homepage     = "https://github.com/keisukeYamagishi/Throttle"
  spec.license      = "MIT"
  spec.author             = { "keisukeYamagishi" => "jam330257@gmail.com" }
  spec.source       = { :git => "https://github.com/keisukeYamagishi/Throttle.git", :tag => "#{spec.version}" }
  spec.ios.deployment_target = "12.0"
  spec.tvos.deployment_target = "12.0"
  spec.osx.deployment_target = "10.14"
  spec.watchos.deployment_target = "5.0"
  spec.swift_version = '5.0'
  spec.source_files  = "Source", "Sources/Throttle/**/*.swift"
  spec.static_framework = true
  spec.framework = "Foundation"
end
