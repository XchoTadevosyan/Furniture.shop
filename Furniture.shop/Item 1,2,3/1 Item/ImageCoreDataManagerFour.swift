//
//  ImageCoreDataManagerFour.swift
//  Furniture.shop
//
//  Created by Xachik on 01.03.23.
//

import Foundation
import CoreData

class ImageCoreDataManagerFour {
    
    static let shared = ImageCoreDataManagerFour()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ImageDBTwo")
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

extension ImageCoreDataManagerFour {
    
    func saveImage(with idfour: String, urlfour: URL) {
        let item = ImageModel(context: context)
        item.id = idfour
        item.url = urlfour
        saveDataa()
    }
    
    func getImagesa() -> [ImageModel] {
        let request: NSFetchRequest<ImageModel> = ImageModel.fetchRequest()
        let items = try? context.fetch(request)
        return items ?? []
    }
    
    func getImagea(idFour: String) -> ImageModel? {
        let request: NSFetchRequest<ImageModel> = ImageModel.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", idFour)
        let item = try? context.fetch(request).first
        return item ?? nil
    }
    
    func deleteImagea(with image: ImageModel) {
        context.delete(image)
        saveDataa()
    }
    
    func saveDataa() {
        try? context.save()
    }
}
