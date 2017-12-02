//
//  ArticleViewModel.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import UIKit

struct ArticleViewModel {
    let article: Article
    
    init(with article: Article) {
        self.article = article
    }
    
    var headline: String {
        return article.title
    }
    var description: String {
        return article.abstract
    }
    var articleUrl: String {
        return article.url
    }
    var author: String {
        return article.author
    }
    var creationDate: String {
        return article.creationDate.shortDate
    }
    
    var thumbnailImage: AsyncImageViewModel? {
        guard let url = article.multimedia?.filter({ $0.format == .standard }).first?.url else {
            return nil
        }
        return AsyncImageViewModel(urlString: url)
    }
    var image: AsyncImageViewModel? {
        guard let url = article.multimedia?.filter({ $0.format == .large }).first?.url else {
            return nil
        }
        return AsyncImageViewModel(urlString: url)
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


