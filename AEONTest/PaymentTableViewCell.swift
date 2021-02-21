//
//  PaymentTableViewCell.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 21.02.2021.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {
    
    var desc = UILabel()
    var amount = UILabel()
    var currency = UILabel()
    var created = UILabel()
    var cellHeight : CGFloat = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() {
        
        desc = UILabel(frame: CGRect(x: 10 , y: 10, width: self.frame.width-20, height: 22))
        desc.textColor = .systemBlue
        desc.font = .systemFont(ofSize: 14, weight: .medium)
        desc.textAlignment = .left
        desc.clipsToBounds = true
        desc.autoresizesSubviews = true
        desc.text = "Desc: "
        desc.lineBreakMode = .byTruncatingTail
        desc.numberOfLines = 0
        self.addSubview(desc)
        
        amount = UILabel(frame: CGRect(x: 10 , y: desc.frame.maxY+5, width: self.frame.width-20, height: 22))
        amount.textColor = .systemBlue
        amount.font = .systemFont(ofSize: 14, weight: .medium)
        amount.textAlignment = .left
        amount.autoresizesSubviews = true
        amount.clipsToBounds = true
        amount.text = "Amount: "
        amount.lineBreakMode = .byWordWrapping
        amount.numberOfLines = 0
        self.addSubview(amount)
        
        currency = UILabel(frame: CGRect(x: 10 , y: amount.frame.maxY+5, width: self.frame.width-20, height: 22))
        currency.textColor = .systemBlue
        currency.font = .systemFont(ofSize: 14, weight: .medium)
        currency.textAlignment = .left
        currency.clipsToBounds = true
        currency.autoresizesSubviews = true
        currency.text = "Currency: "
        currency.lineBreakMode = .byWordWrapping
        currency.numberOfLines = 0
        self.addSubview(currency)
        
        created = UILabel(frame: CGRect(x: 10 , y: currency.frame.maxY+5, width: self.frame.width-20, height: 22))
        created.textColor = .systemBlue
        created.font = .systemFont(ofSize: 14, weight: .medium)
        created.textAlignment = .left
        created.clipsToBounds = true
        created.autoresizesSubviews = true
        created.text = "Created: "
        created.lineBreakMode = .byWordWrapping
        created.numberOfLines = 0
        self.addSubview(created)
        
    }
        
    func layout() {
        self.layoutSubviews()
        self.cellHeight = created.frame.maxY + 10
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.clipsToBounds = true
        self.layout()
        return CGSize(width: contentView.frame.width, height: self.cellHeight)
    }
    
}
