//
//  PaymentsViewModel.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 21.02.2021.
//

import Foundation
import UIKit

class PaymentsViewModel {
    
    var networkService = NetworkService()
 //   var payments = Payments()
    var paymentsJson = [PaymentsJson]()
    
  /*  func getPayments(completion: @escaping (String?) -> ()) {
        networkService.getPaymentsResponse(token: Session.shared.token) { [weak self] result, message  in
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
    } */
    
    
    func getPaymentsJson(completion: @escaping (String?) -> ()) {
        networkService.getPaymentsJson(token: Session.shared.token) { [weak self] result, message  in
            guard let self = self else { return }
            switch result {
            case let .success(payments):
                
                // исправление возможных ошибок типа в приходящем с сервера json
                for payment in 0...payments.count-1 {
                    self.paymentsJson.append(PaymentsJson())
                    
                    if let desc = payments[payment]["desc"] as? String {
                        self.paymentsJson[payment].desc = desc
                    }
                    
                    if let amount = payments[payment]["amount"] as? String {
                        self.paymentsJson[payment].amount2 = amount
                        self.paymentsJson[payment].amount = amount
                    } else if let amount = payments[payment]["amount"] as? Double {
                        self.paymentsJson[payment].amount1 = amount
                        self.paymentsJson[payment].amount = String(amount)
                    }
                    
                    if let currency = payments[payment]["currency"] as? String {
                        self.paymentsJson[payment].currency = currency
                    }
                    
                    if let created = payments[payment]["created"] as? String {
                        self.paymentsJson[payment].created2 = created
                        self.paymentsJson[payment].created = created
                    } else if let created = payments[payment]["created"] as? Int {
                        self.paymentsJson[payment].created1 = created
                        self.paymentsJson[payment].created = String(created)
                    }
                }
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
    
//    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
//        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = font
//        label.text = text
//        label.sizeToFit()
//        return label.frame.height
//    }
}

