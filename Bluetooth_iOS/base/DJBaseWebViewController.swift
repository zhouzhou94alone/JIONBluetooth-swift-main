//
//  DJBaseWebViewController.swift
//  JION_ZHOU_iOS
//
//  Created by JION_ZHOU on 2020/10/26.
//  Copyright © 2020 JION_ZHOU. All rights reserved.
//

import UIKit
import WebKit
import SnapKit


class DJBaseWebViewController: BTBaseViewController,WKUIDelegate,WKNavigationDelegate, WKScriptMessageHandler {
    
    

    var url : String?
    
    private var userContentController:WKUserContentController!
    
    private lazy var webView: WKWebView = {
        
        let configuration = WKWebViewConfiguration()
        self.userContentController = WKUserContentController()
        configuration.userContentController = self.userContentController

        let webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        return webView
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        self.view.addSubview(progressView)
        progressView.frame = CGRect.init(x: 0, y: kNavBarHeight, w: kScreenWidth, h: 1)
        progressView.progressTintColor = kThemeColor
        progressView.trackTintColor = .clear
//        progressView.progressImage = UIImage(named: "webTrackImage")
        
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setMyTitle()
        webViewConfig()
        loadHTML()

    }
    
   
    override func doBack(_ sender: UIButton?) {
        if self.webView.canGoBack {
            self.webView.goBack()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }

    private func loadHTML() {
        if url != nil {
            if let requestURL = URL.init(string: url!) {
                let request = URLRequest.init(url: requestURL)
                self.webView.load(request)
            }
        }
    }
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
        self.webView.uiDelegate = nil
        self.webView.navigationDelegate = nil
        self.userContentController = nil
    }
    
    func showProgress(_ show:Bool) {
        if show {
            self.progressView.alpha = 1
        }else {
            self.progressView.alpha = 0
        }
    }
    
    // MARK: - UI
    private func webViewConfig() {
        self.view.addSubview(self.webView)
        webView.frame = CGRect(x: 0, y: kNavBarHeight, width: kScreenWidth, height: kScreenHeight-kNavBarHeight)
    }
    
    // MARK: - observe
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
            if self.webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut) {
                    self.progressView.alpha = 0
                } completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                    
                    if self.webView.canGoBack {
                        //添加直接返回上一个页面按钮
                        let btn = UIButton(frame: CGRect(x: 0, y: 0.0, w: 25, h: 44))
                        btn.setImage(UIImage(named: "icon_cancel_333"), for: .normal)
                        btn.addUp { [weak self](btn) in
                            self?.navigationController?.popViewController(animated: true)
                        }
                        let backBarButtonItem = UIBarButtonItem.init(customView: btn)
                        self.navigationItem.leftBarButtonItems = [self.backBarButtonItem,backBarButtonItem]
                    }else{
                        self.navigationItem.leftBarButtonItems = [self.backBarButtonItem]
                    }
                }
            }
            
           
        }
    }
    
    //MARK-WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

    }
    
    //MARK: - WKUIDelegate
    func webViewDidClose(_ webView: WKWebView) {
        //TODO:
    }
    
    
//    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//
//    }
    
    //MARK: - WKNavigationDelegate
   // (1)决定网页能否被允许跳转
    private func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
    }
     
   // (2)处理网页开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showProgress(true)
    }
     
   // (3)处理网页加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showProgress(false)
    }
     
   // (4)处理网页内容开始返回
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
     
  //  (5)处理网页加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showProgress(false)
        self.myTitle = webView.title
        
    }
   // (6)处理网页返回内容时发生的失败
    private func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        
    }
     
    //(7)处理网页进程终止
    private func webViewWebContentProcessDidTerminate(webView: WKWebView) {
        
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
