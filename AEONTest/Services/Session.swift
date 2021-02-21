//
//  Session.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 21.02.2021.
//

import Foundation

// синглтон токена
class Session {
    private init() { }
    var token = ""
    static let shared = Session()
}
