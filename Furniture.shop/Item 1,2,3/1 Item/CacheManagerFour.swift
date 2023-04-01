//
//  CacheManagerFour.swift
//  Furniture.shop
//
//  Created by Xachik on 01.03.23.
//

import Foundation
import UIKit
import CoreData

class CacheManagerFour {
    
    static let shared = CacheManagerFour()
    private init() {}
    
    let ImageFileManagerFour = ImageFileManagerFour()
    let ImageCoreDataManagerFour = ImageCoreDataManagerFour()
    
    func saveImage(id: String, image: UIImage, completion: @escaping ((UIImage?) -> Void)) {
        guard ImageFileManagerFour.getImagea(id: id) == nil else {
            let item = ImageCoreDataManagerFour.loadImagea(fileName: id)
            completion(item?.image)
            return
        }
        let fileName = id
        do {
            try ImageFileManagerFour.saveImage(imageName: fileName, image: image) { (url, error) in
                guard let url = url else { return }
                self.ImageCoreDataManagerFour.saveImage(with: fileName, url: url)
                completion(image)
            }
        } catch {
            completion(nil)
        }
    }
    
    func deleteImagea(with id: String) {
        guard let item = ImageCoreDataManagerFour.getImagea(idFour: id),
//            let urlFour = item.url else { return }
              let urlFoura = item else { return }
        ImageFileManagerFour.deleteImage(with: urlFoura)
        ImageCoreDataManagerFour.deleteImage(with: item)
    }
    
    func loadImages() -> [ImageItem] {
        let coreItems = ImageCoreDataManagerFour.getImagesa()
        let images = coreItems.compactMap { ImageFileManagerFour.loadImagea(fileName: $0.id! ) }
        return images
    }
}

