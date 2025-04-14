# Cashfree KYC Verification iOS SDK

![Build](https://badgen.net/badge/build/success/blue?icon=github)
![Version](https://badgen.net/badge/version/1.0.0/blue?icon=github)
![Stars](https://badgen.net/badge/stars/100/green?icon=github)

![Sample Banner Image](https://maven.cashfree.com/images/github-header-image.png)

## **Description**

The Cashfree KYC Verification iOS SDK enables seamless 1-Click onboarding and KYC verification for iOS applications. It allows businesses to quickly verify user identity via a secure and optimized process, reducing drop-offs and ensuring compliance with regulatory standards.

This SDK simplifies the KYC process, allowing you to:
- Trigger verification flows directly within your app.
- Handle permission requests, verification stages, and result callbacks.
- Improve user onboarding experience by reducing manual input and navigation.

👉 For complete integration details, check our [Official Documentation](https://www.cashfree.com/docs/api-reference/vrs/v2/1-click-onboarding/1-click-onboarding-sdk#ios-native).

---

## Table of Contents

1. [Getting Started](#getting-started)
2. [Dependencies](#dependencies)
3. [Installation](#installation)
4. [Usage and Documentation](#usage-and-documentation)  
   - [Initialization](#initialization)  
   - [KYC Verification Flow](#kyc-verification-flow)  
5. [Configuration](#configuration)  
6. [Error Handling](#error-handling)  
7. [Getting Help](#getting-help)  
8. [Open Source Licensing and Other Info](#open-source-licensing-and-other-info)

---

## Getting Started

This guide will walk you through integrating the Cashfree KYC SDK into your iOS application and triggering the KYC verification process with minimal effort.

---

## Dependencies

- Xcode 13.3 or higher
- Swift 5.0+
- iOS 10.0 or later
- Required permissions:
  - `NSCameraUsageDescription`
  - `NSMicrophoneUsageDescription`
  - `NSLocationWhenInUseUsageDescription`

---

## Installation

### Using CocoaPods

Add the following to your `Podfile`:

```ruby
target 'YourApp' do
  use_frameworks!
  pod 'CFSDK', '~> 2.1'
end
```

Then run:

```bash
pod install
```

### Manual Installation

1. Download the latest Cashfree iOS SDK from [GitHub](https://github.com/cashfree/ios-CFWebSDK).
2. Unzip `CFSDK.xcframework.zip` and add the `CFSDK.xcframework` to your Xcode project.
3. Ensure `ENABLE_BITCODE` is set to `YES` in your project's build settings.

---

## Usage and Documentation

### Initialization

Import the SDK in your view controller:

```swift
import CFSDK
```

Initialize the SDK with your `appId` and environment:

```swift
let paymentService = CFPaymentService()
```

### KYC Verification Flow

1. Generate a `cftoken` from your server using the order details.
2. Create a dictionary with the required parameters:

```swift
let params: [String: Any] = [
    "appId": "<YOUR_APP_ID>",
    "orderId": "<ORDER_ID>",
    "orderAmount": "1.00",
    "orderCurrency": "INR",
    "orderNote": "Test Order",
    "customerName": "John Doe",
    "customerPhone": "9999999999",
    "customerEmail": "john.doe@example.com",
    "notifyUrl": "https://yourdomain.com/notify",
    "tokenData": "<CFTOKEN>"
]
```

3. Start the payment process:

```swift
paymentService.doWebCheckoutPayment(
    params: params,
    env: "TEST",
    callback: self
)
```

4. Implement the `ResultDelegate` to handle the response:

```swift
extension YourViewController: ResultDelegate {
    func onPaymentCompletion(msg: String) {
        print("Payment Result: \(msg)")
        // Handle the result here
    }
}
```

---

## Configuration

Ensure the following keys are added to your `Info.plist` with appropriate descriptions:

```xml
<key>NSCameraUsageDescription</key>
<string>We require camera access for KYC verification.</string>
<key>NSMicrophoneUsageDescription</key>
<string>We require microphone access for KYC verification.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>We require location access for KYC verification.</string>
```

---

## Error Handling

Handle errors in the `onPaymentCompletion` method by parsing the `msg` string, which contains the transaction status and message. Always verify the transaction status and take appropriate actions in your app.

---

## Getting Help

If you encounter issues or have questions:

1. File an issue via this repository's **Issues** section.
2. Email us at [care@cashfree.com](mailto:care@cashfree.com)

---

## Open Source Licensing and Other Info

- [TERMS](TERMS.md)
- [LICENSE](https://github.com/cashfree/ios-CFWebSDK/blob/master/LICENSE.md)
- [CODE OF CONDUCT](https://github.com/cashfree/ios-CFWebSDK/blob/master/CODE_OF_CONDUCT.md)
- [SECURITY POLICY](https://github.com/cashfree/ios-CFWebSDK/blob/master/SECURITY.md)
