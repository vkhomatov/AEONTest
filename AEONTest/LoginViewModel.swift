//
//  LoginViewModel.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 21.02.2021.
//

import Foundation

class LoginViewModel {
    
    var token: String = ""
    var networkService = NetworkService()
    var payments = Payments()
    
    func getToken(completion: @escaping (String?) -> ()) {
        networkService.getTokenResponse { [weak self] result, message  in
            guard let self = self else { return }
            switch result {
            case let .success(tokenResponse):
                self.token = tokenResponse.response.token
                print(#function + " данные успешно загружены, token = \(self.token)")
                completion(nil)
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription), не удалось загрузить данные")
                completion(error.localizedDescription)
            case .none:
                print("Ошибка сервера: \(message ?? "Unknown"), не удалось загрузить данные")
                completion(message)
            }
        }
    }
    
    func getPayments(completion: @escaping (String?) -> ()) {
        networkService.getPaymentsResponse(token: self.token) { [weak self] result, message  in
            guard let self = self else { return }
            switch result {
            case let .success(payments):
                self.payments = payments
                print(#function + " данные успешно загружены")
                completion(nil)
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription), не удалось загрузить данные")
                completion(error.localizedDescription)
            case .none:
                print("Ошибка сервера: \(message ?? "Unknown"), не удалось загрузить данные")
                completion(message)
            }
        }
    }
    
//    func paymentsAdapter(payments: Payments) {
//        
//    }
//    
    
    
}
