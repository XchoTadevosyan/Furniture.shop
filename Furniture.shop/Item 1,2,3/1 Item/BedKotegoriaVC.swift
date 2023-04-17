//
//  BedKotegoriaVC.swift
//  Furniture.shop
//
//  Created by Xachik on 07.02.23.
//

import UIKit

protocol SecondVCDelegate: AnyObject {
    func send(image: UIImage)
}

class BedKotegoriaVC: UIViewController {
    
    var image = UIImage()
    var restaurant: ImageItem!
    var buttonTUS: ((UIImage) -> ())?
    var buttonTU: ((String) -> ())?
    weak var delegate: SecondVCDelegate?
  
    
    @IBOutlet weak var images: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images.image = image

        imageDizayn()
        
    }
    
    func imageDizayn() {
        
        images.layer.shadowColor = UIColor.black.cgColor
        images.layer.shadowOffset = CGSize(width: 5, height: 5)
        images.layer.shadowOpacity = 1
        images.layer.shadowRadius = 10
        
    }
    
    @IBAction func buttonGo(_ sender: Any) {
        
        secd()
        
    }
    func secd() {
        
        buttonTU?(textField.text ?? "")
        navigationController?.popViewController(animated: true)
        
    }

}
