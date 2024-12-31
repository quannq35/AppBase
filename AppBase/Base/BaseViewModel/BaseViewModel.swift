//
//  File.swift
//  AppBase
//
//  Created by Quân Nguyễn on 31/12/24.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
