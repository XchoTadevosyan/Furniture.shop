//
//  ItemTwoVC.swift
//  Furniture.shop
//
//  Created by Xachik on 30.01.23.
//

import UIKit
import Firebase
import PhotosUI

class ItemTwoVC: UIViewController {
    
    var imageItems = [ImageItem]()
    var images = [UIImage]()
    let conteins: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Login.text = Auth.auth().currentUser?.email
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    @IBOutlet weak var imagePerson: UIImageView!
    @IBOutlet weak var passworld: UILabel!
    @IBOutlet weak var Login: UILabel!
    
    @IBAction func settingAccaunt(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    @IBAction func imagePersson(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: "Options to add photo", preferredStyle: .actionSheet)
        
        let galBtn = UIAlertAction(title: "Camera", style: .default)
        let comBtn = UIAlertAction(title: "Photos", style: .default)
        let cencelBtn = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(comBtn)
        alert.addAction(galBtn)
        alert.addAction(cencelBtn)
        
        present(alert, animated: true, completion: nil)
    }
}
