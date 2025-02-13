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
    case creatorUserEncodable(user: User)
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
        case .getUsers, .creatorUser, .creatorUserEncodable:
            return "/users"
        case .getUserInfor(let id):
            return "/users/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers, .getUserInfor:
            return .get
        case .creatorUser, .creatorUserEncodable:
            return .post
        }
    }
    
    var parameters: Params {
        switch self {
        case .getUsers, .getUserInfor:
            return .encodable(object: nil, encoder: URLEncodedFormParameterEncoder.default)
        case .creatorUser(let name, let job):
            return .parameters(parameters: ["name" : name, "job": job], encoding: JSONEncoding.default)
        case .creatorUserEncodable(let user):
            return .encodable(object: AnyEncodable(user), encoder: JSONParameterEncoder.default)
        }
    }
    
    var header: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
      
    func asURLRequest() throws -> URLRequest {
        let url = try (baseUrl + path).asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("accessToken", forHTTPHeaderField: "X-PKT-Authorization")
        urlRequest.timeoutInterval = 20.0
        
        switch method {
        case .get, .delete:
            if case .parameters(let parameters, _) = parameters {
                let queryRequest = try URLEncoding(destination: .queryString).encode(urlRequest, with: parameters)
                return queryRequest
            }
        case .post, .put:
            if case .parameters(let parameters, _) = parameters {
                // Encode parameters vào httpBody của urlRequest
                let queryRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
                return queryRequest
            }
        }
        return urlRequest
    }
}
