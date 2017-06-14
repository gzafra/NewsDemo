//
//  FullArticleViewController.swift
//  NewsDemo
//
//  Created by Guillermo Zafra on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import UIKit

class FullArticleViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - Properties
    var articleUrl: URL!
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let urlRequest = URLRequest(url: articleUrl)
        webView.loadRequest(urlRequest)
    }
    
    func setup(with url: URL) {
        articleUrl = url
    }
}
