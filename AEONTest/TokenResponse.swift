//
//  TokenResponse.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 21.02.2021.
//

import Foundation

struct TokenResponse: Codable {
    let success: String
    let response: Response
}

struct Response: Codable {
    let token: String
}
