//
//  PMHomeRealmModels.swift
//  MyDocTask
//
//  Created by mahesh.varadara on 13/1/20.
//  Copyright © 2020 mahesh.varadara. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

@objcMembers class StoredPlayList: Object, Decodable {
    dynamic var id = 0
    dynamic var count: Int = 0
    var playlists = RealmSwift.List<StoredTracks>()
    
    enum CodingKeys: String, CodingKey {
        case id
        case count
        case playlists
    }
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        count = try container.decode(Int.self, forKey: .count)
        let playlistList = try container.decode([StoredTracks].self, forKey: .playlists)
        playlists.append(objectsIn: playlistList)
        
        super.init()
    }
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
    
    required init()
    {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema)
    {
        // super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema)
    {
        //  super.init(realm: realm, schema: schema)
    }
}
@objcMembers class StoredTracks: Object, Decodable {
    dynamic var id = 0
    dynamic var wrapperType: String = ""
    dynamic var artistType: String? = nil
    dynamic var artistName: String = ""
    dynamic var artistLinkUrl: String = ""
    dynamic var artistId: Int = 0
    dynamic var amgArtistId: Int = 0
    dynamic var primaryGenreName: String = ""
    dynamic var primaryGenreId: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case wrapperType
        case artistType
        case artistName
        case artistLinkUrl
        case artistId
        case amgArtistId
        case primaryGenreName
        case primaryGenreId
    }
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        wrapperType = try container.decode(String.self, forKey: .wrapperType)
        artistType = try? container.decode(String.self, forKey: .artistType)
        artistName = try container.decode(String.self, forKey: .artistName)
        artistLinkUrl = try container.decode(String.self, forKey: .artistLinkUrl)
        artistId = try container.decode(Int.self, forKey: .artistId)
        amgArtistId = try container.decode(Int.self, forKey: .amgArtistId)
        primaryGenreName = try container.decode(String.self, forKey: .primaryGenreName)
        primaryGenreId = try container.decode(Int.self, forKey: .primaryGenreId)
        super.init()
    }
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
    
    required init()
    {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema)
    {
        // super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema)
    {
        //  super.init(realm: realm, schema: schema)
    }
}

