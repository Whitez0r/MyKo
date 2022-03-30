//
//  AuthViewController.swift
//  MyKo
//
//  Created by Илья Мунгалов on 18.03.2022.
//

import UIKit

class AuthViewController: UIViewController {

    var delegate: LoginViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeVC(_ sender: Any) {
        delegate.closeVC()
    }
}
