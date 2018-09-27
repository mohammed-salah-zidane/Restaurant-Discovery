//
//  WebViewController.swift
//  Restaurant DiscoveryPin
//
//  Created by Mohamed Salah Zidane on 9/27/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController ,WKUIDelegate{

     var webView:WKWebView!
  
    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        
        self.view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       webView.goForward()
       webView.goForward()
        // Do any additional setup after loading the view.
        if  let url = URL(string: "https://www.appcoda.com/"){
            let request  = URLRequest(url: url)
            webView.load(request)
        }
    
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
