//
//  DataProvider.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import Foundation
import Alamofire

typealias ArticlesBlock = ([Article])->()
typealias ErrorBlock = ((Error)->())?

final class DataManager {
    
    func fetchTopStories(resultBlock: @escaping ArticlesBlock, errorBlock: ErrorBlock) {
        guard let url = Endpoints.topStories.url, let apiKey = ConfigValues.apiKey.value else {
            errorBlock?(Errors.invalidRequest)
            return
        }
        
        let parameters: Parameters = ["api-key": apiKey]

        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            guard let responseJSON = response.result.value as? [String:AnyObject],
                let results = responseJSON["results"] as? [AnyObject] else {
                errorBlock?(Errors.invalidJson)
                return
            }
            
            var articlesResult = [Article]()
            for case let object as [String: Any] in results {
                guard let article = Article(jsonDictionary: object) else {
                    print("Error parsing object: \(object)")
                    continue
                }
                articlesResult.append(article)
            }
            resultBlock(articlesResult)
        }
    }
    
}
