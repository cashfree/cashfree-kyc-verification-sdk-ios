//
//  CFKycVerificationViewControllerTests.swift
//  KycVerificationSdkTests
//
//  Created by Renu Bisht on 12/07/24.
//

import XCTest

@testable import KycVerificationSdk


class CFKycVerificationViewControllerTests: XCTestCase {
    
    var viewController: CFKycVerificationViewController!
    var mockDelegate: MockVerificationResponseDelegate!
    var mockSession: CFKycVerificationSession!
    
    override func setUp() {
        super.setUp()
        mockDelegate = MockVerificationResponseDelegate()
        
        do {
            mockSession = try CFKycVerificationSession.Builder().setFormUrl("https://mockurl.com").build()
        } catch {
            XCTFail("Failed to build mock session")
        }

        viewController = CFKycVerificationViewController(session: mockSession, callBack: mockDelegate)
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        mockDelegate = nil
        mockSession = nil
        super.tearDown()
    }

    func testViewDidLoad() {
        XCTAssertNotNil(viewController.kycWebView)
        XCTAssertEqual(viewController.kycWebView.accessibilityIdentifier, "kycWebView")
    }


    
    func testOnVerificationResponse() {
        let webResponse = WebResponse(status: "success", form_id: "1234", message: nil, statusCode: nil)
        viewController.onVerificationResponse(webResponse)
        
        XCTAssertNotNil(mockDelegate.verificationResponse)
        XCTAssertEqual(mockDelegate.verificationResponse?.status, "success")
        XCTAssertEqual(mockDelegate.verificationResponse?.form_id, "1234")
    }
    
    func testOnWebErrors() {
        let webResponse = WebResponse(status: nil, form_id: nil, message: "Bad Request", statusCode: 400)
        viewController.onWebErrors(webResponse)
        
        XCTAssertNotNil(mockDelegate.errorResponse)
        XCTAssertEqual(mockDelegate.errorResponse?.statusCode, 400)
        XCTAssertEqual(mockDelegate.errorResponse?.message, "Bad Request")
    }
}

// Helper extension to simulate button taps
extension UIAlertAction {
    func tap() {
        guard let block = value(forKey: "handler") as? ((UIAlertAction) -> Void) else { return }
        block(self)
    }
}
