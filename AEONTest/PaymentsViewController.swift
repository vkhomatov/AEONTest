//
//  PaymentsViewController.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 21.02.2021.
//

import UIKit

class PaymentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var headerView = UIView()
    private var tableView = UITableView()
    private var exitButton = UIButton()
    private var captionLabel = UILabel()
    var payments = Payments()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createViews()
       // self.tableView.reloadData()
    }

    private func createViews() {
        
        headerView = UILabel(frame: CGRect(x: 0 , y: 0, width: view.frame.width, height: 60))
        headerView.backgroundColor = .systemBlue
        
        captionLabel = UILabel(frame: CGRect(x: 0 , y: 0, width: view.frame.width, height: 31))
        captionLabel.textColor = .systemYellow
      //  captionLabel.center = headerView.center
        captionLabel.font = .systemFont(ofSize: 16, weight: .bold)
        captionLabel.textAlignment = .center
        captionLabel.center.x = view.center.x
        captionLabel.text = "Payments"
        headerView.addSubview(captionLabel)
        
        exitButton = UIButton(frame: CGRect(x: view.frame.width - 50, y: captionLabel.frame.minY, width: 40, height: captionLabel.frame.height))
        exitButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        exitButton.setTitle("exit", for: .normal)
        exitButton.setTitleColor(.white, for: .normal)
        exitButton.setTitleColor(.darkGray, for: .highlighted)
        exitButton.addTarget(self, action: #selector(exitButtonPressed(_:)), for: .touchUpInside)
        headerView.addSubview(exitButton)
        
      //  self.tableView = UITableView(frame: CGRect(x: 0 , y: captionLabel.frame.maxY + 20, width: view.frame.width, height: view.frame.height))
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(PaymentTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
        
    }
    
    
    @objc private func exitButtonPressed(_ sender: UIView?) {
        self.dismiss(animated: true)
        print("Exit Click")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        payments.response.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PaymentTableViewCell else { return UITableViewCell() }
        cell.desc.text = payments.response[indexPath.row].desc
        cell.amount.text = payments.response[indexPath.row].amount as? String
        cell.currency.text = payments.response[indexPath.row].currency
        cell.created.text = String(payments.response[indexPath.row].created)
        cell.selectionStyle = .none

     //   cell.setupViews()

        return cell
    }
    
//    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
//    {
//            return 130
//    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}
