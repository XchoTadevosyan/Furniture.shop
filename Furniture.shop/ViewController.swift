//
//  ViewController.swift
//  Furniture.shop
//
//  Created by Xachik on 21.01.23.
//

import UIKit

class ViewController: UIViewController {
    var viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func bindViewModel() {
        viewModel.statusText.bind({ (statusText) in
            DispatchQueue.main.async {
                self.label.text = statusText
            }
        })
    }

}

