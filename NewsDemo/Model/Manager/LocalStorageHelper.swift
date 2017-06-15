//
//  LocalStorageManager.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import Foundation

open class LocalStorageHelper: NSObject {
//    static private let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    

    /// Saves a Data object into the default documents directory with the provided file name. Returns false if fails.
    @discardableResult
    class func save(_ data: Data!, withName name: String) -> Bool {
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first, let path = NSURL(fileURLWithPath: dir).appendingPathComponent(name) {
            

            do {
                try data.write(to: path, options: .atomic)
                
                return true
            }catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        return false
    }
    
    /// Loads a Data object from the default documents directory for the provided file name. Returns nil if fails.
    class func data(withName name: String) -> Data? {
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first  {
            
            let data = try? Data(contentsOf: URL(fileURLWithPath: dir).appendingPathComponent(name))
            return data
        }
        return nil
    }
}
