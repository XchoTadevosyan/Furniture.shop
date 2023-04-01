//
//  BedTVC.swift
//  Furniture.shop
//
//  Created by Xachik on 07.02.23.
//

import UIKit




class BedTVC: UITableViewCell {
    
    var selectedImage: String?
    var buttonTUS: ((UIImage) -> ())?
    
    static let id = String(describing: BedTVC.self)
    static let nib = UINib(nibName: id, bundle: nil)
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var myImage: UIImageView!

    
//    var image = UIImage()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let imageToLoad = selectedImage {
            
            myImage.image  = UIImage(named: imageToLoad)
            
        }
//       myImage.image = image
        s()
//        myImage.image = images
//        secda()
    }
    func s() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "BedKotegoriaVC") as! BedKotegoriaVC
//        nextVC.image.text = text
        nextVC.buttonTU = { [weak self] text in
            self?.label1.text = text
            
        }
            
    
    }
        //    func secda() {
        //        buttonTUS?(myImage.image!)
        //    }
    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
        func setupData(item: ImageItem) {
            myImage.image = item.image
            label1.text = item.name
        }
    }

