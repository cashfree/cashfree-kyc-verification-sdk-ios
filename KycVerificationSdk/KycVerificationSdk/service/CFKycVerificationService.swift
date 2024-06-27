//
//  CFKycVerificationService.swift
//  KycVerificationSdk
//
//  Created by Renu Bisht on 25/06/24.
//

import Foundation
import UIKit

@objc
final public class CFKycVerificationService : NSObject{
    
    static let shared = CFKycVerificationService()
    
    private override init(){}
    
    static public func getInstance() -> CFKycVerificationService {
        return CFKycVerificationService.shared
    }
    
    @objc
    public func doVerification(_ session: CFKycVerificationSession,_ viewController: UIViewController,_ callback: VerificationResponseDelegate) throws{
        let vc = CFKycVerificationViewController(session: session, callBack: callback)
        viewController.present(vc, animated: true, completion: nil)
        
    }
    
    
}
