//
//  SettingsViewController.swift
//  MyContactList
//
//  Created by Chandler Hall on 4/4/22.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

   
    @IBOutlet weak var swAscending: UISwitch!
    @IBOutlet weak var pckSortField: UIPickerView!
    
    
    let sortOrderItems: Array<String> = ["ContactName", "City", "Birthday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pckSortField.dataSource = self;
        pckSortField.delegate = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //set the UI based on values in UserDefaults
        
        let settings = UserDefaults.standard
        swAscending.setOn(settings.bool(forKey: Constants.kSortDirectionAscending), animated: true)
        let sortField = settings.string(forKey: Constants.kSortField)
        var i = 0
        for field in sortOrderItems {
            if field == sortField {
                pckSortField.selectRow(i, inComponent: 0, animated: false)
            }
            i += 1
        }
        pckSortField.reloadComponent(0)
    }
    

   
    @IBAction func sortDirectionChanged(_ sender: Any) {
        let settings = UserDefaults.standard
        settings.set(swAscending.isOn, forKey: Constants.kSortDirectionAscending)
        settings.synchronize()
       
        }
    
    
    //returns number of columns to display
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    //returns the number of rows int the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return sortOrderItems.count
    }
    
    //sets the value that is shown for each row in the picker
    func pickerView(_ pickView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return sortOrderItems[row]
    }
    
    //if the user chooses from the pickerview, it calss this function
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component:Int){
        let sortField = sortOrderItems[row]
        let settings = UserDefaults.standard
        settings.set(sortField, forKey: Constants.kSortField)
        settings.synchronize()
        
    }
}
