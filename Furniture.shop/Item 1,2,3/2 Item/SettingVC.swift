//
//  SettingVC.swift
//  Furniture.shop
//
//  Created by Xachik on 04.02.23.
//

import UIKit
import Firebase

class SettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func logOut(_ sender: Any) {
        
        do {
            try Firebase.Auth.auth().signOut()
            s()
        } catch {
            print("catch error")
        }
    }
    func s() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "FirstVC") as! FirstVC
        
        let navVC = UINavigationController(rootViewController: nextVC)
        
        navVC.modalTransitionStyle = .coverVertical
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true)
    }
}



