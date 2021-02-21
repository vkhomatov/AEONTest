//
//  LoginViewModel.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 21.02.2021.
//

import Foundation

class LoginViewModel {
    
    private var networkService = NetworkService()
    
    func getToken(login: String, password: String, completion: @escaping (String?) -> ()) {
        networkService.getTokenResponse(login: login, password: password) { /*[weak self]*/ result, message  in
           // guard let self = self else { return }
            switch result {
            case let .success(tokenResponse):
                Session.shared.token = tokenResponse.response.token
                print(#function + " данные успешно загружены, token = \(tokenResponse.response.token)")
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

    
}
