//
//  DetailTableViewController.swift
//  EU
//

//

import UIKit

class DetailTableViewController: UITableViewController {

    @IBOutlet weak var catialField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var euroSwitch: UISwitch!
    @IBOutlet weak var saveBarBtn: UIBarButtonItem!
    //傳值
    
    var nation: Nation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // 因為nation 是struct 所以？？後面我使用 ""字串 會報錯！
        nation = nation ?? Nation(country: "", capital: "", usesEuro: false)
        countryField.text = nation?.country
        catialField.text = nation?.capital
        euroSwitch.isOn = ((nation?.usesEuro) != nil)
        
   

        
//        if member == nil {
//            member = ""
//        }
//        countryField.text = member
    }
    
    //傳值
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
//       nation = Nation(country: countryField.text,
//                         capital: catialField.text,
//                         usesEuro: true)
        // 因為notion 我設定是 optional 所以需要改寫上面寫法,使用optional Binding 寫法
        if let country = countryField.text,
           let captial = catialField.text {
            nation = Nation(country: country, capital: captial, usesEuro: euroSwitch.isOn)
        }

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
