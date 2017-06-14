//
//  Errors.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import Foundation

enum Errors: Error {
    case networkError(subType: NetworkErrors)
}

enum NetworkErrors: Error {
    case invalidRequest
    case invalidJson
}
