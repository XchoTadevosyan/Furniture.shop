//
//  AView.swift
//  Furniture.shop
//
//  Created by Xachik on 27.01.23.
//

import UIKit

class AView: UIViewController {
    @IBOutlet weak var loginField: UITextField!
    var viewModel = ViewModel()
    
    @IBAction func loginButtonPressad(_ sender: Any) {
        viewModel.userButtonPressed(login: (loginField.text ?? ""), password: (passField .text ?? ""))
    }
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var passField: UITextField!
    
    func colorS() {
        label.textColor = UIColor.white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        colorS() 
        // Do any additional setup after loading the view.mm
    }
    func bindviewModel() {
        viewModel.statusText.bind({ (statusText) in
            DispatchQueue.main.async {
                self.label.text = statusText
            }
        })
        viewModel.statusColor.bind({ (statusColor) in
            DispatchQueue.main.async {
                self.label.textColor = statusColor
            }
            })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
