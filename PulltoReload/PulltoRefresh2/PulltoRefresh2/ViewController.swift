//
//  ViewController.swift
//  PulltoRefresh2
//
//  Created by 비알스톰 on 2021/06/01.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    
    @IBOutlet weak var webView: WKWebView!
    override func loadView() {
        super.loadView()
        
        webView = WKWebView(frame: self.view.frame)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad Call")
        
        createWebView()
        
        let url = URL(string: "https://devm.dibidibi.com:454")
        let request = URLRequest(url: url!)
        webView.configuration.preferences.javaScriptEnabled = true
        webView.load(request)
        print("WebView main method url", request)
        
        //webView.setPullToRefresh(type: .embed)
        webView.setPullToRefresh(type: .custom(target: self, selector: #selector(customPullToRefreshHandler(source:))))
      
    }
    
    private func createWebView() {
            let webView = WKWebView(frame: .zero, configuration: .init())
            view.addSubview(webView)
            webView.navigationDelegate = self
            self.webView = webView
            webView.translatesAutoresizingMaskIntoConstraints = false
            webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: webView.bottomAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: webView.rightAnchor).isActive = true
    }
    
    @objc func customPullToRefreshHandler(source: UIRefreshControl) {
        guard let url = webView.url else { source.endRefreshing(); return }
        webView.load(URLRequest(url: url))
        print("WebView started loading => ", url)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

extension WKWebView {

    var refreshControl: UIRefreshControl? { (scrollView.getAllSubviews() as [UIRefreshControl]).first }

    enum PullToRefreshType {
        case none
        case embed
        case custom(target: Any, selector: Selector)
    }

    func setPullToRefresh(type: PullToRefreshType) {
        (scrollView.getAllSubviews() as [UIRefreshControl]).forEach { $0.removeFromSuperview() }
    print("WebView")
        switch type {
            case .none: break
            case .embed: _setPullToRefresh(target: self, selector: #selector(webViewPullToRefreshHandler(source:)))
            case .custom(let params): _setPullToRefresh(target: params.target, selector: params.selector)
        }
    }

    private func _setPullToRefresh(target: Any, selector: Selector) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(target, action: selector, for: .valueChanged)
        scrollView.addSubview(refreshControl)
    }

    @objc func webViewPullToRefreshHandler(source: UIRefreshControl) {
        guard let url = self.url else { source.endRefreshing(); return }
        load(URLRequest(url: url))
    }
}

// https://stackoverflow.com/a/47282118/4488252

extension UIView {

    class func getAllSubviews<T: UIView>(from parenView: UIView) -> [T] {
        return parenView.subviews.flatMap { subView -> [T] in
            var result = getAllSubviews(from: subView) as [T]
            if let view = subView as? T { result.append(view) }
            return result
        }
    }

    func getAllSubviews<T: UIView>() -> [T] { return UIView.getAllSubviews(from: self) as [T] }
}
                 
    



