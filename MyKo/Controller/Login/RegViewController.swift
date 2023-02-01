//
//  RegViewController.swift
//  MyKo
//
//  Created by Илья Мунгалов on 18.03.2022.
//

import UIKit

class RegViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate!
    var checkField = CheckField.shared
    var service = Service.shared
    
    @IBOutlet weak var mainView: UIView!
    var tapGest: UITapGestureRecognizer?
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailView: UIView!
    
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    
    
    @IBOutlet weak var rePasswordField: UITextField!
    @IBOutlet weak var repasswordView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGest!)
    }

    @IBAction func closeVC(_ sender: Any) {
        delegate.closeVC()
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    @IBAction func regBtnClick(_ sender: Any) {
        if checkField.validField(emailView, emailField),
           checkField.validField(passwordView, passwordField)
        {
            if passwordField.text == rePasswordField.text {
                service.createNewUser(LoginField(email: emailField.text!, password: passwordField.text!)) { [weak self] code in
                    switch code.code {
                    case 0:
                        print("Произошла ошибка регистрации")
                    case 1:
                        self?.service.confirmEmail()
                        let alert = UIAlertController(title: "ОК", message: "Success", preferredStyle: .alert)
                        let okBtn = UIAlertAction(title: "Auth", style: .default) { _ in
                            self?.delegate.closeVC()
                        }
                        alert.addAction(okBtn)
                        self?.present(alert, animated: true)
                    default:
                        print("Неизвестная ошибка")
                    }
                }
            }
            else {
                print("Пароли не совпадают")
            }
        }
    }
    
}
