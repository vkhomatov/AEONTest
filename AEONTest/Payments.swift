//
//  Payments.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 21.02.2021.
//

import Foundation

/*
// Структура для Codable
struct Payments: Codable {
    var success = String()
    var response = [PaymentsResponse]()
}

struct PaymentsResponse: Codable {
    let desc: String
    let amount: Amount
    let currency: String?
    let created: Int
}

enum Amount: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Amount.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Amount"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
} */


// Сктура для JSONSerialization
struct PaymentsJson {
    var desc = String()
    var amount1: Double?
    var amount2: String?
    var amount = String()
    var currency = String()
    var created1: Int?
    var created2: String?
    var created = String()
}

// Структура для ошибки при авторизации
struct TokenError: Codable {
    let success: String
    let error: ErrorClass
}

struct ErrorClass: Codable {
    let errorCode: Int
    let errorMsg: String

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMsg = "error_msg"
    }
}

