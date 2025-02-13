//
//  APIClient.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import Foundation

class User: Codable {
    var name: String
    var job: String
    
    init(name: String, job: String) {
        self.name = name
        self.job = job
    }
}

class APIClient: BaseAPI<APIRoute> {
    static let shared = APIClient()
    
    func getUsers(completion: @escaping (Result<BaseResponse<[UserModel]>?, NSError>) -> ()) {
//        self.requestParameters(target: .getUsers, responseClass: BaseResponse<[UserModel]>.self) { response in
//            completion(response)
//        }
        
//        self.requestEncodable(target: .getUsers, responseClass: BaseResponse<[UserModel]>.self) { response in
//            completion(response)
//        }
        
        self.requestConvertible(convertible: .getUsers, responseClass: BaseResponse<[UserModel]>.self) { response in
            completion(response)
        }
    }
    
    func createUser(name: String, job: String, completion: @escaping (Result<User?, NSError>) -> ()) {
//        self.requestParameters(target: .creatorUser(name: name, job: job), responseClass: BaseResponse<UserModel>.self) { response in
//            completion(response)
//        }
        
//        let user = User(name: "quannq", job: "ltv")
//        self.requestEncodable(target: .creatorUserEncodable(user: user), responseClass: User.self) { response in
//            completion(response)
//        }
        

        self.requestConvertible(convertible: .creatorUser(name: "Quannq", job: "ios"), responseClass: User.self) { result in
            completion(result)
        }
    }
    
    func getUserInfo(id: Int, completion: @escaping (Result<BaseResponse<UserModel>?, NSError>) -> ()) {
        self.requestParameters(target: .getUserInfor(id: String(id)), responseClass: BaseResponse<UserModel>.self) { response in
            completion(response)
        }
    }
}
