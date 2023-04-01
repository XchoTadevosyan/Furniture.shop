//
//  PurchasesVC.swift
//  Furniture.shop
//
//  Created by Xachik on 09.03.23.
//

import UIKit

class PurchasesVC: UIViewController, UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }
    
    @IBOutlet weak var purchases: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        
    }
}
extension PurchasesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let d =  storyboard.instantiateViewController(withIdentifier: "BedKotegoriaVC") as! BedKotegoriaVC
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BedTVC.id, for: indexPath) as? BedTVC else { return UITableViewCell() }
        // 2: success! Set its selectedImage property
        
        
        // 3: now push it onto the navigation controller
        //navigationController?.pushViewController(vc, animated: true)
        //        let item = imageItems[indexPath.row]
        //        cell.setupData(item: item)
        //        cell.selectedImage = imageItems[indexPath.row]
        //        cell.myImage.image = UIImage(named: BedTVC.id)
        return cell
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
        //        if(searchController.isActive) {
        //            return filteredShapes.count
        //        }
        //        return imageItems.count
            }
    
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
        
        private func tableView(_ tableView: UITableView, didSelectItemAt indexPath: IndexPath) {
            
            let index = indexPath.row
            print(index)
            UserDefaults.standard.set(index, forKey: "code")
            UserDefaults.standard.synchronize()
            self.performSegue(withIdentifier: "detailSegue", sender: self)
            
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
////            let item = imageItems[indexPath.row]
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let nextVC = storyboard.instantiateViewController(withIdentifier: "BedKotegoriaVC") as! BedKotegoriaVC
//
//            nextVC.buttonTU = { text in
//                self.imageItems[indexPath.row].name = text
//                CacheManager.shared.deleteImage(with: item.name)
//                CacheManager.shared.saveImage(id: text, image: item.image) { myimage in
//                    if myimage != nil {
//                        print("save")
//                    } else {
//                        print("don't save")
//                    }
//                }
//                tableView.reloadData()
//            }
//            navigationController?.pushViewController(nextVC, animated: true)
//        }
        
        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let swipeRead = UIContextualAction(style: .normal, title: "Delete") { (action, view, succes) in
                
            }
            swipeRead.backgroundColor = #colorLiteral(red: 0.776273489, green: 0.1381779015, blue: 0.003017852316, alpha: 1)
            swipeRead.image = #imageLiteral(resourceName: "360_F_346383913_JQecl2DhpHy2YakDz1t3h0Tk3Ov8hikq-removebg-preview")
            return UISwipeActionsConfiguration(actions: [swipeRead])
            
        }
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let swipe = UIContextualAction(style: .normal, title: "Bay!") { [] (action, view, succes) in
            }
            swipe.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            swipe.image = #imageLiteral(resourceName: "bb2aa6aa6f262271c2b155babed69b7d-removebg-preview-3")
            return UISwipeActionsConfiguration(actions: [swipe])
        }
    }
}
