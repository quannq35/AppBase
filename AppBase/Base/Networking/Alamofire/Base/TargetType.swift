//
//  TargetType.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum TypeRequest {
    case plain
    case params(prameters: [String: Any], encoding: ParameterEncoding)
}

protocol TargetType {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var typeRequest: TypeRequest { get }
    var header: [String: String]? { get }
}
