//
//  ConfigValues.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import Foundation

enum ConfigValues: String {
    case baseUrl = "BASE_URL"
    case apiKey = "API_KEY"
    
    var value: String? {
        guard let env = Bundle.main.infoDictionary,
            let configValue = env[self.rawValue] as? String else {
            return nil
        }
        return configValue
    }
    
}
