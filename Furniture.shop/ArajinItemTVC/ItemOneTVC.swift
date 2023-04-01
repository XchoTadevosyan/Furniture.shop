//
//  ItemOneTVC.swift
//  Furniture.shop
//
//  Created by Xachik on 04.02.23.
//

import UIKit

class ItemOneTVC: UITableViewCell {
    
    
    //MARK: - ID, NIB
    
    static let id = String(describing: ItemOneTVC.self)
    static let nib = UINib(nibName: id, bundle: nil)
    
    
    //MARK: - MyImage
    
    @IBOutlet weak var myImage: UIView!
    
    
    //MARK: - Override Func
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - SetupData
    
    //    func setupData(image: UIImage) {
    //
    //        myImage.image = image
    //
    //    }
    //}
    
    
    //MARK: - setSelected
    
    //func setSelected(_ selected: Bool, animated: Bool) {
    ////        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    //
    //
    }
