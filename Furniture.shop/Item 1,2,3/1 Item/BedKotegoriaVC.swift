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
        
    }
    
    @IBAction func buttonGo(_ sender: Any) {
        
        secd()
        
    }
    func secd() {
        
        buttonTU?(textField.text ?? "")
        navigationController?.popViewController(animated: true)
        
    }

}
//let storyboard = UIStoryboard(name: "Main", bundle: nil)
//let nextVC = storyboard.instantiateInitialViewController()(withIdentifier: "BedTVC") as! BedTVC
//nextVC.images.image = image
