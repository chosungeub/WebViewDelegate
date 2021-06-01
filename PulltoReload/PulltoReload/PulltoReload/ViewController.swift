//
//  ViewController.swift
//  PulltoReload
//
//  Created by 비알스톰 on 2021/06/01.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func back() {
        if self.webView.canGoBack{
            self.webView.goBack()
        }
    }
    
    @IBAction func forward() {
        if self.webView.canGoForward {
            self.webView.goForward()
        }
    }
    
    func request(url: String) {
        self.webView.load(URLRequest(url: URL(string: url)!))
        self.webView.navigationDelegate = self
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.request(url: searchBar.text!)
        
        self.view.endEditing(true)
    }
}

extension ViewController: WKNavigationDelegate {
    
    // loading 완료시 호출
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.searchBar.text = webView.url?.absoluteString
    }
    
    // loading 시작시 호출
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // 로딩 아이콘 표시 숨기기 등등
    }
    
    // loading 실패시
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        //
    }
    
    //WKWEbView HTTPURLResponse정보를 확인하는 딜리게이트 함수
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if(navigationResponse.response is HTTPURLResponse) {
            let response = navigationResponse.response as? HTTPURLResponse
            print(String(format: "response.statusCode: %Id", response?.statusCode ?? 0))
        }
        
        decisionHandler(.allow)
    }
    

}

