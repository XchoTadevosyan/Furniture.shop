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
        image()
    }
    
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    
    func image() {
        
        image1.layer.borderWidth = 2
        image1.layer.borderColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        image1.layer.cornerRadius = 17
        image1.layer.masksToBounds = true
        
        image2.layer.borderWidth = 2
        image2.layer.borderColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        image2.layer.cornerRadius = 17
        image2.layer.masksToBounds = true
        
        image3.layer.borderWidth = 2
        image3.layer.borderColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        image3.layer.cornerRadius = 17
        image3.layer.masksToBounds = true
        
        image4.layer.borderWidth = 2
        image4.layer.borderColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        image4.layer.cornerRadius = 17
        image4.layer.masksToBounds = true
        
    }
    @IBAction func buttonAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "TabBarQ") as! TabBarQ
        
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .fullScreen
        
        present(nextVC, animated: true)
        
    }
}
    
