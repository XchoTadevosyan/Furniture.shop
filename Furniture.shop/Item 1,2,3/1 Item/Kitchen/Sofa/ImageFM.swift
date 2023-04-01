//
//  ImageFM.swift
//  Furniture.shop
//
//  Created by Xachik on 04.03.23.
//

import Foundation
import UIKit

class ImageFM {
    static var sheard: ImageFM {
        return ImageFM()
    }
    private init() {}
    func saveImage(imageName: String, image: UIImage, completion: @escaping (URL?, Error?) -> Void) throws {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("documentsDirectory error")
            return
        }
        let fileURL = documentsDirectory.appendingPathComponent(imageName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                completion(nil, removeError)
            }
        }
        do {
            try data.write(to: fileURL)
            completion(fileURL, nil)
        } catch let error {
            completion(nil, error)
        }
    }
    func loadImage(fileName: String) -> ImageItem? {
        if let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            if let image = UIImage(contentsOfFile: imageUrl.path) {
                let item = ImageItem(name: fileName, image: image, type: "Sofa")
                return item
            }
            return nil
        }
        return nil
    }
    func deleteImage(with url: URL) {
        try? FileManager.default.removeItem(at: url)
    }
}
