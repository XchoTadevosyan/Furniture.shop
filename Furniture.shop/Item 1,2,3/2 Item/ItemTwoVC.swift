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
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var viewBig: UIView!
    @IBOutlet weak var imagePerson: UIImageView!
    @IBOutlet weak var passworld: UILabel!
    @IBOutlet weak var Login: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Login.text = Auth.auth().currentUser?.email
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        viewLogo()
        viewLagin()
        imageLogo()
    }
    
    func viewLogo() {
        
        viewBig.layer.cornerRadius = 22
        viewBig.layer.borderWidth = 2
        viewBig.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        viewBig.layer.cornerRadius = 17
        viewBig.layer.masksToBounds = true
        
    }
    
    func viewLagin() {
        
        view1.layer.cornerRadius = 22
        view1.layer.borderWidth = 2
        view1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view1.layer.cornerRadius = 17
        view1.layer.masksToBounds = true
        
    }
    
    func imageLogo() {
        
        imagePerson.layer.shadowColor = UIColor.gray.cgColor
        imagePerson.layer.shadowOffset = CGSize(width: 5, height: 5)
        imagePerson.layer.shadowOpacity = 1
        imagePerson.layer.shadowRadius = 3
        
    }
    
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
