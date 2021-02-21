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
    private let network = NetworkMonitor()
    
    private let loginPH = "enter login"
    private let passwordPH = "enter password"
    
    private var model = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMainViews()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        self.view.addGestureRecognizer(tap)
        self.startNetworkMonitor()
        
    }
    
    private func startNetworkMonitor() {
        self.network.monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            if path.status == .unsatisfied {
                DispatchQueue.main.async {
                    let errorMessage = ErrorMessage(view: self.view)
                    errorMessage.showError(reverse: true, message: "Back to Online", delay: 3.0)
                }
            } else if path.status == .satisfied {
                DispatchQueue.main.async {
                    let errorMessage = ErrorMessage(view: self.view)
                    errorMessage.showError(reverse: true, message: "Offline Mode", delay: 3.0)
                }
            }
        }
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
        loginButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
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
        if loginTextField.text == "" {
            loginTextField.attributedPlaceholder = NSAttributedString(string: loginPH, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemYellow])
            loginTextField.becomeFirstResponder()
        } else if passwordTextField.text == "" {
            passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordPH, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemYellow])
            passwordTextField.becomeFirstResponder()
        } else {
            captionLabel.text = "Authenfication ..."
            
            if let login = loginTextField.text, let password = passwordTextField.text {
                model.getToken(login: login, password: password)  { [weak self] message in
                    guard let self = self else { return }
                    if message != nil {
                        DispatchQueue.main.async {
                            let errorMessage = ErrorMessage(view: self.view)
                            errorMessage.showError(reverse: true, message: message!, delay: 3.0)
                            self.captionLabel.text = "AEON Test"
                        }
                    } else {
                        DispatchQueue.main.async {
                            let paymentsViewController = PaymentsViewController()
                            paymentsViewController.view.backgroundColor = .systemGray2
                            paymentsViewController.modalPresentationStyle = .fullScreen
                            paymentsViewController.modalTransitionStyle = .coverVertical
                            
                            self.present(paymentsViewController, animated: true) {
                                self.captionLabel.text = "AEON Test"
                                //self.loginTextField.text = ""
                                self.passwordTextField.text = ""
                                self.passwordTextField.attributedPlaceholder = NSAttributedString(string: self.passwordPH, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
                                self.loginTextField.attributedPlaceholder = NSAttributedString(string: self.loginPH, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
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
                textField.attributedPlaceholder = NSAttributedString(string: passwordPH, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemYellow])
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

