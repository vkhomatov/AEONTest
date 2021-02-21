//
//  PaymentTableViewCell.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 21.02.2021.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {

   // var mainView = UIView()
    var desc = UILabel()
    var amount = UILabel()
    var currency = UILabel()
    var created = UILabel()
    var cellHeight : CGFloat = 0

    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      //  self.contentView.h
       // self.contentView.addSubview(mainView)

       // self.accessoryType = .disclosureIndicator
       // self.accessoryView = UIImageView(image: UIImage(named: "DisclosureIndicator"))
        self.setupViews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        setupViews()
//    }
    
    
    func setupViews() {
        
//        mainView = UIView(frame: CGRect(x: 5 , y: 5, width: self.frame.width-10, height: 120))
//        mainView.center.x = self.center.x
//        mainView.backgroundColor = .systemYellow
        
        desc = UILabel(frame: CGRect(x: 10 , y: 10, width: self.frame.width, height: 22))
        desc.textColor = .systemBlue
        desc.font = .systemFont(ofSize: 12, weight: .medium)
        desc.textAlignment = .left
        desc.clipsToBounds = true
        desc.autoresizesSubviews = true
        desc.text = "Desc: "
        desc.lineBreakMode = .byWordWrapping
        desc.numberOfLines = 0
        self.contentView.addSubview(desc)
        
        amount = UILabel(frame: CGRect(x: 10 , y: desc.frame.maxY+5, width: self.frame.width, height: 22))
        amount.textColor = .systemBlue
        amount.font = .systemFont(ofSize: 12, weight: .medium)
        amount.textAlignment = .left
       // desc.center.x = view.center.x
        amount.autoresizesSubviews = true

        amount.clipsToBounds = true

        amount.text = "Amount: "
        amount.lineBreakMode = .byWordWrapping
        amount.numberOfLines = 0
        self.contentView.addSubview(amount)
        
        currency = UILabel(frame: CGRect(x: 10 , y: amount.frame.maxY+5, width: self.frame.width, height: 22))
        currency.textColor = .systemBlue
        currency.font = .systemFont(ofSize: 12, weight: .medium)
        currency.textAlignment = .left
        currency.clipsToBounds = true
        currency.autoresizesSubviews = true

       // desc.center.x = view.center.x
        currency.text = "Currency: "
        currency.lineBreakMode = .byWordWrapping
        currency.numberOfLines = 0
        self.contentView.addSubview(currency)
        
        created = UILabel(frame: CGRect(x: 10 , y: currency.frame.maxY+5, width: self.frame.width, height: 22))
        created.textColor = .systemBlue
        created.font = .systemFont(ofSize: 12, weight: .medium)
        created.textAlignment = .left
//        created.clipsToBounds = true
//        created.autoresizesSubviews = true

       // desc.center.x = view.center.x
        created.text = "Created: "
        created.lineBreakMode = .byWordWrapping
        created.numberOfLines = 0
        self.contentView.addSubview(created)
        
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
