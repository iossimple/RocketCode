//
//  ImageCodable.swift
//  RocketCode
//
//  Created by Viet Nguyen Tran on 2021-06-18.
//

import UIKit

enum ImageCodableError: Error {
    case decodingFailed
    case encodingFailed
}

public typealias Image = UIImage

// Reference from: https://github.com/hyperoslo/Cache
public struct ImageCodable: Codable {
    public let image: Image
    
    public enum CodingKeys: String, CodingKey {
        case image
      }

      public init(image: Image) {
        self.image = image
      }

      public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: CodingKeys.image)
        guard let image = Image(data: data) else {
          throw ImageCodableError.decodingFailed
        }

        self.image = image
      }

      public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        guard let data = image.toData() else {
            throw ImageCodableError.encodingFailed
        }

        try container.encode(data, forKey: CodingKeys.image)
      }
}
