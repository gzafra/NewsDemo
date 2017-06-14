//
//  ArticleViewModel.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import UIKit

struct ArticleViewModel {
    let headline: String
    let description: String
    let articleUrl: String
    let author: String
    let creationDate: String
    
    var thumbnailImage: AsyncImageViewModel?
    var image: AsyncImageViewModel?
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
                    thumbnailImage = AsyncImageViewModel(urlString: item.url)
                case .large:
                    image = AsyncImageViewModel(urlString: item.url)
                default:
                    continue
                }
            }
        }
    }
}


