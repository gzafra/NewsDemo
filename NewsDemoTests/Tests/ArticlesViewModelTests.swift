//
//  ArticlesViewModelTests.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import XCTest
@testable import NewsDemo

class ArticlesViewModelTests: XCTestCase {

    
    func testArticleViewModelSetup() {
        let article = Article(section: "Section name", title: "Title name", abstract: "This is a description", url: "http://www.domain.com/path", multimedia: [Multimedia(url: "http://www.domain.com/image1", format: .standard), Multimedia(url: "http://www.domain.com/image2", format: .large) ], author: "Author", creationDate: "2017-06-14T12:23:43-04:00")
        
        let articleViewModel = ArticleViewModel(with: article)
        
        XCTAssertEqual(articleViewModel.headline, article.title)
        XCTAssertEqual(articleViewModel.description, article.abstract)
        XCTAssertEqual(articleViewModel.articleUrl, article.url)
        XCTAssertNotNil(articleViewModel.thumbnailImage)
        XCTAssertNotNil(articleViewModel.image)
        XCTAssertNotNil(articleViewModel.thumbnailImage?.urlString)
        XCTAssertNotNil(articleViewModel.image?.urlString)
        XCTAssertEqual(articleViewModel.author, article.author)
        XCTAssertEqual(articleViewModel.creationDate, "14/06/2017")
    }
    
}
