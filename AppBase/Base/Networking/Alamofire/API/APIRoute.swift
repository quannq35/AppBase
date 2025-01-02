//
//  APIRoute.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import Foundation
import Alamofire

enum APIRoute {
    case getUsers
    case getUserInfor(id: String)
    case creatorUser(name: String, job: String)
}
extension APIRoute: Endpoint {
    
    var baseUrl: String {
        switch self {
        default:
            return "https://reqres.in/api"
        }
    }
    
    var path: String {
        switch self {
        case .getUsers, .creatorUser:
            return "/users"
        case .getUserInfor(let id):
            return "/users/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers, .getUserInfor:
            return .get
        case .creatorUser:
            return .post
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .getUsers, .getUserInfor:
            return .plain
        case .creatorUser(let name, let job):
            return .params(prameters: ["name" : name, "job": job], encoding: JSONEncoding.default)
        }
    }
    
    var header: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
    
    
}
