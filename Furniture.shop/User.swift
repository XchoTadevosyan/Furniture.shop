//
//  User.swift
//  Furniture.shop
//
//  Created by Xachik on 27.01.23.
//

import Foundation
//import UIKit
struct User {
    var login: String?
    var passwords: String?
}
extension User {
    static var logins = [
    User(login: "anun_azganun", passwords: "12345678")
    ]
}
