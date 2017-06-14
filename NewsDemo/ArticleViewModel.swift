//
//  ArticleViewModel.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import Foundation

struct ArticleViewModel {
    let headline: String
}

extension ArticleViewModel {
    init(with article: Article) {
        headline = article.title
    }
}
