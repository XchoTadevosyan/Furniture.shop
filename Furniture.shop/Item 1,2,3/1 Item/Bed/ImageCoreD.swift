//
//  ImageCoreD.swift
//  Furniture.shop
//
//  Created by Xachik on 01.03.23.
//

import UIKit
import Foundation
import CoreData

class ImageCoreD {    
    static let shared = ImageCoreD()
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
extension ImageCoreD {
    func saveImage(with id: String, url: URL) {
        let item = Sss(context: context)
        item.id = id
        item.url = url
        saveData()
    }
    func getImages() -> [Sss] {
        let request: NSFetchRequest<Sss> = Sss.fetchRequest()
        let items = try? context.fetch(request)
        return items ?? []
    }
    func getImage(id: String) -> Sss? {
        let request: NSFetchRequest<Sss> = Sss.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        let item = try? context.fetch(request).first
        return item ?? nil
    }
    func deleteImage(with image: Sss) {
        context.delete(image)
        saveData()
    }
    func saveData() {
        try? context.save()
    }
}
