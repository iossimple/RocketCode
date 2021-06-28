//
//  Cache+Initiate.swift
//  sample-id
//
//  Created by Viet Nguyen Tran on 2021-06-25.
//

import Foundation
import Cache
import FCFileManager

public extension DiskStorage where Key == String, Value: Codable {
    static func instanceDiskStorage(name: String, inFolder folderPath: String = FCFileManager.pathForDocumentsDirectory()) -> DiskStorage {
        let folderURL = URL(fileURLWithPath: folderPath)
        let config = DiskConfig(name: name, directory: folderURL)
        let transformer = TransformerFactory.forCodable(ofType: Value.self)
        return try! DiskStorage(config: config,
                                transformer: transformer)
    }
}
