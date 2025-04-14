# Cashfree KYC Verification Android SDK

![Build](https://badgen.net/badge/build/success/blue?icon=github)
![Version](https://badgen.net/badge/version/1.0.0/blue?icon=github)
![Stars](https://badgen.net/badge/stars/100/green?icon=github)

![Sample Banner Image](https://maven.cashfree.com/images/github-header-image.png)

## **Description**

The Cashfree KYC Verification Android SDK enables seamless 1-Click onboarding and KYC verification for Android applications. It allows businesses to quickly verify user identity via a secure and optimized process, reducing drop-offs and ensuring compliance with regulatory standards.

This SDK simplifies the KYC process, allowing you to:
- Trigger verification flows directly within your app.
- Handle permission requests, verification stages, and result callbacks.
- Improve user onboarding experience by reducing manual input and navigation.

👉 For complete integration details, check our [Official Documentation](https://www.cashfree.com/docs/api-reference/vrs/v2/1-click-onboarding/1-click-onboarding-sdk#android-native).

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

This guide will walk you through integrating the Cashfree KYC SDK into your Android application and triggering the KYC verification process with minimal effort.

---

## Dependencies

- Android Studio Bumblebee or higher
- `minSdkVersion` 21
- Kotlin 1.6+ or Java 8+
- Required permissions:
  - `CAMERA`
  - `RECORD_AUDIO`
  - `ACCESS_FINE_LOCATION`
  - `READ_CALENDAR` *(only if adding calendar events is needed)*

---

## Installation

### Step 1: Add Maven repository

In `settings.gradle.kts`:

```kotlin
repositories {
    google()
    mavenCentral()
    maven { url = URI("https://maven.cashfree.com/release") }
}
```

### Step 2: Add SDK dependency

In `build.gradle.kts`:

```kotlin
dependencies {
    implementation("com.cashfree.vrs:kyc-verification:1.0.0")
}
```

Click **Sync Now** in Android Studio to sync the project.

---

## Usage and Documentation

### Initialization

Create an instance of the verification service:

```kotlin
val verificationService = CFVerificationService.Builder()
    .setContext(this) // Pass the context
    .build()
```

### Callback Configuration

Configure the callback to handle responses:

```kotlin
verificationService.set1ClickOnboardingCallback(object : CF1ClickOnboardingCallback {
    override fun onVerification(response: CF1ClickOnboardingResponse) {
        // Handle success
    }

    override fun onVerificationError(error: CF1ClickOnboardingErrorResponse) {
        // Handle error
    }

    override fun onUserDrop(error: CFUserDropResponse) {
        // Handle user drop
    }
})
```

### Launching Verification

Initiate the 1-Click Onboarding SDK:

```kotlin
verificationService.open1ClickOnboarding(sessionId, Environment.TEST)
```

**Parameters**:
- `sessionId`: Unique session identifier
- `Environment`: `Environment.TEST` or `Environment.PROD`

---

## Configuration

Add required permissions in your `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.READ_CALENDAR"/>
```

Make sure to request runtime permissions before starting the verification process.

---

## Error Handling

Errors can be handled through the `onVerificationError` and `onUserDrop` callbacks. Always provide user feedback or retry options for a smooth UX.

---

## Getting Help

If you have questions, concerns, or bug reports, you can reach out through the following channels:

1. File an issue via this repository's **Issues** section.
2. Email us at [care@cashfree.com](mailto:care@cashfree.com)

---

## Open Source Licensing and Other Info

- [TERMS](TERMS.md)
- [LICENSE](https://github.com/cashfree/nextgen-android/blob/master/LICENSE.md)
- [CODE OF CONDUCT](https://github.com/cashfree/nextgen-android/blob/master/CODE_OF_CONDUCT.md)
- [SECURITY POLICY](https://github.com/cashfree/nextgen-android/blob/master/SECURITY.md)
