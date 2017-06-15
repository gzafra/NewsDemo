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
    
    static var shared = DataManager()

    
    /// Fetches Top Stories remotely
    func fetchTopStories(resultBlock: @escaping ArticlesBlock, errorBlock: ErrorBlock) {
        guard let url = Endpoints.topStories.url, let apiKey = ConfigValues.apiKey.string else {
            errorBlock?(Errors.networkError(subType: .invalidRequest))
            return
        }
        
        let parameters: Parameters = ["api-key": apiKey]

        // TODO: Verify cache policy being used by Alamofire
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            guard let responseJson = response.result.value as? [String: AnyObject],
                let articlesArray = try? self.articles(for: responseJson) else {
                errorBlock?(Errors.networkError(subType: .invalidJson))
                return
            }
            
            if LocalStorageHelper.save(response.data, withName: Endpoints.topStories.rawValue) {
                print("Remote data saved to local storage")
            }

            resultBlock(articlesArray)
        }
    }
    
    /// Loads data from local storage. Returns empty data if not found
    func cachedTopStories() -> [Article] {
        var articles = [Article]()
        if let data = LocalStorageHelper.data(withName: Endpoints.topStories.rawValue),
            let jsonDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: AnyObject],
            let articlesArray = try? self.articles(for: jsonDict) {
            articles.append(contentsOf: articlesArray)
            print("Loading data from local storage.")
        }
        
        return articles
    }
 
    
}

// MARK: - Data parsing

extension DataManager {
    fileprivate func articles(for dict: [String:AnyObject]) throws -> [Article] {
        guard let results = dict["results"] as? [AnyObject] else {
            throw Errors.networkError(subType: .invalidJson)
        }
        
        var articles = [Article]()
        for case let object as [String: Any] in results {
            guard let article = Article(jsonDictionary: object) else {
                print("Error parsing object: \(object). Skipping object.")
                continue
            }
            articles.append(article)
        }
        
        return articles
    }
}
