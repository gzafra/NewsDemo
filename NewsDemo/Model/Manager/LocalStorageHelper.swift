//
//  LocalStorageHelper.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import Foundation


private let folderName = "Cache/"

open class LocalStorageHelper: NSObject {

    /// Saves a Data object into the default documents directory with the provided file name. Returns false if fails.
    @discardableResult
    class func save(_ data: Data!, withName name: String) -> Bool {
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first, let folderPath = NSURL(fileURLWithPath: dir).appendingPathComponent(folderName) {
            

            do {
                if !FileManager.default.fileExists(atPath: folderPath.path) {
                     try FileManager.default.createDirectory(atPath: folderPath.path, withIntermediateDirectories: false, attributes: nil)
                }
                try data.write(to: folderPath.appendingPathComponent(name), options: .atomic)
                
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
            
            let data = try? Data(contentsOf: URL(fileURLWithPath: dir).appendingPathComponent(folderName).appendingPathComponent(name))
            return data
        }
        return nil
    }
    
    class func clearCachedFiles() {
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first, let path = NSURL(fileURLWithPath: dir).appendingPathComponent(folderName) {
        
            do {
                let filePaths = try FileManager.default.contentsOfDirectory(atPath: path.path)
                for filePath in filePaths {
                    try FileManager.default.removeItem(atPath: path.appendingPathComponent(filePath).path)
                }
            } catch {
                print("Could not remove file: \(error.localizedDescription)")
            }
        
        }
    }
}
