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
pod 'KycVerificationSdk', '~> 1.0.1'

```

Then run:

```bash
pod install
```

---

## Usage and Documentation


### Initialization

To initialise and use the iOS native SDK:

1. Create an instance of the `CFVerificationService` class:

```swift
let kycService = CFVerificationService.getInstance()
```

2. Set up callback handlers by implementing the `CFResponseDelegate` protocol:

```swift
extension ViewController: CFResponseDelegate {
    func onVerification(_ verificationResponse: KycVerificationSdk.CF1ClickOnboardingResponse) {
        showErrorAlert(title: "Verification Success", message: verificationResponse.verificationId ?? "N/A")
    }

    func onVerificationError(_ errorResponse: KycVerificationSdk.CF1ClickOnboardingErrorResponse) {
        showErrorAlert(title: "Verification Error", message: errorResponse.status ?? "N/A")
    }

    func onUserDrop(_ userDropResponse: KycVerificationSdk.CFUserDropResponse) {
        showErrorAlert(title: "User Dropped", message: userDropResponse.verificationId ?? "N/A")
    }
}
```

3. Initiate the 1-Click Onboarding SDK:

```swift
do {
    let environment = Environment.PROD // or Environment.TEST
    try kycService.open1ClickOnboarding(sessionId, environment, self, self)
} catch let e {
    let error = e as! VerificationError
    print(error)
}
```

**Parameters**:
- `sessionId`: A unique identifier for the session.
- `environment`: Specifies the environment. Values: `Environment.TEST` or `Environment.PROD`

---

## Callback Structure

Example response from the SDK:

```json
{
  "verification_id": "verification_id_value",
  "auth_code": "auth_code_value",
  "status": "SUCCESS"
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

Use the delegate methods to handle success, error, and user drop events as shown above.

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
