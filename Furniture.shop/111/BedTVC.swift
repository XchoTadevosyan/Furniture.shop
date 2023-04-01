//
//  BedTVC.swift
//  Furniture.shop
//
//  Created by Xachik on 07.02.23.
//

import UIKit

class BedTVC: UITableViewCell {

    
    static let id = String(describing: BedTVC.self)
    static let nib = UINib(nibName: id, bundle: nil)
    
    @IBOutlet weak var myImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(image: UIImage) {
        myImage.image = image
    }
}

