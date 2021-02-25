//
//  PaymentTableViewCell.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 21.02.2021.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {
    
    var desc = UILabel(frame: .zero)
    var amount = UILabel(frame: .zero)
    var currency = UILabel(frame: .zero)
    var created = UILabel(frame: .zero)
    private var cellHeight: CGFloat = 0
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setConstraints2()
    }
    
    
    /*    private func setConstraints() {

        let margins = self.layoutMarginsGuide

        self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: cellHeight).isActive = true
        self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: cellHeight).priority = UILayoutPriority(rawValue: 100)

        desc.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0).isActive = true
        desc.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        desc.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        desc.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true

        amount.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 5.0).isActive = true
        amount.leadingAnchor.constraint(equalTo: desc.leadingAnchor).isActive = true
        amount.trailingAnchor.constraint(equalTo: desc.trailingAnchor).isActive = true
        amount.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true

        currency.topAnchor.constraint(equalTo: amount.bottomAnchor, constant: 5.0).isActive = true
        currency.leadingAnchor.constraint(equalTo: desc.leadingAnchor).isActive = true
        currency.trailingAnchor.constraint(equalTo: desc.trailingAnchor).isActive = true
        currency.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        
        created.topAnchor.constraint(equalTo: currency.bottomAnchor, constant: 5.0).isActive = true
        created.leadingAnchor.constraint(equalTo: desc.leadingAnchor).isActive = true
        created.trailingAnchor.constraint(equalTo: desc.trailingAnchor).isActive = true
        created.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        
    } */
    
    private func setConstraints2() {

        self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: cellHeight).isActive = true
        self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: cellHeight).priority = UILayoutPriority(rawValue: 100)
        
        desc.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5.0).isActive = true
        desc.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        desc.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10.0).isActive = true
        desc.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10.0).isActive = true

        amount.topAnchor.constraint(equalTo: self.desc.bottomAnchor, constant: 5.0).isActive = true
        amount.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        amount.leftAnchor.constraint(equalTo: desc.leftAnchor).isActive = true
        amount.rightAnchor.constraint(equalTo: desc.rightAnchor).isActive = true

        currency.topAnchor.constraint(equalTo: self.amount.bottomAnchor, constant: 5.0).isActive = true
        currency.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        currency.leftAnchor.constraint(equalTo: desc.leftAnchor).isActive = true
        currency.rightAnchor.constraint(equalTo: desc.rightAnchor).isActive = true

        created.topAnchor.constraint(equalTo: self.currency.bottomAnchor, constant: 5.0).isActive = true
        created.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        created.leftAnchor.constraint(equalTo: desc.leftAnchor).isActive = true
        created.rightAnchor.constraint(equalTo: desc.rightAnchor).isActive = true

     }
    
    private func setupViews() {
        
        self.autoresizingMask = .flexibleHeight

        desc.textColor = .systemBlue
        desc.font = .systemFont(ofSize: 14, weight: .medium)
        desc.textAlignment = .left
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.text = "Desc: "
        desc.lineBreakMode = .byWordWrapping
        desc.numberOfLines = 0
        self.contentView.addSubview(desc)
        
        amount.textColor = .systemBlue
        amount.font = .systemFont(ofSize: 14, weight: .medium)
        amount.textAlignment = .left
        amount.translatesAutoresizingMaskIntoConstraints = false
        amount.text = "Amount: "
        amount.lineBreakMode = .byWordWrapping
        self.contentView.addSubview(amount)
        
        currency.textColor = .systemBlue
        currency.font = .systemFont(ofSize: 14, weight: .medium)
        currency.textAlignment = .left
        currency.translatesAutoresizingMaskIntoConstraints = false
        currency.text = "Currency: "
        currency.lineBreakMode = .byWordWrapping
        self.contentView.addSubview(currency)
        
    //  created = UILabel(frame: CGRect(x: 10 , y: currency.frame.maxY+5, width: self.frame.width-20, height: 22))
        created.textColor = .systemBlue
        created.font = .systemFont(ofSize: 14, weight: .medium)
        created.textAlignment = .left
        created.translatesAutoresizingMaskIntoConstraints = false
    //  created.clipsToBounds = true
    //  created.autoresizesSubviews = true
        created.text = "Created: "
        created.lineBreakMode = .byWordWrapping
      //  created.numberOfLines = 0
        self.contentView.addSubview(created)
    }
    
    func layout() {
        self.layoutIfNeeded()
        self.cellHeight = created.frame.maxY + 10
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        self.layout()
        return CGSize(width: contentView.frame.width, height: self.cellHeight)
    }
    
    
    //    private func linesCount(label: UILabel) -> Int {
    //        let textSize = CGSize(width: label.frame.size.width, height: CGFloat(Float.infinity))
    //        let rHeight = lroundf(Float(label.sizeThatFits(textSize).height))
    //        let charSize = lroundf(Float(label.font.lineHeight))
    //        let lineCount = rHeight/charSize
    //        return lineCount
    //    }
    
}
