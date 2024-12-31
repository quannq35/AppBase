//
//  APIClient.swift
//  AppBase
//
//  Created by Quan on 30/12/24.
//

import Foundation

class APIClient: BaseAPI<APIRoute> {
    static let shared = APIClient()
    
    func getUsers(completion: @escaping (Result<BaseResponse<[UserModel]>?, NSError>) -> ()) {
        self.performRequest(target: .getUsers, responseClass: BaseResponse<[UserModel]>.self) { response in
            completion(response)
        }
    }
    
    func createUser(name: String, job: String, completion: @escaping (Result <BaseResponse<UserModel>?, NSError>) -> ()) {
        self.performRequest(target: .creatorUser(name: name, job: job), responseClass: BaseResponse<UserModel>.self) { response in
            completion(response)
        }
    }
    
    func getUserInfo(id: Int, completion: @escaping (Result<BaseResponse<UserModel>?, NSError>) -> ()) {
        self.performRequest(target: .getUserInfor(id: String(id)), responseClass: BaseResponse<UserModel>.self) { response in
            completion(response)
        }
    }
}
