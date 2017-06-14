//
//  DataProvider.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import Foundation

typealias ArticlesBlock = ([Article])->()
typealias ErrorBlock = ((Error)->())?

final class DataManager {
    func fetchTables(resultBlock: @escaping ArticlesBlock, errorBlock: ErrorBlock) {
        
    }
}
