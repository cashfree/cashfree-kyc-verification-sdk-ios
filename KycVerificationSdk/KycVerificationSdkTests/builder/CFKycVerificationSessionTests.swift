//
//  CFKycVerificationSessionTests.swift
//  KycVerificationSdkTests
//
//  Created by Renu Bisht on 11/07/24.
//

import XCTest
@testable import KycVerificationSdk

class CFKycVerificationSessionTests: XCTestCase {
    
    func testSetFormUrl() {
        let builder = CFKycVerificationSession.Builder()
        builder.setFormUrl("https://example.com")
        XCTAssertEqual(builder.getFormUrl(), "https://example.com")
    }
    
    func testBuildWithValidUrl() {
        let builder = CFKycVerificationSession.Builder()
        builder.setFormUrl("https://example.com")
        
        do {
            let session = try builder.build()
            XCTAssertEqual(session.getFormUrl(), "https://example.com")
        } catch {
            XCTFail("Expected to build session without error, but got \(error)")
        }
    }
    
    func testBuildWithoutUrlThrowsError() {
        let builder = CFKycVerificationSession.Builder()
        
        XCTAssertThrowsError(try builder.build()) { error in
            XCTAssertEqual(error as? KycVerificationError, KycVerificationError.URL_MISSING)
        }
    }
}
