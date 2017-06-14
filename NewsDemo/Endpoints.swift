//
//  Endpoints.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import Foundation

private let basePath = "https://api.nytimes.com/svc/"

enum Endpoints: String {
    case topStories = "topstories/v2/home.json"
    
    var url: String? {
        guard let baseUrl = ConfigValues.baseUrl.value else {
            return nil
        }
        return baseUrl + self.rawValue
    }
}
