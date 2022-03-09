//
//  Post.swift
//  CombineExample
//
//  Created by UW-IN-LPT0108 on 2/5/22.
//

import Foundation

struct Post: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
