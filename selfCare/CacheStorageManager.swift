//
//  CacheStorageManager.swift
//  selfCare
//
//  Created by Joseph Taylor on 11/05/2021.
//

import Foundation
import Cache

class CacheStorageManager {
    static let shared = CacheStorageManager()
    
    private lazy var storage: Storage<String, [Entry]> = {
        return try! Storage(diskConfig: DiskConfig(name: "entries"),
                       memoryConfig: MemoryConfig(),
                       transformer: TransformerFactory.forCodable(ofType: [Entry].self))
    }()
    
    func saveEntries(_ entries: [Entry]) {
        try? storage.setObject(entries, forKey: "entries")
    }
    
    func getEntries() -> [Entry] {
        return (try? storage.object(forKey: "entries")) ?? []
    }
}
