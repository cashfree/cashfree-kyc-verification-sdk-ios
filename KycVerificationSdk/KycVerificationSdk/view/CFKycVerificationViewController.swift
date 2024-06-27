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
    func onVerificationCompletion(msg: String)
}

@objc
class CFKycVerificationViewController: UIViewController ,WKNavigationDelegate,WKScriptMessageHandler, WKUIDelegate{
    
    private var session: CFKycVerificationSession
    private var responseDelegate: VerificationResponseDelegate!
    
    
    @IBOutlet weak var kycWebView: WKWebView!
    
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
        kycWebView.configuration.userContentController.add(self, name: "nativeProcess")
        kycWebView.uiDelegate = self
        kycWebView.backgroundColor = UIColor.white
        kycWebView.navigationDelegate = self
    }
    
    
    func openWebView(){
        let request = URLRequest(url: URL(string:session.getFormUrl())!)
        kycWebView.load(request)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start to Load")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finish to load")
        responseDelegate.onVerificationCompletion(msg: "test this")
        
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // Handle callback from web view
    }
}
