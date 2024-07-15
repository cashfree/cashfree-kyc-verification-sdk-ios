//
//  KycVerificationErrorTests.swift
//  KycVerificationSdkTests
//
//  Created by Renu Bisht on 11/07/24.
//

import XCTest
@testable import KycVerificationSdk

class KycVerificationErrorTests: XCTestCase {
    
    func testURLMissingDescription() {
        let error = KycVerificationError.URL_MISSING
        XCTAssertEqual(error.description, "The \"formUrl\" is missing in the request.")
    }
    
    func testURLMissingLocalizedDescription() {
        let error = KycVerificationError.URL_MISSING
        XCTAssertEqual(error.localizedDescription, "The \"formUrl\" is missing in the request.")
    }
}
