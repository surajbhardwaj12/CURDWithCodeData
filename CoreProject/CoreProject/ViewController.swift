//
//  ViewController.swift
//  CoreProject
//
//  Created by IPS-161 on 12/01/23.
//

import UIKit
import CoreData

class ViewController: UIViewController, tblDelegate {
    func tblReload() {
        clientCount = myCoreData.shareInstance.getData()
        coreTbl.reloadData()
    }
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var coreTbl: UITableView!
    var clientCount =  [Person]()
    var clientDetails = [String:Any]()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txtName.text = "Suraj"
        txtEmail.text = "suraj@gmail.com"
        txtAge.text = "22"
        coreTbl.dataSource = self
        coreTbl.delegate = self
        coreTbl.layer.borderColor = UIColor.black.cgColor
        coreTbl.layer.borderWidth = 1.0
        clientCount = myCoreData.shareInstance.getData()
    }
    func fillDetails() {
        clientDetails = ["name": txtName.text ?? "NO USER" as String,"email": txtEmail.text ?? "NO EMAIL" as String, "age": txtAge.text ?? "NO Age" as String, "isActive" : false]
    }
    @IBAction func btnSaveClick(_ sender: Any) {
        fillDetails()
        myCoreData.shareInstance.save(Object: clientDetails)
        clientCount = myCoreData.shareInstance.getData()
        coreTbl.reloadData()
    }
    @IBAction func btnShowClicked(_ sender: Any) {
        clientCount = myCoreData.shareInstance.getData()
        for person in clientCount {
            print("Name: \(person.name ?? ""), Age: \(person.age), email: \(person.email)")
        }
        
        
        
        
    }
    
}
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coreCell") as! TableViewCell
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.black.cgColor
        let person = clientCount[indexPath.row]
        cell.lblName.text = person.name
        cell.lblEmail.text = person.email
        cell.lblAge.text = person.age
        cell.btnSwitch.isOn = person.isActive
        cell.btnSwitch.tag = indexPath.row
        cell.btnSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        
        return cell
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        let object = clientCount[sender.tag]
        object.isActive = sender.isOn
        do {
            try context?.save()
        } catch let error as NSError {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.row >= 0 && indexPath.row < clientCount.count {
                myCoreData.shareInstance.deleteData(index: indexPath.row)
                clientCount.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                coreTbl.reloadData()
            } else {
                print("Invalid index")
            }
        }
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let editItem = UIContextualAction(style: .destructive, title: "Edit") { [self] contextualAction, view, boolValue in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc1 = storyBoard.instantiateViewController(withIdentifier: "AddVC") as! AddVC
            vc1.modalPresentationStyle = .formSheet
            guard let name = clientCount[indexPath.row].name else {return}
            guard let age = clientCount[indexPath.row].age else {return}
            guard let email = clientCount[indexPath.row].email else {return}
            vc1.index = indexPath.row
            vc1.delegate = self
            vc1.name = name
            vc1.email = email
            vc1.age = age
            
            self.present(vc1, animated: true, completion: nil)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [editItem])
        return swipeActions
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editItem = UIContextualAction(style: .destructive, title: "Edit") { [self] contextualAction, view, boolValue in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc1 = storyBoard.instantiateViewController(withIdentifier: "AddVC") as! AddVC
            vc1.modalPresentationStyle = .formSheet
            guard let name = clientCount[indexPath.row].name else {return}
            guard let age = clientCount[indexPath.row].age else {return}
            guard let email = clientCount[indexPath.row].email else {return}
            vc1.index = indexPath.row
            vc1.delegate = self
            vc1.name = name
            vc1.email = email
            vc1.age = age
            
            self.present(vc1, animated: true, completion: nil)
        }
        let deleteItem = UIContextualAction(style: .destructive, title: "Delete") { [self] contextualAction, view, boolValue in
            if indexPath.row >= 0 && indexPath.row < clientCount.count {
                myCoreData.shareInstance.deleteData(index: indexPath.row)
                clientCount.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                coreTbl.reloadData()
            }else {
                print("Invalid index")
            }
        }
        editItem.backgroundColor = UIColor.blue
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem])
        return swipeActions
    }
}
