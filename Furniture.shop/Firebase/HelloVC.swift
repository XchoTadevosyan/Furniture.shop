//
//  HelloVC.swift
//  Furniture.shop
//
//  Created by Xachik on 05.02.23.
//

import UIKit

class HelloVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func toKategoriaVC(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "KotegoriaVC") as! KotegoriaVC
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
}
