//
//  NetworkService.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 20.02.2021.
//

import Foundation
import UIKit

// сетевая сессия
class NetworkService {
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
       // config.waitsForConnectivity = true
       // config.timeoutIntervalForRequest = 30
        config.urlCredentialStorage = nil
        config.timeoutIntervalForResource = 100
        config.httpAdditionalHeaders = ["app-key" : "12345", "v" : "1"]
        return URLSession(configuration: config)
    }()
    
    var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "http"
        constructor.host = "82.202.204.94"
        return constructor
    }()
    
    // token codable
    func getTokenResponse(login: String, password: String, completion: @escaping (Swift.Result<TokenResponse, Error>?, String?) -> Void)  {
        //(login=demo, password=12345)
        print(login)
        print(password)
        urlConstructor.path = "/api/login"
        urlConstructor.queryItems = [
            URLQueryItem(name: "login", value: login),
            URLQueryItem(name: "password", value: password)
        ]
        
        guard let url = urlConstructor.url else { return }
        guard let query = urlConstructor.query else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = Data(query.utf8)
        
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let tokenResponce = try? JSONDecoder().decode(TokenResponse.self, from: data) {
                    completion(.success(tokenResponce), nil)
                } else {
                    let errorMsg = try? JSONDecoder().decode(TokenError.self, from: data)
                    completion(nil, errorMsg?.error.errorMsg)
                }
            } else if let error = error  {
                completion(.failure(error), nil)
                print(error)
            } else if let httpResponse = response as? HTTPURLResponse {
                completion(nil, httpResponse.statusCode.description)
                print(httpResponse.statusCode.description)
            }
        }.resume()
    }
    
    //payments codable
   /* func getPaymentsResponse(token: String, completion: @escaping (Swift.Result<Payments, Error>?, String?) -> Void)  {
        
        urlConstructor.path = "/api/payments"
        urlConstructor.queryItems = [URLQueryItem(name: "token", value: token)]
        
        guard let url = urlConstructor.url else { return }
        
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let payments = try? JSONDecoder().decode(Payments.self, from: data) {
                    completion(.success(payments), nil)
                } else {
                    completion(nil, "Не удалось раскодировать данные payments")
                }
            } else if let error = error  {
                completion(.failure(error), nil)
                print(error)
            } else if let httpResponse = response as? HTTPURLResponse {
                completion(nil, httpResponse.statusCode.description)
                print(httpResponse.statusCode.description)
            }
        }.resume()
    } */
    
    //payments JSONSerialization
    func getPaymentsJson(token: String, completion: @escaping (Swift.Result<[[String: Any]], Error>?, String?) -> Void)  {
        
        urlConstructor.path = "/api/payments"
        urlConstructor.queryItems = [URLQueryItem(name: "token", value: token)]
        
        guard let url = urlConstructor.url else { return }
        
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                    if let payments = json["response"] as? [[String: Any]] {
                        completion(.success(payments), nil)
                    }
                }
            } else if let error = error  {
                completion(.failure(error), nil)
                print(error)
            } else if let httpResponse = response as? HTTPURLResponse {
                completion(nil, httpResponse.statusCode.description)
                print(httpResponse.statusCode.description)
            }
        }.resume()
    }
}
