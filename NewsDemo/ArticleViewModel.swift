//
//  ArticleViewModel.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import UIKit
import AlamofireImage

struct ArticleViewModel {
    let headline: String
    let description: String
    let articleUrl: String
    let author: String
    let creationDate: String
    var smallThumbnailUrl: String?
    var largeThumbnailUrl: String?
    
    var smallThumbnailImage: UIImage?
    var largeThumbnailImage: UIImage?
}

extension ArticleViewModel {
    init(with article: Article) {
        headline = article.title
        description = article.abstract
        articleUrl = article.url
        author = article.author
        creationDate = article.creationDate
        
        // Parse multimedia items to get only the urls we need
        if let multimediaItems = article.multimedia {
            for item in multimediaItems {
                switch item.format {
                case .standard:
                    smallThumbnailUrl = item.url
                case .large:
                    largeThumbnailUrl = item.url
                default:
                    continue
                }
            }
        }
    }
}


extension ArticleViewModel {

    func requestImage(with callback: ()->(UIImage)) {
        Alamofire.request(imageUrl, method: .get).responseImage { response in
            guard let image = response.result.value else {
                print("Error loading image")
                return
            }
            
            callback(image)
        }
    }
    
    func cancelImageRequest() {
        Alamofire.can
    }
}
