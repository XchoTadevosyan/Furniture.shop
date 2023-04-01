//
//  ImageCoreData.swift
//  Furniture.shop
//
//  Created by Xachik on 01.03.23.
//

import UIKit
import Foundation
import CoreData

class ImageCoreData {
    static let shared = ImageCoreData()
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
extension ImageCoreData {
    func saveImage(with id: String, url: URL) {
        let item = Eee(context: context)
        item.id = id
        item.url = url
        saveData()
    }
    func getImages() -> [Eee] {
        let request: NSFetchRequest<Eee> = Eee.fetchRequest()
        let items = try? context.fetch(request)
        return items ?? []
    }
    func getImage(id: String) -> Eee? {
        let request: NSFetchRequest<Eee> = Eee.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        let item = try? context.fetch(request).first
        return item ?? nil
    }
    func deleteImage(with image: Eee) {
        context.delete(image)
        saveData()
    }
    func saveData() {
        try? context.save()
    }
}
