//
//  OneVCItemOne.swift
//  Furniture.shop
//
//  Created by Xachik on 04.02.23.
//

import UIKit
import PhotosUI

class OneVCItemOne: UIViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("www")
    }

    var imageItems = [ImageItem]()
    var images = [UIImage]()
    var refreshControl = UIRefreshControl()
    let conteins: CGFloat = 8
    let idCell = "mailCell"
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(BedTVC.nib, forCellReuseIdentifier: BedTVC.id)
        DispatchQueue.global(qos: .default).async {
            self.fetchData()
        }
        
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        
    }

    @objc func refresh(send: UIRefreshControl) {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
        }
    }
    
    @IBAction func plusItem(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: "Options to add photo", preferredStyle: .actionSheet)
        
        let galBtn = UIAlertAction(title: "Camera", style: .default)
        
        let comBtn = UIAlertAction(title: "Photos", style: .default) { _ in
            self.galBtn()
        }
        
        let cencelBtn = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(comBtn)
        alert.addAction(galBtn)
        alert.addAction(cencelBtn)
        
        present(alert, animated: true, completion: nil)
    }
    
    func fetchData() {
        
        DispatchQueue.main.async {
            self.imageItems = CacheMa.shared.loadImages()
            self.tableView.reloadData()
            
        }
    }
    
    func galBtn() {
        
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
        
    }
    


}

extension OneVCItemOne: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BedTVC.id, for: indexPath) as? BedTVC else { return UITableViewCell() }

        let item = imageItems[indexPath.row]
        cell.setupData(item: item)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    private func tableView(_ tableView: UITableView, didSelectItemAt indexPath: IndexPath) {
        
        let index = indexPath.row
        print(index)
        UserDefaults.standard.set(index, forKey: "code")
        UserDefaults.standard.synchronize()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = imageItems[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "BedKotegoriaVC") as! BedKotegoriaVC
        
        nextVC.image = item.image
        
        nextVC.buttonTU = { text in
            // TODO:
            self.imageItems[indexPath.row].name = text
            
            CacheManager.shared.deleteImage(with: item.name)
            CacheManager.shared.saveImage(id: text, image: item.image) { myimage in
                
                if myimage != nil {
                    
                    print("save")
                    
                } else {
                    
                    print("don't save")
                    
                }
            }
            
            tableView.reloadData()
            
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swipeRead = UIContextualAction(style: .normal, title: "Delete") { [self] (action, view, succes) in
            let item = imageItems[indexPath.row]
            CacheMa.shared.deleteImage(with: item.name)
            fetchData()
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

extension OneVCItemOne: PHPickerViewControllerDelegate {
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: .none)
        guard let result = results.last else { return }
        result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
            guard let image = reading as? UIImage, error == nil else { return }
            DispatchQueue.main.async {
                let item = ImageItem(name: UUID().uuidString, image: image, type: "Table")
                self.imageItems.append(item)
                CacheMa.shared.saveImage(id: item.name, image: item.image) { myimage in
                    if myimage != nil {
                        print("save")
                    } else {
                        print("don't save")
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
}


