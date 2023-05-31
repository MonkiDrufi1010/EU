//
//  ViewController.swift
//  EU
//

//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 這個陣列包含了 28 個國名稱，你可以根據需要使用它。 陣列是 0~27 共28
    var countryNames = [
        "Afghanistan",
        "Albania",
        "Algeria",
        "Andorra",
        "Angola",
        "Antigua and Barbuda",
        "Argentina",
        "Armenia",
        "Australia",
        "Austria",
        "Azerbaijan",
        "Bahamas",
        "Bahrain",
        "Bangladesh",
        "Barbados",
        "Belarus",
        "Belgium",
        "Belize",
        "Benin",
        "Bhutan",
        "Bolivia",
        "Bosnia and Herzegovina",
        "Botswana",
        "Brazil",
        "Brunei",
        "Bulgaria",
        "Burkina Faso",
        "Burundi" ]

    // 這個陣列包含了 28 個國家名稱，每個元素都是一個字串。
    // 你可以根據需要使用這個陣列，進行相關的操作。


    


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
           let destination = segue.destination as? DetailTableViewController,
           let selectIndexPath = tableView.indexPathForSelectedRow {
            destination.member = countryNames[selectIndexPath.row]
        }else {
            
        }
    }
    
    @IBAction func unwindFormDetail(segue: UIStoryboardSegue) {
        if let source = segue.source as? DetailTableViewController,
           let selectedIndexPath = tableView.indexPathForSelectedRow {
            // 因為member 是 ？ 是我設定的, 所以這邊要在判斷
            countryNames[selectedIndexPath.row] = source.member ?? "member is nil"
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic )
        }else {
            // 插入
            if let source = segue.source as? DetailTableViewController {
                let newIndex = IndexPath(row: countryNames.count, section: 0)
                print("newIndex\(newIndex)")
                if source.member != "" {
                    countryNames.append(source.member ?? "no input")
                    tableView.insertRows(at: [newIndex], with: .bottom)
                    tableView.scrollToRow(at: newIndex, at: .bottom, animated: true)
                    
                }else {
                    // 印出 [0, 27]
                    let lastIndex = IndexPath(row: countryNames.count-1, section: 0)
                    print("last \(lastIndex)")
                    //印出 [0, 28]
                    let endIndex = IndexPath(row: countryNames.count, section: 0)
                    //所以必須減1 不然會報錯
                    print("end \(endIndex)")
                    tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
                }
            }
        }
    }
    

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("count: \(countryNames.count)")
        return countryNames.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondView", for: indexPath)
        
        cell.textLabel?.text = countryNames[indexPath.row]
        
        print("indexPath: \(indexPath.row)")
      
        
        return cell
    }
    
    
}


