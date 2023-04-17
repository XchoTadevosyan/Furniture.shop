//
//  ThreeVCItemOne.swift
//  Furniture.shop
//
//  Created by Xachik on 04.02.23.
//

import UIKit
import PhotosUI

class ThreeVCItemOne: UIViewController {
    
    var filteredData = [ImageItem]()
    var imageItems = [ImageItem]()
    var images = [UIImage]()
    var refreshControl = UIRefreshControl()
    let conteins: CGFloat = 8
    let idCell = "mailCell"
    let searchController = UISearchController()
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(BedTVC.nib, forCellReuseIdentifier: BedTVC.id)
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        DispatchQueue.global(qos: .default).async {
            self.fetchData() 
        }
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        initSearchController()
    }
    
    func initSearchController()   {
        
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = ["All", "Big", "Small"]
        searchController.searchBar.delegate = self
        
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
    
    func galBtn() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func fetchData() {
        DispatchQueue.main.async {
            
            self.imageItems = CacheMSofa.shared.loadImages()
            self.filteredData = self.imageItems
            self.tableView.reloadData()
        }
    }
}


extension ThreeVCItemOne: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BedTVC.id, for: indexPath) as? BedTVC else { return UITableViewCell() }
        let item = filteredData[indexPath.row]
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
        
        let item = filteredData[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "BedKotegoriaVC") as! BedKotegoriaVC
        
        nextVC.image = item.image
        
        nextVC.buttonTU = { text in
            let filt =  self.filteredData[indexPath.row]
            if let index = self.imageItems.firstIndex(where: { $0 == filt }) {
                self.imageItems[index].name = text
                self.filteredData[indexPath.row].name = text
                CacheMSofa.shared.deleteImage(with: item.name)
                CacheMSofa.shared.saveImage(id: text, image: item.image) { myimage in
                    if myimage != nil {
                        print("save")
                    } else {
                        print("don't save")
                    }
                }
            }
            tableView.reloadData()
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeRead = UIContextualAction(style: .normal, title: "Delete") { [self] (action, view, succes) in
            let item = filteredData[indexPath.row]
            CacheMSofa.shared.deleteImage(with: item.name)
            fetchData()
        }
        
        swipeRead.backgroundColor = #colorLiteral(red: 0.776273489, green: 0.1381779015, blue: 0.003017852316, alpha: 1)
        swipeRead.image = #imageLiteral(resourceName: "360_F_346383913_JQecl2DhpHy2YakDz1t3h0Tk3Ov8hikq-removebg-preview")
        return UISwipeActionsConfiguration(actions: [swipeRead])
    }
}


extension ThreeVCItemOne: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: .none)
        guard let result = results.last else { return }
        result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
            DispatchQueue.main.async { [self] in
                    let item = ImageItem(name: UUID().uuidString, image: image, type: "Sofa")
                    self.imageItems.append(item)
                    self.filteredData = imageItems
                    CacheMSofa.shared.saveImage(id: item.name, image: item.image) { myimage in
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


extension ThreeVCItemOne: UISearchResultsUpdating, UISearchBarDelegate  {
    

        //MARK: - UISearchController - func
        
           func updateSearchResults(for searchController: UISearchController) {
               
               let searchBar = searchController.searchBar
               let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
               let searchText = searchBar.text!
               
               filteredData = imageItems
               
               filteredData = searchText.isEmpty ? imageItems : imageItems.filter { (item: ImageItem) -> Bool in
                     
                   return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
                   }
               
               tableView.reloadData()
               
               filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)

           }
           
           func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
               
               filteredData = imageItems
               
               tableView.reloadData()
           }
        
        //MARK: - All - func
        
        func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String = "All") {
            
            filteredData = imageItems.filter
                    {
                        shape in
                        let scopeMatch = (scopeButton == "All" || shape.name.lowercased().contains(scopeButton.lowercased()))
                        if(searchController.searchBar.text != "")
                        {
                            let searchTextMatch = shape.name.lowercased().contains(searchText.lowercased())

                            return scopeMatch && searchTextMatch
                        }
                        else
                        {
                            return scopeMatch
                        }
                    }
                    tableView.reloadData()
        }
    }

    


