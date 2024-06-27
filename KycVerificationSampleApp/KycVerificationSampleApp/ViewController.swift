//
//  ViewController.swift
//  KycVerificationSampleApp
//
//  Created by Renu Bisht on 24/06/24.
//

import UIKit
import KycVerificationSdk

class ViewController: UIViewController,VerificationResponseDelegate {
    
    func onVerificationCompletion(msg: String) {
        print("response \(msg)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onVerifyPressed(_ sender: UIButton) {
        do{
            let session = try CFKycVerificationSession.Builder().setFormUrl("https://forms.cashfree.com/verification/B5osgk2bver0").build()
            let kycService = CFKycVerificationService.getInstance()
            try kycService.doVerification(session, self, self)
        }catch let e{
            let error = e as! KycVerificationError
        }
        
    }
    
}

