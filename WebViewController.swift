//
//  WebViewController.swift
//  Project16
//
//  Created by othman shahrouri on 9/18/21.
//

import UIKit
import WebKit
class WebViewController: UIViewController,WKNavigationDelegate {
    var webView:WKWebView!
    var urlString:String!
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(urlString)
        if let url = URL(string: urlString){
            webView.load(URLRequest(url: url))
        }
        
    }
    

   

}
