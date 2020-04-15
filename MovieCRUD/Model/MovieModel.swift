//
//  MovieModel.swift
//  MovieCRUD
//
//  Created by Fernando Gomes on 14/04/20.
//  Copyright © 2020 Fernando Gomes. All rights reserved.
//

import Foundation

struct MovieModel: Codable {
    var id: String
    var name: String
    var thumb_image: String
    var description: String
    var active: String
}
