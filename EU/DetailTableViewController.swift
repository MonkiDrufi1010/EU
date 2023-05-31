//
//  DetailTableViewController.swift
//  EU
//

//

import UIKit

class DetailTableViewController: UITableViewController {

    @IBOutlet weak var catialField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var saveBarBtn: UIBarButtonItem!
    //傳值
    
    var member: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        member = member ?? ""
       countryField.text = member
   
        
        
       
        
//        if member == nil {
//            member = ""
//        }
//        countryField.text = member
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        member = countryField.text
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        member = countryField.text
//    }
    @IBAction func cancelBtnPressed(_ sender: UIBarButtonItem) {
        if presentingViewController is UINavigationController {
            dismiss(animated: true)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
    


   

   

}
