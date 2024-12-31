//
//  BaseResponse.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import Foundation

import Foundation
class BaseResponse<T: Codable> : Codable {
    var status: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}
