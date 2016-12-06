//
//  FileManager+Document.swift
//  MyFirstCoreData
//
//  Created by Jean-Christophe MELIKIAN on 16/11/2016.
//  Copyright © 2016 ozonePowered. All rights reserved.
//

import Foundation

extension FileManager {
    public static func documentURL() -> URL? {
        return documentURL(childPath: nil)
    }
    
    public static func documentURL(childPath: String?) -> URL? {
        if let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            if let path = childPath {
                return docURL.appendingPathComponent(path)
            }
            return docURL
        }
        return nil
    }
}
