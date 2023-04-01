//
//  ImageCD.swift
//  Furniture.shop
//
//  Created by Xachik on 04.03.23.
//

import UIKit
import Foundation
import CoreData

class ImageCD {    
    static let shared = ImageCD()
    private init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ImageDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
extension ImageCD {
    func saveImage(with id: String, url: URL) {
        let item = Green(context: context)
        item.id = id
        item.url = url
        saveData()
    }
    func getImages() -> [Green] {
        let request: NSFetchRequest<Green> = Green.fetchRequest()
        let items = try? context.fetch(request)
        return items ?? []
    }
    func getImage(id: String) -> Green? {
        let request: NSFetchRequest<Green> = Green.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        let item = try? context.fetch(request).first
        return item ?? nil
    }
    func deleteImage(with image: Green) {
        context.delete(image)
        saveData()
    }
    func saveData() {
        try? context.save()
    }
}
