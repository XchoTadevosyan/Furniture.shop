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
        
        viewDizayn()
        
    }
    
    func viewDizayn() {
        
        view1.layer.cornerRadius = 17
        view1.layer.borderWidth = 2
        view1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view1.layer.cornerRadius = 17
        view1.layer.masksToBounds = true

    }
    
    @IBOutlet weak var view1: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Firebase.Auth.auth().currentUser != nil {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "HelloVC") as! HelloVC
            navigationController?.pushViewController(nextVC, animated: true)
            
        }
    }
}
