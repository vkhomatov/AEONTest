//
//  PaymentsViewController.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 21.02.2021.
//

import UIKit

class PaymentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView = UITableView()
    private var headerView = HeaderView()
    private var model = PaymentsViewModel()
    private var dateFormat = DateFormat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createViews()
        self.setCallbacks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //        model.getPayments { [weak self] message in
        //            guard let self = self else { return }
        //            if let error = message {
        //                DispatchQueue.main.async {
        //                    let errorMessage = ErrorMessage(view: self.view)
        //                    errorMessage.showError(message: error, delay: 3.0)
        //                }
        //            } else {
        //
        //                DispatchQueue.main.async { [weak self] in
        //                    guard let self = self else { return }
        //                    self.tableView.reloadData()
        //                    self.captionLabel.text = "Payments"
        //
        //                }
        //            }
        //        }
        
        DispatchQueue.main.async {
            self.model.getPaymentsJson { [weak self] message in
                guard let self = self else { return }
                if let error = message {
                    DispatchQueue.main.async {
                        let errorMessage = ErrorMessage(view: self.view)
                        errorMessage.showError(reverse: true, message: error, delay: 3.0)
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.tableView.reloadData()
                        self.headerView.captionLabel.text = "Payments"
                        
                    }
                }
            }
        }
    }
    
    private func createViews() {
        
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(PaymentTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tableView.separatorStyle = .singleLine
       // self.tableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(tableView)
        
        headerView = HeaderView(frame: CGRect(x: 0 , y: 0, width:  UIScreen.main.bounds.width, height: 60))
        headerView.backgroundColor = .systemBlue
    }
    
    private func setCallbacks() {
        
        headerView.buttonCallback = { [weak self] sender in
            guard let self = self else { return }
            self.model.networkService.session.reset {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    Session.shared.token = ""
                    self.dismiss(animated: true)
                }
            }
        }
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // model.payments.response.count
        model.paymentsJson.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PaymentTableViewCell else { return UITableViewCell() }
        
        if indexPath.row < model.paymentsJson.count {
            cell.desc.text = "Desc: " + model.paymentsJson[indexPath.row].desc
            cell.currency.text = "Currency: " + model.paymentsJson[indexPath.row].currency
            cell.amount.text = "Amount: " + model.paymentsJson[indexPath.row].amount
            cell.created.text = "Created: " + self.dateFormat.getDateInfo(dateString: model.paymentsJson[indexPath.row].created)
        }
        
        cell.selectionStyle = .none
        // cell.setConstraints()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerView
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.layoutIfNeeded()
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
}
