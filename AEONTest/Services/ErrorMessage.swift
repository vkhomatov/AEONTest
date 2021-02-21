//
//  ErrorMessage.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 21.02.2021.
//


import UIKit

// выдвигающаяся панель с ошибкой
class ErrorMessage {

    private var parentView: UIView
    private var errorMessageView = UIView()
    private var errorMessageLabel = UILabel()

    
    init(view: UIView) {
        self.parentView = view
        self.setupErrorMessageView()
    }
    
    private func animationView(reverse: Bool, duration: Double, delay: Double,  offsetY: CGFloat, opacity: Float) {
        UIView.animate(withDuration: duration, delay: 0.2, animations: { [self] in
                        self.errorMessageView.frame = self.errorMessageView.frame.offsetBy(dx: 0, dy: offsetY)
                        errorMessageView.layer.opacity = opacity }) { (finish) in
            if reverse {
                UIView.animate(withDuration: duration, delay: delay, animations: {
                                self.errorMessageView.frame = self.errorMessageView.frame.offsetBy(dx: 0, dy: offsetY * -1)
                                self.errorMessageView.layer.opacity = opacity })
            }
        }
    }
    

    private func setupErrorMessageView() {
        
        errorMessageView = UIView(frame: CGRect(x: 3 , y: -60, width: parentView.frame.width-6, height: 60))
        errorMessageView.center.x = parentView.center.x
        errorMessageView.backgroundColor = .systemIndigo
        errorMessageView.layer.cornerRadius = 6

        errorMessageLabel = UILabel(frame: CGRect(x: 0 , y: (errorMessageView.frame.height-22)/2, width: errorMessageView.frame.width, height: 22))
        errorMessageLabel.lineBreakMode = .byWordWrapping
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.text = "Loading message ..."
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.font = .systemFont(ofSize: 15, weight: .medium)
        errorMessageLabel.textColor = .white
        errorMessageLabel.center.x = errorMessageView.center.x
        
        errorMessageView.addSubview(errorMessageLabel)
        parentView.addSubview(errorMessageView)
        
    }
    
    
    func showError(reverse: Bool, message: String, delay: Double) {
        self.errorMessageLabel.text = message
        self.animationView(reverse: reverse, duration: 1.0, delay: delay, offsetY: 54.0, opacity: 1.0)

    }
    

}
