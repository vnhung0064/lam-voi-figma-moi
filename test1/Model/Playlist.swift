//
//  Playlist.swift
//  test1
//
//  Created by Hung Vu on 15/05/2023.
//

import Foundation
struct Playlist:Codable {
    var name: String
    var songs: [Song]
    
    init(name: String, songs: [Song]) {
        self.name = name
        self.songs = songs
    }
}
