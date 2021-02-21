//
//  HeaderView.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 21.02.2021.
//

import UIKit

class HeaderView: UIView {
    
    var exitButton = UIButton()
    var captionLabel = UILabel()
    
    
    var buttonCallback: ((_ sender: UIButton) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() {
                
        captionLabel = UILabel(frame: CGRect(x: 0 , y: 0, width: UIScreen.main.bounds.width, height: 31))
        captionLabel.textColor = .white
        captionLabel.font = .systemFont(ofSize: 16, weight: .bold)
        captionLabel.textAlignment = .center
        captionLabel.center.x = UIScreen.main.bounds.width/2
        captionLabel.text = "Loading ..."
        
        exitButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 60, y: captionLabel.frame.minY, width: 60, height: captionLabel.frame.height))
        exitButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        exitButton.setTitle("Log out", for: .normal)
        exitButton.setTitleColor(.white, for: .normal)
        exitButton.setTitleColor(.darkGray, for: .highlighted)
        exitButton.addTarget(self, action: #selector(exitButtonPressed(_:)), for: .touchUpInside)
        
        self.addSubview(captionLabel)
        self.addSubview(exitButton)
    }
    
    @objc func exitButtonPressed(_ sender: UIButton) {
        print("button pressed")
        if let callback = self.buttonCallback {
            callback(sender)
        }
    }
    
}
