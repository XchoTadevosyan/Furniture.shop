//
//  ItemONEVC.swift
//  Furniture.shop
//
//  Created by Xachik on 30.01.23.
//


import UIKit
import PhotosUI
import Firebase
import SwiftUI


class ItemONEVC: UIViewController {
    
    var selectidImage: String?
    var filteredShapes = [ImageItem]()
    var refreshControl = UIRefreshControl()
    var imageItems = [ImageItem]()
    var filteredData = [ImageItem]()
    let conteins: CGFloat = 8
    let idCell = "mailCell"
    let searchController = UISearchController()
   

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ItemOneTVC", bundle: nil), forCellReuseIdentifier: idCell)
        tableView.register(BedTVC.nib, forCellReuseIdentifier: BedTVC.id)
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        fetchData()
        initSearchController()
        filteredData = imageItems
        
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
        searchController.searchBar.scopeButtonTitles = ["All", "Table", "Kitchen", "Sofa", "Bed"]
        searchController.searchBar.delegate = self
    }
    
    
    @objc func refresh(send: UIRefreshControl) {
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    
    func fetchData() {
        DispatchQueue.main.async {
            
            self.imageItems = []
            self.imageItems += CacheManager.shared.loadImages()
            self.imageItems += CacheMa.shared.loadImages()
            self.imageItems += CacheMan.shared.loadImages()
            self.imageItems += CacheMSofa.shared.loadImages()
            self.imageItems += CacheM.shared.loadImages()
            
            self.filteredData = self.imageItems
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
    
    
    @IBAction func toFourVC(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "FourVCItemOne") as! FourVCItemOne
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func toTwoVC(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "TwoVCItemOne") as! TwoVCItemOne
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func toThreeVC(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "ThreeVCItemOne") as! ThreeVCItemOne
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func toOneVC(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "OneVCItemOne") as! OneVCItemOne
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func showAction(_ sender: UIBarButtonItem) {
        
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
}

//MARK: extension
extension ItemONEVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filteredData.count
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: BedTVC.id, for: indexPath) as? BedTVC else { return UITableViewCell() }

        let item = filteredData [indexPath.row]
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
        self.performSegue(withIdentifier: "detailSegue", sender: self)
        
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
        }
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swipeRead = UIContextualAction(style: .normal, title: "Delete") { [self] (action, view, succes) in
            
            let item = filteredData[indexPath.row]
           
            CacheManager.shared.deleteImage(with: item.name)
            CacheM.shared.deleteImage(with: item.name)
            CacheMa.shared.deleteImage(with: item.name)
            CacheMan.shared.deleteImage(with: item.name)
            CacheMSofa.shared.deleteImage(with: item.name)
            
            fetchData()

            
        }
       
        swipeRead.backgroundColor = #colorLiteral(red: 0.776273489, green: 0.1381779015, blue: 0.003017852316, alpha: 1)
        swipeRead.image = #imageLiteral(resourceName: "360_F_346383913_JQecl2DhpHy2YakDz1t3h0Tk3Ov8hikq-removebg-preview")
        
        return UISwipeActionsConfiguration(actions: [swipeRead])
        
    }
}

extension ItemONEVC: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true, completion: .none)
        guard let result = results.last else { return }
        result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
            guard let image = reading as? UIImage, error == nil else { return }
            DispatchQueue.main.async { [self] in
                let item = ImageItem(name: UUID().uuidString, image: image, type: "Home")
                self.imageItems.append(item)
                self.filteredData = imageItems
                
                CacheManager.shared.saveImage(id: item.name, image: item.image) { myimage in
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

//MARK: - extension - Search

extension ItemONEVC:  UISearchResultsUpdating, UISearchBarDelegate  {
    
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
