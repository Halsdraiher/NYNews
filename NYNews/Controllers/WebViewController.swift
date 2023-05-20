//
//  WebViewController.swift
//  NYNews
//
//  Created by Solovei Ihor on 21.05.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var url: URL!

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self

        view.addSubview(webView)

        let request = URLRequest(url: url)
        webView.load(request)
    }
}

//// Розширення для делегата навігації WKWebView
//extension WebViewController: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        // Сторінка завантажена
//    }
//}
