//
//  CreatAccountVC.swift
//  Furniture.shop
//
//  Created by Xachik on 05.02.23.
//

import UIKit
import Firebase

class CreatAccountVC: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
    }
    @IBAction func signupClicked(_ sender: UIButton) {
        
        guard let email = emailTextField.text else { return }
        guard let passworld = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: passworld) { firebaseResult, error in
            if error != nil {
                print("error")
            } else {
                self.performSegue(withIdentifier: "goToNext", sender: self)
            }
        }
    }
}
