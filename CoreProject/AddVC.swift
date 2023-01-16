//
//  AddVC.swift
//  CoreProject
//
//  Created by IPS-161 on 16/01/23.
//

import UIKit

protocol tblDelegate {
    func tblReload()
}

class AddVC: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    var name = String()
    var email = String()
    var age = String()
    var clientDetails = [String:Any]()
    var myData = [Person]()
    var clientCount =  [Person]()
    var index = Int()
    var delegate: tblDelegate?
    var completionHandler : (()->Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.text = name
        txtEmail.text = email
        txtAge.text = age
    }
    func fillDetails() {
        clientDetails = ["name": txtName.text ?? "NO USER" as String,"email": txtEmail.text ?? "NO EMAIL" as String, "age": txtAge.text ?? "NO Age" as String ]
    }
    @IBAction func btnSaveClicked(_ sender: Any) {
        fillDetails()
        myCoreData.shareInstance.editData(Object: clientDetails, index: index)
        self.dismiss(animated: true, completion: nil)
        completionHandler?()
        delegate?.tblReload()
    }
}
