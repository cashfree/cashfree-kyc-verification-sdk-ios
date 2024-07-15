//
//  DecodeJSONTests.swift
//  KycVerificationSdkTests
//
//  Created by Renu Bisht on 11/07/24.
//

import XCTest
@testable import KycVerificationSdk

class DecodeJSONTests: XCTestCase {
    
    func testDecodeValidJSON() {
        let jsonString = """
        {
            "status": "SUCCESS",
            "form_id": "123",
            "message": "Something went wrong",
            "statusCode": 400
        }
        """
        let jsonData = jsonString.data(using: .utf8)!
        
        let response: WebResponse? = decodeJSON(from: jsonData, as: WebResponse.self)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.status, "SUCCESS")
        XCTAssertEqual(response?.form_id, "123")
        XCTAssertEqual(response?.message, "Something went wrong")
        XCTAssertEqual(response?.statusCode, 400)
    }
    

}
