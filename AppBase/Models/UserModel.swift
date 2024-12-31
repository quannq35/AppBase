//
//  UserModel.swift
//  AppBase
//
//  Created by Quân Nguyễn on 31/12/24.
//

import Foundation

class UserModel: BaseModel {
    var firstName: String?
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case email
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
    }
    
//    override func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(firstName, forKey: .firstName)
//        try container.encodeIfPresent(email, forKey: .email)
//    }
}
