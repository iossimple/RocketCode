//
//  Cache+Initiate.swift
//  sample-id
//
//  Created by Viet Nguyen Tran on 2021-06-25.
//

import Foundation
import Cache
import FCFileManager

public enum DiskStorageDefaults {
    public static let name = "LocalStorage"
    public static let folderPath = FCFileManager.pathForDocumentsDirectory()!
}

public extension DiskStorage where Key == String, Value: Codable {
    /// Instantiate a new disk storage. Default name to "LocalStorage". Default folder to documents folder.
    /// - Parameters:
    ///   - name: Storage name, also the subfolder name
    ///   - folderPath: Parent folder name
    /// - Returns: The newly created disk storage
    static func instance(name: String = DiskStorageDefaults.name,
                         inFolder folderPath: String = DiskStorageDefaults.folderPath
    ) -> DiskStorage {
        let folderURL = URL(fileURLWithPath: folderPath)
        let config = DiskConfig(name: name, directory: folderURL)
        let transformer = TransformerFactory.forCodable(ofType: Value.self)
        return try! DiskStorage(config: config,
                                transformer: transformer)
    }
}

public extension DiskStorage where Key == String, Value == Image {
    
    static func instance(name: String = DiskStorageDefaults.name,
                         inFolder folderPath: String = DiskStorageDefaults.folderPath
    ) -> DiskStorage {
        let folderURL = URL(fileURLWithPath: folderPath)
        let config = DiskConfig(name: name, directory: folderURL)
        let transformer = TransformerFactory.forImage()
        return try! DiskStorage(config: config,
                                transformer: transformer)
    }
}
