//
//  AuthViewController.swift
//  MyKo
//
//  Created by Илья Мунгалов on 18.03.2022.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var mainView: UIView!
    
    var userDefault = UserDefaults.standard
    var checkField = CheckField.shared
    var delegate: LoginViewControllerDelegate!
    var service = Service.shared
    
    var tapGest: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGest!)
        
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    @IBAction func clickAuthBtn(_ sender: Any) {
        if checkField.validField(emailView, emailField),
           checkField.validField(passwordView, passwordField){
            let authData = LoginField(email: emailField.text!, password: passwordField.text!)
            service.authInApp(authData) { [weak self] responce in
                switch responce {
                case .success:
                    print("next")
                    self?.userDefault.set(true, forKey: "isLogin")
                    self?.delegate.startApp()
                    self?.delegate.closeVC()
                case .noVerify:
                    let alert = self?.alertAction("Error", "Вы не верефицировали свой email. На вашу почту отправленна ссылка!")
                    let verefyBtn = UIAlertAction(title: "Ок", style: .cancel)
                    alert?.addAction(verefyBtn)
                    self?.present(alert!, animated: true)
                case .error:
                    let alert = self?.alertAction("Error", "Email или пароль не подошли")
                    let verefyBtn = UIAlertAction(title: "Ок", style: .cancel)
                    alert?.addAction(verefyBtn)
                    self?.present(alert!, animated: true)
                }
            }
        }
        else {
            let alert = self.alertAction("Error", "Проверьте введенные данные")
            let verefyBtn = UIAlertAction(title: "Ок", style: .cancel)
            alert.addAction(verefyBtn)
            self.present(alert, animated: true)
        }
    }
    
    func alertAction(_ header: String?, _ message: String?) -> UIAlertController{
        let alert = UIAlertController(title: header, message: message, preferredStyle: .alert)
        return alert
    }
    
    @IBAction func closeVC(_ sender: Any) {
        delegate.closeVC()
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        
    }
}
