//
//  API.swift
//  test1
//
//  Created by Hung Vu on 04/05/2023.
//

import Foundation
import UIKit


struct Song:Decodable {
    let id: Int
    let name: String
    let artist_name: String
    let album_image: String
}
