//
//  LocalStorageManager.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import Foundation

class LocalStorageManager: NSObject {
    private let jsonFileName = "CachedData.json"
    private let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    // MARK: Disk management
    
    func save(data jsonData: NSData!) -> Bool {
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first, let path = NSURL(fileURLWithPath: dir).appendingPathComponent(jsonFileName) {
            

            do {
                try jsonData.write(to: path, options: .atomic)
                
                return true
            }catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        return false
    }
    
    func data() -> NSData? {
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first, let path = NSURL(fileURLWithPath: dir).appendingPathComponent(jsonFileName) {
            
            let data = NSData(contentsOf: path)
            return data
        }
        return nil
    }
}
