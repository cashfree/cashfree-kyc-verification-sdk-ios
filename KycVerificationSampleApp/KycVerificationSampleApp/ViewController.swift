//
//  ViewController.swift
//  KycVerificationSampleApp
//
//  Created by Renu Bisht on 24/06/24.
//

import UIKit
import KycVerificationSdk

class ViewController: UIViewController,VerificationResponseDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onVerifyPressed(_ sender: UIButton) {
        do{
            
            let url = "https://forms.cashfree.com/verification/B5osgk2bver0"
            let session = try CFKycVerificationSession.Builder().setFormUrl(url).build()
            let kycService = CFKycVerificationService.getInstance()
            try kycService.doVerification(session, self, self)
        }catch let e{
            
            let error = e as! KycVerificationError
            print(error)
            
        }
        
    }
    
    func onVerificationCompletion(verificationResponse: KycVerificationSdk.CFVerificationResponse) {
        print(verificationResponse.form_id )
        print(verificationResponse.status)
    }
    
    func onErrorResponse(errorReponse: KycVerificationSdk.CFErrorResponse) {
        print(errorReponse.message)
        print(errorReponse.statusCode)
    }
    
    
}

