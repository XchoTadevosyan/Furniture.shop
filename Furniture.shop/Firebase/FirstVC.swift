//
//  firstVC.swift
//  Furniture.shop
//
//  Created by Xachik on 05.02.23.
//

import UIKit
import Firebase

class FirstVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Firebase.Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "HelloVC") as! HelloVC
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
