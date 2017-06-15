//
//  Multimedia.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import Foundation

struct Multimedia {
    let url: String
    let format: MultimediaTypes
}

extension Multimedia {
    init?(jsonDictionary: [String: Any]) {
        
        guard let url = jsonDictionary[JsonKeys.url.rawValue] as? String,
            let formatString = jsonDictionary[JsonKeys.format.rawValue] as? String,
            let format = MultimediaTypes(rawValue: formatString) else {
                return nil
        }
        
        self.url = url
        self.format = format
    }
}


private enum JsonKeys: String {
    case url
    case format
}
