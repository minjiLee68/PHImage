//
//  Photo.swift
//  photoSnapshot
//
//  Created by 이민지 on 2023/06/26.
//

import SwiftUI

struct Photo: Codable, Hashable {
    var image: UIImage?
    var title: String
    
    init(image: UIImage, title: String) {
        self.image = image
        self.title = title
    }
    
    enum CodingKeys: CodingKey {
        case data
        case scale
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let scale = try container.decode(CGFloat.self, forKey: .scale)
        let data = try container.decode(Data.self, forKey: .data)
        self.image = UIImage(data: data, scale: scale)
        self.title = ""
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let image = self.image {
            try container.encode(image.pngData(), forKey: .data)
            try container.encode(image.scale, forKey: .scale)
        }
    }
}
