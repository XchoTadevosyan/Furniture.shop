//
//  FourVCItemOne.swift
//  Furniture.shop
//
//  Created by Xachik on 04.02.23.
//

import UIKit
import PhotosUI

class FourVCItemOne: UIViewController, UISearchResultsUpdating {
    
    var imageItems = [ImageItem]()
    var images = [UIImage]()
    var refreshControl = UIRefreshControl()
    let conteins: CGFloat = 8
    let idCell = "mailCell"
    
    private var filteredRestaurants = [ImageItem]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
        
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = search
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        tableView.register(BedTVC.nib, forCellReuseIdentifier: BedTVC.id)
        tableView.delegate = self
        tableView.dataSource = self
        
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
        
        let comBtn = UIAlertAction(title: "Photos", style: .default) { _ in
            self.galBtn()
        }
        let galBtn = UIAlertAction(title: "Camera", style: .default)
        let cencelBtn = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(galBtn)
        alert.addAction(comBtn)
        alert.addAction(cencelBtn)
        
        present(alert, animated: true, completion: nil)

    }
    
    func fetchData() {
        
        DispatchQueue.main.async {
            
            self.imageItems = CacheM.shared.loadImages()
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
    
    func updateSearchResults(for searchController: UISearchController) {
          print(searchController.searchBar.text!)
      }
}
extension FourVCItemOne: UITableViewDataSource, UITableViewDelegate {
    
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
            self.imageItems[indexPath.row].name = text
            CacheM.shared.deleteImage(with: item.name)
            CacheM.shared.saveImage(id: text, image: item.image) { myimage in
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
            CacheM.shared.deleteImage(with: item.name)
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

extension FourVCItemOne: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: .none)
        guard let result = results.last else { return }
        result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    let item = ImageItem(name: UUID().uuidString, image: image, type: "Bed")
                    self.imageItems.append(item)
                    CacheM.shared.saveImage(id: item.name, image: item.image) { myimage in
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

