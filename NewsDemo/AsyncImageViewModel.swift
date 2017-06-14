//
//  AsyncImageViewModel.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import UIKit
import AlamofireImage

class AsyncImageViewModel {
    var urlString: String?
    var receipt: RequestReceipt?
    var image: UIImage?
    
    let downloader = ImageDownloader()
    
    
    init(urlString: String, receipt: RequestReceipt? = nil, image: UIImage? = nil) {
        self.urlString = urlString
        self.receipt = receipt
        self.image = image
    }
}

// MARK: - Async image loading

extension AsyncImageViewModel {
    
    func beginThumbnailRequest(with callback: @escaping (UIImage)->()) {
        guard let urlString = urlString, let url = URL(string: urlString)  else {
            return
        }
        
        // Return image if already loaded
        if let image = image {
            print("Loading cached image")
            callback(image)
            return
        }

        let request = URLRequest(url: url)
        receipt = downloader.download(request) { response in
            
            if let image = response.result.value {
                self.receipt = nil
                self.image = image
                callback(image)
            }
        }
    }
    
    func cancelThumbnailRequest() {
        if let receipt = receipt {
            downloader.cancelRequest(with: receipt)
        }
    }
}
