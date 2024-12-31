//
//  BaseAPI.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import Foundation
import Alamofire

class BaseAPI<T: Endpoint> {
    func performRequest<M: Decodable>( target: T, responseClass: M.Type, completion: @escaping (Result<M?, NSError>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let header = Alamofire.HTTPHeaders(target.header ?? [:])
        let params = buildParams(type: target.typeRequest)

        AF.request(target.baseUrl + target.path, method: method, parameters: params.0, encoding: params.1, headers: header).responseDecodable(of: responseClass.self) { response in
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
    
    func performUpload<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Result<M?, NSError>) -> Void ) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let header = Alamofire.HTTPHeaders(target.header ?? [:])
        
        AF.upload(multipartFormData: { multipart in
            if case .params(let parameters, _) = target.typeRequest {
                for (key, value) in parameters {
                    if let value = value as? String, let valueData = value.data(using: .utf8) {
                        multipart.append(valueData, withName: key)
                    }
                }
            }
        }, to: target.baseUrl + target.path, method: method, headers: header)
        .responseDecodable(of: responseClass.self) { response in
            
//            switch response.result {
//            case .success(let result):
//                completion(.success(result))
//            case .failure(let error):
//                completion(.failure(error))
//            }
            
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

private func buildParams(type: TypeRequest) -> ([String: Any], ParameterEncoding) {
    switch type {
    case .plain:
        return ([:], URLEncoding.default)
    case .params(prameters: let parameters, encoding: let encoding):
        return (parameters, encoding)
    }
}

