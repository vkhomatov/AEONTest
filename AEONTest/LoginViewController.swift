//
//  LoginViewController.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 20.02.2021.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private var captionLabel = UILabel()
    private var loginTextField = UITextField()
    private var passwordTextField = UITextField()
    private var loginButton = UIButton()
    private var errorMessageView = UIView()
    private var errorMessageLabel = UILabel()
    
    private let loginPH = "enter login"
    private let passwordPH = "enter password"
    
    var model = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMainViews()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        self.view.addGestureRecognizer(tap)
        self.setupErrorMessageView()
       // self.showError(message: "Сучища dsjvsdjvlsdv ksdkvklsdn klsdnvklsdnvklsndvl!!!", delay: 3.0)
        
    }

    func animationView(view: UIView, duration: Double, delay: Double,  offsetY: CGFloat, opacity: Float) {
        UIView.animate(withDuration: duration, delay: 0.2, animations: {
            view.frame = view.frame.offsetBy(dx: 0, dy: offsetY)
                        view.layer.opacity = opacity }) { (finish) in
            UIView.animate(withDuration: duration, delay: delay, animations: {
                view.frame = view.frame.offsetBy(dx: 0, dy: offsetY * -1)
                            view.layer.opacity = opacity })
        }
    }
    
    
    private func setupErrorMessageView() {
        
        errorMessageView = UIView(frame: CGRect(x: 2 , y: -50, width: view.frame.width-4, height: 50))
        errorMessageView.center.x = view.center.x
        errorMessageView.backgroundColor = .systemRed

        errorMessageLabel = UILabel(frame: CGRect(x: 6 , y: 0, width: view.frame.width-12, height: 46))
        errorMessageLabel.lineBreakMode = .byWordWrapping
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.text = "Loading message ..."
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.font = .systemFont(ofSize: 14, weight: .regular)
        errorMessageLabel.textColor = .white
        errorMessageLabel.center = errorMessageView.center
        errorMessageView.layer.cornerRadius = 6
        
        errorMessageView.addSubview(errorMessageLabel)
        view.addSubview(errorMessageView)
        
    }
    
    
    private func showError(message: String, delay: Double) {
        self.errorMessageLabel.text = message
        self.animationView(view: self.errorMessageView, duration: 1.0, delay: delay, offsetY: 52.0, opacity: 1.0)

    }
    
    
    private func setupMainViews() {
        
        captionLabel = UILabel(frame: CGRect(x: 0 , y: 80, width: view.frame.width, height: 31))
        captionLabel.textColor = .systemBlue
        captionLabel.font = .systemFont(ofSize: 25, weight: .medium)
        captionLabel.textAlignment = .center
        captionLabel.center.x = view.center.x
        captionLabel.text = "AEON Test"
        view.addSubview(captionLabel)
        
        loginTextField = LoginTextField(bounds: CGRect(x: 0,
                                                       y: captionLabel.frame.maxY+40,
                                                       width: view.frame.width/2,
                                                       height: 31),
                                        placeholder: loginPH)
        loginTextField.center.x = view.center.x
        loginTextField.delegate = self
        view.addSubview(loginTextField)
        
        passwordTextField = LoginTextField(bounds: CGRect(x: 0,
                                                          y: loginTextField.frame.maxY+10,
                                                          width: loginTextField.frame.width,
                                                          height: loginTextField.frame.height),
                                           placeholder: passwordPH)
        passwordTextField.center.x = view.center.x
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = .done
        passwordTextField.delegate = self
        view.addSubview(passwordTextField)
        
        loginButton = UIButton(frame: CGRect(x: 0,
                                             y: view.frame.maxY-loginTextField.frame.height-80,
                                             width: loginTextField.frame.width/1.5,
                                             height: loginTextField.frame.height))
        loginButton.center.x = view.center.x
        loginButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        loginButton.backgroundColor = .systemYellow
        loginButton.layer.cornerRadius = 6
        loginButton.setTitle("Log in", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitleColor(.systemGray5, for: .highlighted)
        loginButton.addTarget(self, action: #selector(loginButtonPressed(_:)), for: .touchUpInside)
        view.addSubview(loginButton)
        
    }
    
    private func checkTextFields() {
        
    }

    @objc private func loginButtonPressed(_ sender: UIButton?) {
        //print("Login Button Pressed")
        
        if loginTextField.text == "" {
            loginTextField.attributedPlaceholder = NSAttributedString(string: loginPH, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemYellow])
            loginTextField.becomeFirstResponder()
        } else if passwordTextField.text == "" {
            passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordPH, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemYellow])
            passwordTextField.becomeFirstResponder()
        } else {
            print("Все введено")
        
            
            model.getToken { [weak self] message in
                guard let self = self else { return }
                if let error = message {
                    DispatchQueue.main.async {
                        self.showError(message: error, delay: 3.0)
                    }
                } else {
                    self.model.getPayments { [weak self] message in
                        guard let self = self else { return }
                        if let error = message {
                            DispatchQueue.main.async {
                                self.showError(message: error, delay: 3.0)
                            }
                        } else {
                            DispatchQueue.main.async {
                                let paymentsViewController = PaymentsViewController()
                                paymentsViewController.view.backgroundColor = .systemGray2
                                paymentsViewController.modalPresentationStyle = .fullScreen
                                paymentsViewController.modalTransitionStyle = .coverVertical
                                paymentsViewController.payments = self.model.payments
                                self.present(paymentsViewController, animated: true, completion: nil)
                                print(self.model.payments)
                            }
                    }
                }
                
            }
        }
            


    }
    }
    
    
    
    @objc func DismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case loginTextField:
            if textField.text == "" {
                textField.attributedPlaceholder = NSAttributedString(string: loginPH, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemYellow])
            } else {
                passwordTextField.becomeFirstResponder()
            }
        case passwordTextField:
            if textField.text == "" {
                passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordPH, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemYellow])
            } else if loginTextField.text == "" {
                loginTextField.becomeFirstResponder()
            } else {
                self.view.endEditing(true)
            }
        default:
            break
        }
        
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

