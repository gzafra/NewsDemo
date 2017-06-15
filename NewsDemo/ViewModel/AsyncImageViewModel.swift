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
    var url: URL!
    var receipt: RequestReceipt?
    var image: UIImage?
    
    let downloader = ImageDownloader()
    
    init?(urlString: String, receipt: RequestReceipt? = nil, image: UIImage? = nil) {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        self.url = url
        self.receipt = receipt
        if image != nil {
            self.image = image
        }else{
            // Check if image with that name is in local storage
            if let data = LocalStorageHelper.data(withName: self.url.lastPathComponent),
                let image = UIImage(data: data) {
                print("Image found in local storage!")
                self.image = image
            }
        }
    }
}

// MARK: - Async image loading

extension AsyncImageViewModel {
    
    func beginThumbnailRequest(with callback: @escaping (UIImage)->()) {
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
                // Save image data to local storage
                if let data: Data = UIImagePNGRepresentation(image),
                    LocalStorageHelper.save(data, withName: self.url.lastPathComponent) {
                    print("Image saved to local storage")
                }
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
