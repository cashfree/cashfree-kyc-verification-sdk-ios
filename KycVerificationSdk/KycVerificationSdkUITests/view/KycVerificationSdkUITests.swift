//
//  KycVerificationSdkUITests.swift
//  KycVerificationSdkUITests
//
//  Created by Renu Bisht on 11/07/24.
//

import XCTest

class KycVerificationSdkUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testKycVerificationViewController() throws {
        // Assuming the view controller is presented modally
        let kycWebView = app.webViews["kycWebView"]
        XCTAssertTrue(kycWebView.waitForExistence(timeout: 10), "The KYC WebView should exist.")
        
        // Test cancel button interaction
        let cancelButton = app.buttons["cancelButton"]
        XCTAssertTrue(cancelButton.exists, "The cancel button should exist.")
        cancelButton.tap()
        
        // Verify alert is presented
        let alert = app.alerts["Warning"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "A warning alert should be presented.")
        
        // Tap the 'Yes' action in the alert to cancel the verification
        let yesButton = alert.buttons["Yes"]
        XCTAssertTrue(yesButton.exists, "The 'Yes' button in the alert should exist.")
        yesButton.tap()
        
        // Verify that the view controller is dismissed
        XCTAssertFalse(kycWebView.exists, "The KYC WebView should be dismissed after cancellation.")
        
        // Additional checks can be added here based on the expected behavior
    }
}

