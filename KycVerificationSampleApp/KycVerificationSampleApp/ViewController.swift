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
        
    }
    
    @IBAction func onVerifyPressed(_ sender: UIButton) {
        do{
            
            //  let url = "https://forms.cashfree.com/verification/B5osgk2bver0"
            let url = "http://192.168.100.152:3000/verification/123"
            let session = try CFKycVerificationSession.Builder().setFormUrl(url).build()
            let kycService = CFKycVerificationService.getInstance()
            try kycService.doVerification(session, self, self)
        }catch let e{
            
            let error = e as! KycVerificationError
            print(error)
            
        }
        
    }
    
    func onVerificationCompletion(verificationResponse: KycVerificationSdk.CFVerificationResponse) {
        if verificationResponse.status == "SUCCESS" {
            showErrorAlert(title:"Success",message: "Verification Succes")
        }else{
            showErrorAlert(title:"Error",message: "Verification failed please try again")
        }
    }
    
    func onErrorResponse(errorReponse: KycVerificationSdk.CFErrorResponse) {
        showErrorAlert(title:"Error",message: errorReponse.message ?? "")
    }
    
    func showErrorAlert(title:String,message: String) {
        if let presentedVC = self.presentedViewController {
            presentedVC.dismiss(animated: true) { [weak self] in
                self?.presentAlert(title:title,message: message)
            }
        } else {
            presentAlert(title:title,message: message)
        }
        
    }
    private func presentAlert(title:String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

