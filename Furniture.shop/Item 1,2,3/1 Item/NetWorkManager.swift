//
//  NetWorkManager.swift
//  Furniture.shop
//
//  Created by Xachik on 08.03.23.
//

import UIKit
import Foundation

class NetworkManager {
    
    static var shared = NetworkManager()
    
    let url = URL(string: "https://bit.ly/2LMtByx")!
    let sun = URL(string: "https://cdn.britannica.com/60/8160-050-08CCEABC/German-shepherd.jpg")!
    
    func requestImage(complation: @escaping (UIImage?, Error?) -> Void? ) {
        let task = URLSession.shared.dataTask(with: sun) { data, respons, error in
            if let data = data {
                let image = UIImage(data: data)
                complation(image, nil)
            } else if let error = error {
                print("HTTP Request Failed \(error)")
                complation(nil, error)
            }
        }
        task.resume()
    }
    
    let urlData = URL(string: "https://bit.ly/3sspdFO")!
    
    func requestData() {
        var request = URLRequest(url: urlData)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                if let books = try? JSONDecoder().decode([Book].self, from: data) {
                    print(books[0].title)
                } else {
                    print("Invalid Response")
                }
                
            }
        }
        task.resume()
    }
}

struct Book: Codable {

    let title: String
    let author: String

}

