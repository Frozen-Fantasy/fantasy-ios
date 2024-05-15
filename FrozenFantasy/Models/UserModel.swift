//
//  UserModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 15.05.2024.
//

import Foundation

struct User: Codable, Identifiable, Equatable {
    var id: UUID = .init()
    var nickname: String
    var email: String
    var registrationDate: Date
    var photo: URL
    var coins: Int

    enum CodingKeys: String, CodingKey {
        case id = "profileID"
        case nickname
        case email
        case registrationDate = "dateRegistration"
        case photo = "photoLink"
        case coins
    }
}
