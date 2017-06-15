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
        creationDate = article.creationDate.shortDate
        
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

private extension String {
    var shortDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        
        if let parsedDateTimeString = formatter.date(from: self) {
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            return formatter.string(from: parsedDateTimeString)
        } else {
            print("ERROR: Could not parse date")
            return ""
        }
    }
}


