//
//  KotegoriaVC.swift
//  Furniture.shop
//
//  Created by Xachik on 03.02.23.
//

import UIKit

class KotegoriaVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "TabBarQ") as! TabBarQ
        
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .fullScreen
        
        present(nextVC, animated: true)
    }
}
    
