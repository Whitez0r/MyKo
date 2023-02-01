//
//  Model.swift
//  MyKo
//
//  Created by Илья Мунгалов on 18.03.2022.
//

import UIKit

enum AuthResponce{
    case success, noVerify, error
}

struct Slides {
    var id: Int
    var text: String
}

struct LoginField {
    var email: String
    var password: String
}

struct ResponceCode {
    var code: Int
}
