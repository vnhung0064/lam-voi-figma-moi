//
//  API.swift
//  test1
//
//  Created by Hung Vu on 04/05/2023.
//

import Foundation
import UIKit

struct popularTrackInMonth:Codable{
    let results: [Song]
}

struct Song:Codable {
    var id: String
    var name: String
    var artist_name: String
    var album_image: String
}
