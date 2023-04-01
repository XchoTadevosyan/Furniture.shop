//
//  ViewModel.swift
//  Furniture.shop
//
//  Created by Xachik on 27.01.23.
//

import Foundation
import UIKit.UIColor
class ViewModel {
    
    var statusText = Dynamic("")
    var statusColor = Dynamic(UIColor.white)
    func userButtonPressed(login: String, password: String) {
        if login != User.logins[0].login || password != User.logins[0].passwords {
            statusText.value = "Log in filed."
          statusColor.value = UIColor.red
        } else {
            statusText.value = "You successfully logged in."
         statusColor.value = UIColor.green
        }
    }
}
