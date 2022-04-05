//
//  ContactsViewController.swift
//  MyContactList
//
//  Created by Chandler Hall on 4/4/22.
//

import UIKit

class ContactsViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    @IBOutlet weak var txtCell: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblBirthdate: UILabel!
    @IBOutlet weak var btnChange: UIButton!
    @IBOutlet weak var sgmtEditMode: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changedEditMode(self)

    }
    
    @IBAction func changedEditMode(_ sender: Any) {
        let textFields: [UITextField] = [txtName, txtAddress, txtCity, txtState, txtZip, txtPhone, txtCell, txtEmail]
        
        if sgmtEditMode.selectedSegmentIndex == 0 {
            for textField in textFields {
                textField.isEnabled = false
                textField.borderStyle = UITextField.BorderStyle.none
            }
            btnChange.isHidden = true
        }
        else if sgmtEditMode.selectedSegmentIndex == 1{
            for textField in textFields {
                textField.isEnabled = true
                textField.borderStyle = UITextField.BorderStyle.roundedRect
            }
            btnChange.isHidden = false
        }
    }
}
