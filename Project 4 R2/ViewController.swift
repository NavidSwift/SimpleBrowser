//
//  ViewController.swift
//  Project 4 R2
//
//  Created by Navid on 1/1/22.
//

import UIKit
import WebKit
class ViewController: UIViewController,WKNavigationDelegate {

    var webView : WKWebView!
    var progress : UIProgressView!
    static var webSites : [String] = []
    var pageToLoad : URL?
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progress = UIProgressView(progressViewStyle: .default)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let goBack = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        let goForward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        let progressView = UIBarButtonItem(customView: progress)
        
        toolbarItems = [progressView,spacer,goBack,spacer,goForward,spacer,refresh]
        navigationController?.isToolbarHidden = false
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        webView.load(URLRequest(url: pageToLoad!))
    }
    
    @objc func openTapped(){
        
        let ac = UIAlertController(title: "Open...", message: nil, preferredStyle: .actionSheet)
        
        for webSite in Self.webSites {
            ac.addAction(UIAlertAction(title: webSite, style: .default, handler: actionTapped))
        }
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
        
    }
    
    func actionTapped(action: UIAlertAction) {
        guard let title = action.title else {return}
        guard let url = URL(string: "https://" + title) else {return}
        
        webView.load(URLRequest(url: url))
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            progress.progress = Float(webView.estimatedProgress)
        }
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in Self.webSites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        decisionHandler(.cancel)
        let ac = UIAlertController(title: "Action Blocked", message: "You Cant Open This Link", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(ac, animated: true)
        
    }
    


}

