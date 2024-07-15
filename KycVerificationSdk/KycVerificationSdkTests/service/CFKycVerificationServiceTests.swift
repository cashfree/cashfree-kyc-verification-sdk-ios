//
//  CFKycVerificationServiceTests.swift
//  KycVerificationSdkTests
//
//  Created by Renu Bisht on 11/07/24.
//

import XCTest
import UIKit
@testable import KycVerificationSdk


class CFKycVerificationServiceTests: XCTestCase {
    
    var service: CFKycVerificationService!
    var mockSession: CFKycVerificationSession!
    var mockViewController: MockViewController!
    var mockDelegate: MockVerificationResponseDelegate!
    var mockNavigationController: MockNavigationController!
    
    
    override func setUp() {
        super.setUp()
      
        do {
            let url = "https://forms.cashfree.com/verification/B5osgk2bver0"
            
            mockSession = try CFKycVerificationSession.Builder().setFormUrl(url).build() // Assuming there's a build method
        } catch {
            XCTFail("Failed to build CFKycVerificationSession: \(error)")
        }
        service = CFKycVerificationService.getInstance()
        mockViewController = MockViewController()
        mockDelegate = MockVerificationResponseDelegate()
        mockNavigationController = MockNavigationController()
       
    }
    
    override func tearDown() {
        service = nil
        mockSession = nil
        mockViewController = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testSingletonInstance() {
        let instance1 = CFKycVerificationService.getInstance()
        let instance2 = CFKycVerificationService.getInstance()
        XCTAssertTrue(instance1 === instance2, "CFKycVerificationService should return the same instance")
    }
    func testDoVerification() {
        mockViewController.navigation = mockNavigationController
            do {
                try service.doVerification(mockSession, mockViewController, mockDelegate)
            } catch {
                XCTFail("Method threw an unexpected error: \(error)")
            }
            
            // Assert
            XCTAssertNotNil(mockNavigationController.pushedViewController, "ViewController should be pushed")
            XCTAssertTrue(mockNavigationController.pushedViewController is CFKycVerificationViewController, "Pushed ViewController should be of type CFKycVerificationViewController")
        }

    
    func testDoVerificationThrowsErrorWhenNoNavigationController() {
        do {
            try service.doVerification(mockSession, mockViewController, mockDelegate)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, "NavigationControllerNotFound")
            XCTAssertEqual((error as NSError).code, 1)
        }
    }
}

class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

class MockViewController: UIViewController {
    var navigation: MockNavigationController?
    
    override var navigationController: UINavigationController? {
        return navigation
    }
}


class MockVerificationResponseDelegate: VerificationResponseDelegate {
    var verificationResponse: CFVerificationResponse?
    var errorResponse: CFErrorResponse?

    func onVerificationCompletion(verificationResponse: CFVerificationResponse) {
        self.verificationResponse = verificationResponse
    }

    func onErrorResponse(errorReponse: CFErrorResponse) {
        self.errorResponse = errorReponse
    }
}


