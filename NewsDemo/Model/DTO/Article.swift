//
//  Article.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import Foundation

struct Article {
    let section: String
    let title: String
    let abstract: String
    let url: String
    let multimedia: [Multimedia]?
    let author: String
    let creationDate: String
}

extension Article {
    init?(jsonDictionary: [String: Any]) {
        guard let section = jsonDictionary[JsonKeys.section.rawValue] as? String,
            let abstract = jsonDictionary[JsonKeys.abstract.rawValue] as? String,
            let title = jsonDictionary[JsonKeys.title.rawValue] as? String,
            let url = jsonDictionary[JsonKeys.url.rawValue] as? String,
            let author = jsonDictionary[JsonKeys.author.rawValue] as? String,
            let creationDate = jsonDictionary[JsonKeys.creationDate.rawValue] as? String else {
            return nil
        }
       
        self.section = section
        self.abstract = abstract
        self.title = title
        self.url = url
        self.author = author
        self.creationDate = creationDate

        if let multimediaArray = jsonDictionary[JsonKeys.multimedia.rawValue] as? [[String: Any]] {
            var multimediaItems = [Multimedia]()
            for item in multimediaArray {
                guard let newItem = Multimedia(jsonDictionary: item) else {
                    print("Error parsing multimedia item")
                    continue
                }
                multimediaItems.append(newItem)
            }
            multimedia = multimediaItems
        }else{
            self.multimedia = nil
        }
    }
}

private enum JsonKeys: String {
    case section
    case abstract
    case title
    case url
    case author = "byline"
    case creationDate = "created_date"
    case multimedia = "multimedia"
}
