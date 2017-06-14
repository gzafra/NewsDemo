//
//  Endpoints.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import Foundation

// TODO: Section (home, news, ...) in TopStories should be a parameter
enum Endpoints: String {
    case topStories = "TopStories"
    
    var url: String? {
        guard let baseUrl = ConfigValues.baseUrl.string,
            let availableEndPoints = ConfigValues.endpoints.dictionary,
            let endPoint = availableEndPoints[self.rawValue] else {
                return nil
        }
        return baseUrl + endPoint
    }
}
