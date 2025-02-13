//
//  BaseAPI.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import Foundation
import Alamofire

class BaseAPI<T: Endpoint> {
    func requestParameters<M: Codable>( target: T, responseClass: M.Type, completion: @escaping (Result<M?, NSError>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let header = Alamofire.HTTPHeaders(target.header ?? [:])
        if case .parameters(let parameters, let encoding) = target.parameters {
            AF.request(target.baseUrl + target.path, method: method, parameters: parameters, encoding: encoding, headers: header).validate().responseDecodable(of: responseClass.self) { response in
                guard let statusCode = response.response?.statusCode else {
                    let error = NSError(domain: target.baseUrl, code: response.response?.statusCode ?? 0)
                    completion(.failure(error))
                    return
                }
                guard (200 ... 299) ~= statusCode else {
                    let error = NSError(domain: target.baseUrl, code: statusCode)
                    completion(.failure(error))
                    return
                }
                guard let reponseDecode = try? response.result.get() else {
                    let error = NSError(domain: target.baseUrl, code: statusCode)
                    completion(.failure(error))
                    return
                }
                completion(.success(reponseDecode))
            }
        }
    }
    
    func requestEncodable<M: Codable>(target: T, responseClass: M.Type, completion: @escaping (Result<M?, NSError>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let header = Alamofire.HTTPHeaders(target.header ?? [:])

        if case .encodable(let object, let encoder) = target.parameters {
            AF.request(target.baseUrl + target.path, method: method, parameters: object , encoder: encoder, headers: header).validate().responseDecodable(of: responseClass) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error as NSError))
                }
            }
        }
    }
    
    func requestConvertible<M: Codable>(convertible: T, responseClass: M.Type,
                                        completion: @escaping (Result<M?, NSError>) -> Void) {
        AF.request(convertible).validate().responseDecodable(of: responseClass) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error as NSError))
            }
        }
    }
    
    func uploadMultiPartFormData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Result<M?, NSError>) -> Void ) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let header = Alamofire.HTTPHeaders(target.header ?? [:])

    /// `multipart` ở đây là một đối tượng của MultipartFormData, được sử dụng để tạo dữ liệu theo định dạng multipart/form-data khi gửi HTTP request.
        AF.upload(multipartFormData: { multipart in
            if case .parameters(let parameters, _) = target.parameters {
                for (key, value) in parameters {
                    if let value = value as? String, let valueData = value.data(using: .utf8) {

                        multipart.append(valueData, withName: key)
                    }
                }
            }
        }, to: target.baseUrl + target.path, method: method, headers: header)
        .responseDecodable(of: responseClass.self) { response in
            
            guard let statusCode = response.response?.statusCode else {
                let error = NSError(domain: target.baseUrl, code: response.response?.statusCode ?? 0)
                completion(.failure(error))
                return
            }
            
            guard (200 ... 299) ~= statusCode else {
                let error = NSError(domain: target.baseUrl, code: statusCode)
                completion(.failure(error))
                return
            }
            guard let reponseDecode = try? response.result.get() else {
                let error = NSError(domain: target.baseUrl, code: statusCode)
                completion(.failure(error))
                return
            }
            completion(.success(reponseDecode))
        }
    }
}

