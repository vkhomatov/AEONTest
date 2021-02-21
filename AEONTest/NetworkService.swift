//
//  NetworkService.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 20.02.2021.
//

import Foundation
import UIKit

class NetworkService {
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        //  config.waitsForConnectivity = true
        //  config.timeoutIntervalForRequest = 30
        //   config.timeoutIntervalForResource = 300
        config.httpAdditionalHeaders = ["app-key" : "12345", "v" : "1"]
        return URLSession(configuration: config)
    }()
    
    var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "http"
        constructor.host = "82.202.204.94"
        return constructor
    }()
    
    
    func getTokenResponse(completion: @escaping (Swift.Result<TokenResponse, Error>?, String?) -> Void)  {
        
        urlConstructor.path = "/api/login"
        urlConstructor.queryItems = [
            URLQueryItem(name: "login", value: "demo"),
            URLQueryItem(name: "password", value: "12345")
        ]
        
        guard let url = urlConstructor.url else { return }
        guard let query = urlConstructor.query else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = Data(query.utf8)
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                
                if let tokenResponce = try? JSONDecoder().decode(TokenResponse.self, from: data) {
                //print(tokenResponce.response.token)
               // print(tokenResponce.response.self)
                completion(.success(tokenResponce), nil)
                } else {
                   print("Не удалось раскодировать данные с токеном")
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
    
    func getPaymentsResponse(token: String, completion: @escaping (Swift.Result<Payments, Error>?, String?) -> Void)  {
        
        urlConstructor.path = "/api/payments"
        urlConstructor.queryItems = [URLQueryItem(name: "token", value: token)]
        
        guard let url = urlConstructor.url else { return }
        
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                
//                if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
//                    print(json)
//
//                }
//
//                completion(.success(data), nil)
                
                if let payments = try? JSONDecoder().decode(Payments.self, from: data) {
               // print(tokenResponce.response.token)
                completion(.success(payments), nil)
                } else {
                   print("Не удалось раскодировать данные payments")
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
