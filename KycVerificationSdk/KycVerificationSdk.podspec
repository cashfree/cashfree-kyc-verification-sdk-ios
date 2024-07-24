#
#  Be sure to run `pod spec lint KycVerificationSdk.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "KycVerificationSdk"
  s.version      = "1.0.1"
  s.summary      = "Cocoapods implementation of Cashfree Kyc Verification SDK"
  
  s.description  = <<-DESC
                   Cashfree Kyc verification sdk help businesses in verifying kyc details of there users
                    DESC
  s.homepage     = "https://cashfree.com"
  s.license      = "MIT"
  s.author             = { "Cashfree Payments" => "developers@cashfree.com" }
  s.source       = { :git => "https://github.com/cashfree/cashfree-kyc-verification-sdk-ios.git", :tag =>  s.version.to_s }
  s.social_media_url    = "https://twitter.com/gocashfree"
  s.platform        = :ios, "16.4"
  s.vendored_frameworks    = "KycVerificationSdk.xcframework"
  s.swift_version        = "5.9"
  
end
