//
//  KycVerificationError.swift
//  KycVerificationSdk
//
//  Created by Renu Bisht on 26/06/24.
//

import Foundation

@objc public enum KycVerificationError: Int,Error {
    case URL_MISSING
}

extension KycVerificationError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .URL_MISSING:
            return "The \"formUrl\" is missing in the request."
        }}
    public var localizedDescription: String {
        get {
            return self.description
        }
    }
}
