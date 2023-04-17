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

    override func awakeFromNib() {
        super.awakeFromNib()

        if let imageToLoad = selectedImage {
            myImage.image  = UIImage(named: imageToLoad)
        }
        
        image()
        s()
    }
    
    func image() {
        
        myImage.layer.borderWidth = 2
        myImage.layer.borderColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        myImage.layer.cornerRadius = 17
        myImage.layer.masksToBounds = true
        
    }
    
    func s() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "BedKotegoriaVC") as! BedKotegoriaVC
        nextVC.buttonTU = { [weak self] text in
            self?.label1.text = text
            
        }
            
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
        func setupData(item: ImageItem) {
            myImage.image = item.image
            label1.text = item.name
        }
    }

