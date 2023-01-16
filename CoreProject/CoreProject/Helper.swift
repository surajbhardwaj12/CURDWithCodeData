//
//  Helper.swift
//  CoreData
//
//  Created by IPS-161 on 12/01/23.
//

import Foundation
import CoreData
import UIKit

class myCoreData {
    //MARK: - Variable
    static var shareInstance = myCoreData()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //MARK: - Save Core Data
    func save(Object:[String:Any]) {
        let client = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context!) as! Person
        guard let name = Object["name"] as? String else {return}
        guard let email = Object["email"] as? String else {return}
        guard let age = Object["age"] as? String else {return}
//        guard let isActive = Object["isActive"] as? Bool else {return}
        client.name = name
        client.email = email
        client.age = age
//        client.isActive = isActive
        do{
            try context?.save()
        }catch{
            print("Error in Inserting Data")
        }
    }
    
    //MARK: - Fetch Core Data
    func getData() -> [Person] {
        var client = [Person]()
        let fetchData = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do{
            client = try context?.fetch(fetchData) as! [Person]
           
        }catch{
            print("Error in Fetching Data")
        }
        return client
    }
    

    
    //MARK: - Delete Core Data
    func deleteData(index: Int) -> [Person] {
        var client = getData()
        if index >= 0 && index < client.count {
            context?.delete(client[index])
            client.remove(at: index)
            do{
                try context?.save()
            }catch{
                print("Error in delete Data")
            }
        } else {
           print("Invalid Index")
        }
            return client
    }
    func editData(Object: [String:Any], index: Int) {
        let client = getData()
        guard let name = Object["name"] as? String else {return}
        guard let email = Object["email"] as? String else {return}
        guard let age = Object["age"] as? String else {return}
        client[index].name = name
        client[index].email = email
        client[index].age = age
        do{
            try context?.save()
            
        }catch{
            print("Error in Edit Data")
        }
    }
}
