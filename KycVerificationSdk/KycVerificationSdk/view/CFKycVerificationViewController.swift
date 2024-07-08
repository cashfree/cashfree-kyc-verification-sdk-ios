//
//  KycVerificationViewController.swift
//  KycVerificationSdk
//
//  Created by Renu Bisht on 24/06/24.
//

import UIKit
import WebKit

@objc
public protocol VerificationResponseDelegate {
    func onVerificationCompletion(verificationResponse: CFVerificationResponse)
    func onErrorResponse(errorReponse: CFErrorResponse)
}

@objc
class CFKycVerificationViewController: UIViewController ,WKNavigationDelegate,WKScriptMessageHandler, WKUIDelegate{
    
    private var session: CFKycVerificationSession
    private var responseDelegate: VerificationResponseDelegate!
    private var currentFieldName: String?
    
    @IBOutlet weak var kycWebView: WKWebView!
    
    @IBOutlet weak var cancelButton: UIButton!
    public init(session: CFKycVerificationSession, callBack: VerificationResponseDelegate){
        self.session = session
        self.responseDelegate = callBack
        super.init(nibName: "CFKycVerificationViewController", bundle: Bundle(for: CFKycVerificationViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebViewConfigurations()
        openWebView()
        
        
    }
    
    private func setupWebViewConfigurations() {
        let webViewConfig = kycWebView.configuration
        let userScript = WKUserScript(source: """
                   var meta = document.createElement('meta');
                   meta.name = 'viewport';
                   meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
                   document.getElementsByTagName('head')[0].appendChild(meta);
               """, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        webViewConfig.userContentController.addUserScript(userScript)
        webViewConfig.userContentController.add(self, name: "nativeProcess")
        
        kycWebView.uiDelegate = self
        kycWebView.backgroundColor = UIColor.white
        kycWebView.navigationDelegate = self
    }
    
    
    func openWebView(){
        let request = URLRequest(url: URL(string:session.getFormUrl())!)
        kycWebView.load(request)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "closeViewController" {
            self.dismiss(animated: true, completion: nil)
        }else{
            guard let messageBody = message.body as? [String: Any],
                  let action = messageBody["action"] as? String,
                  let verificationData = messageBody["data"] as? String else { return }
            let json = verificationData.data(using: .utf8)
            guard let nonNilData = json else {
                print("Data is nil")
                return
            }
            if let webResponse: WebResponse = decodeJSON(from: nonNilData, as: WebResponse.self) {
                switch action {
                case "verificationResponse":
                    onVerificationResponse(webResponse)
                case "webErrors":
                    onWebErrors(webResponse)
                default:
                    break
                }
            }
        }
        
    }
    
    
    func onVerificationResponse(_ data : WebResponse){
        let verificationResponse = CFVerificationResponse()
        verificationResponse.status = data.status
        verificationResponse.form_id = data.form_id
        responseDelegate.onVerificationCompletion(verificationResponse: verificationResponse)
        self.dismiss(animated: true, completion: nil)
    }
    
    func onWebErrors(_ data : WebResponse){
        let errorResponse = CFErrorResponse()
        errorResponse.statusCode = data.statusCode
        errorResponse.message = data.message
        responseDelegate.onErrorResponse(errorReponse: errorResponse)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    private func enableCancelButton(flag: Bool) {
        DispatchQueue.main.async {
            self.cancelButton.isEnabled = flag
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Warning", message: "Are you sure you want to cancel the verification?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true) {
                self?.kycWebView.loadHTMLString("", baseURL: nil)
                
                let errorResponse = CFErrorResponse()
                errorResponse.message = "User cancelled Verification"
                self!.responseDelegate.onErrorResponse(errorReponse: errorResponse)
            }
        }
        let noAction = UIAlertAction(title: "No", style: .default)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true)
    }
    
}
