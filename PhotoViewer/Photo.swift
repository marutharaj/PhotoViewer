//
//  PhotoModel.swift
//  PhotoViewer
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

/*
 {
 "albumId": 1,
 "id": 1,
 "title": "accusamus beatae ad facilis cum similique qui sunt",
 "url": "https://via.placeholder.com/600/92c952",
 "thumbnailUrl": "https://via.placeholder.com/150/92c952"
 }
 */

class Photo: Codable {
    
    var albumId: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    
    private enum keys: String, CodingKey {
        case albumId = "albumId"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: keys.self)
        albumId = try container.decode(Int.self, forKey: .albumId)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(String.self, forKey: .url)
        thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
    }
}
