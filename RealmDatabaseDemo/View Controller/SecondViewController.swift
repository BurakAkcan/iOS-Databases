//
//  SecondViewController.swift
//  RealmDatabaseDemo
//
//  Created by Burak AKCAN on 4.07.2022.
//

import UIKit
import RealmSwift

class SecondViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var rolePickerView: UIPickerView!
    let roles:[String] = [Constant.designer,Constant.developer]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        rolePickerView.delegate = self
        rolePickerView.dataSource = self

    }
    
    
    
    @IBAction func addClicked(_ sender:UIButton){
        
        if textField.text != "" {
          let e = Employee()
          e.name = textField.text!
          e.role = roles[rolePickerView.selectedRow(inComponent: 0)]
            
           // let realm = try! Realm()
           //try! realm.write {
             //  realm.add(e)
               //Call Employee Service
               EmployeeService.saveEmployee(e: e, roleType: e.role)
               performSegue(withIdentifier: "toHome", sender: nil)
               
            }
        else{
            let alert = UIAlertController(title: "Error", message: "Please write something", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
            present(alert, animated: true, completion: nil)
        }
       
    }

    
}

extension SecondViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return roles[row]
    }
    
    
}
