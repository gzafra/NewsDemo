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
    let subSection: String
    let title: String
    let url: String
    let thumbnail: String
    let itemType: String
    let creationDate: String
}

extension Article {
    init?(jsonDictionary: [String: Any]) {
        guard let section = jsonDictionary[JsonKeys.section.rawValue] as? String,
            let subSection = jsonDictionary[JsonKeys.section.rawValue] as? String,
            let title = jsonDictionary[JsonKeys.section.rawValue] as? String,
            let url = jsonDictionary[JsonKeys.section.rawValue] as? String,
            let thumbnail = jsonDictionary[JsonKeys.section.rawValue] as? String,
            let itemType = jsonDictionary[JsonKeys.section.rawValue] as? String,
            let creationDate = jsonDictionary[JsonKeys.section.rawValue] as? String else {
            return nil
        }
       
        self.section = section
        self.subSection = subSection
        self.title = title
        self.url = url
        self.thumbnail = thumbnail
        self.itemType = itemType
        self.creationDate = creationDate
    }
}


private enum JsonKeys: String {
    case section
    case subsection
    case title
    case url
    case thumbnail = "thumbnail_standard"
    case itemType = "item_type"
    case creationDate = "created_date"
}
