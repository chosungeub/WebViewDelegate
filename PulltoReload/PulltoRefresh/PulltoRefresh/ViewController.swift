//
//  ViewController.swift
//  PulltoRefresh
//
//  Created by 비알스톰 on 2021/06/01.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("======================== Start Main View Did Load ========================")
        
        @IBOutlet weak var webView: WKWebView!
        @IBOutlet weak var outputtext: UILabel!

    }
    

    
    
   
}






