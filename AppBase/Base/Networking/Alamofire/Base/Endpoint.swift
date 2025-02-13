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

enum Params {
    case parameters(parameters: [String: Any], encoding: ParameterEncoding)
    case encodable(object: AnyEncodable?, encoder: ParameterEncoder)
}

protocol Endpoint: URLRequestConvertible {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Params { get }
    var header: [String: String]? { get }
}

/*
    protocols như Encodable không thể dùng trực tiếp với nil, vì chúng không phải là kiểu dữ liệu cụ thể.
    Bọc Encodable thành AnyEncodable để truyền nil trong tuple
 */

struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    init<T: Encodable>(_ value: T) {
        _encode = value.encode(to:)
    }

    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
