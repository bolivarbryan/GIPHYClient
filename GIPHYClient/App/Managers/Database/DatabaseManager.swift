//
//  DatabaseManager.swift
//  GIPHYClient
//
//  Created by Bryan A Bolivar M on 2/22/19.
//  Copyright © 2019 BolivarBryan. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SwiftGifOrigin

protocol DatabaseRequest {
    func fetch(completion: ([Any]) -> ())
}

enum DatabaseError: Error {
    case invalidEnpoint
}

enum DatabaseEndpoint: DatabaseRequest {
    case listImages
    case newImage(imageData: Data, url: String)

    func fetch(completion: ([Any]) -> ()) {
        switch self {
        case .listImages:
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageEntity")
            fetchRequest.returnsObjectsAsFaults = false
            sendRequest(request: fetchRequest, completion: completion)
        default:
            assertionFailure("Invalid endpoint used \(self)")
        }
    }

    func save() {
        switch self {
        case let .newImage(data, url):
            saveImage(newImageData: data, url: url)
        default:
            assertionFailure("Invalid endpoint used \(self)")
        }
    }

    func sendRequest(request: NSFetchRequest<NSFetchRequestResult>, completion: ([Any]) -> ()) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do {
            let result = try context.fetch(request)
            completion(self.convertToJSONArray(managedObjects: result as! [NSManagedObject]))
        } catch {
            print(error.localizedDescription)
        }
    }

    ///Transforms NSManagedObject into an Array of dictionaries for easier serialization
    func convertToJSONArray(managedObjects: [NSManagedObject]) -> [[String : Any]] {
        var jsonArray: [[String: Any]] = []
        for item in managedObjects {
            var dict: [String: Any] = [:]
            for attribute in item.entity.attributesByName {
                if let value = item.value(forKey: attribute.key) {
                    dict[attribute.key] = value
                }
            }
            jsonArray.append(dict)
        }
        return jsonArray
    }
}

extension DatabaseEndpoint {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    func saveImage(newImageData: Data, url: String) {
        let entity = NSEntityDescription.entity(forEntityName: "ImageEntity", in: context)
        let imageManagedObject = NSManagedObject(entity: entity!, insertInto: context)
        imageManagedObject.setValue(newImageData, forKey: "data")
        imageManagedObject.setValue(url, forKey: "url")
        try? context.save()
    }

}
