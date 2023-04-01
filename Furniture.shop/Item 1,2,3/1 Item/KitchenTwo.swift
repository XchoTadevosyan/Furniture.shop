//
//  KitchenTwo.swift
//  Furniture.shop
//
//  Created by Xachik on 16.02.23.
//

import UIKit

class KitchenTwo: UITableViewCell {

    
    //MARK: - id,nib
    
    static let id = String(describing: KitchenTwo.self)
    static let nib = UINib(nibName: id, bundle: nil)

    
    //MARK: - UIImabeView
    
    @IBOutlet weak var imageViewO: UIImageView!
    
    //MARK: -  override func awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - NSLayoutConstraint - label
    
    @IBOutlet weak var labelOne: NSLayoutConstraint!
    
    //MARK: - override func setSelected
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - setupData
    
    func setupData(image: UIImage) {
        
        imageViewO.image = image
        
    }
}
    

