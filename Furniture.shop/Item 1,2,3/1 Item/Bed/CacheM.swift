//
//  CacheM.swift
//  Furniture.shop
//
//  Created by Xachik on 01.03.23.
//

import UIKit
import Foundation
import Foundation

class CacheM {
    static let shared = CacheM()
    private init() {}
    let imageFileManager = ImageFileM.sheard
    let imageCoeDataManager = ImageCoreD.shared
    func saveImage(id: String, image: UIImage, completion: @escaping ((UIImage?) -> Void)) {
        guard imageCoeDataManager.getImage(id: id) == nil else {
            let item = imageFileManager.loadImage(fileName: id)
            completion(item?.image)
            return
        }
        let fileName = id
        do {
            try imageFileManager.saveImage(imageName: fileName, image: image) { (url, error) in
                guard let url = url else { return }
                self.imageCoeDataManager.saveImage(with: fileName, url: url)
                completion(image)
            }
        } catch {
            completion(nil)
        }
    }
    func deleteImage(with id: String) {
        guard let item = imageCoeDataManager.getImage(id: id),
              let url = item.url else { return }
        imageFileManager.deleteImage(with: url)
        imageCoeDataManager.deleteImage(with: item)
    }
    func loadImages() -> [ImageItem] {
        let coreItems = imageCoeDataManager.getImages()
        let images = coreItems.compactMap { imageFileManager.loadImage(fileName: $0.id! ) }
        return images
    }
}
