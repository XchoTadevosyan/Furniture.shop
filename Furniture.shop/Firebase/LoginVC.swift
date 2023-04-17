//
//  LoginVC.swift
//  Furniture.shop
//
//  Created by Xachik on 05.02.23.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        
        guard let email = emailTextField.text else { return }
        guard let passworld = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: passworld) { firebaseResult, error in
            if error != nil {
                print("error")
            } else {
                self.performSegue(withIdentifier: "goToNext", sender: self)
                
            }
        }
    }
}
