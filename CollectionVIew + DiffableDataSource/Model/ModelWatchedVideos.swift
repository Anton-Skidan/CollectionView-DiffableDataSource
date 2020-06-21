//
//  ModelWatchedVideos.swift
//  CollectionVIew + DiffableDataSource
//
//  Created by Антон Скидан on 21.06.2020.
//  Copyright © 2020 Anton Skidan. All rights reserved.
//

import Foundation

struct WatchedVideos: Hashable, Decodable {
    var name: String
    var type: String
    var image: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: WatchedVideos, rhs: WatchedVideos) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        
        guard let filter = filter else { return true}
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}
