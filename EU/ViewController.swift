//
//  ViewController.swift
//  EU
//

//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addBatBtn: UIBarButtonItem!
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

    //首都 28 個
    let capitals = ["Vienna",
                    "Brussels",
                    "Sofia",
                    "Zagreb",
                    "Nicosia",
                    "Prague",
                    "Copenhagen",
                    "Tallinn",
                    "Helsinki",
                    "Paris",
                    "Berlin",
                    "Athens",
                    "Budapest",
                    "Dublin",
                    "Rome",
                    "Riga",
                    "Vilnius",
                    "Luxembourg (city)",
                    "Valetta",
                    "Amsterdam",
                    "Warsaw",
                    "Lisbon",
                    "Bucharest",
                    "Bratislava",
                    "Ljubljana",
                    "Madrid",
                    "Stockholm",
                    "London"]
 // bool
    let usesEuro = [true,
                    true,
                    false,
                    false,
                    true,
                    false,
                    false,
                    true,
                    true,
                    true,
                    true,
                    true,
                    false,
                    true,
                    true,
                    true,
                    true,
                    true,
                    true,
                    true,
                    false,
                    true,
                    false,
                    true,
                    true,
                    true,
                    false,
                    false]
    var nations: [Nation] = []
    
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        for index in 0..<countryNames.count {
            let newNation = Nation(country: countryNames[index],
                                   capital: capitals[index],
                                   usesEuro: usesEuro[index])
            nations.append(newNation)
        }
        
    }
    // Edit BarButton 的設定 如果按下是在編輯模式 就跑if
    @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addBatBtn.isEnabled = true
        }else {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            addBatBtn.isEnabled = false
        }
    }
    
    // prepare 傳值
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
           let destination = segue.destination as? DetailTableViewController,
           let selectIndexPath = tableView.indexPathForSelectedRow {
            destination.nation = nations[selectIndexPath.row]
        }else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindFormDetail(segue: UIStoryboardSegue) {
        if let source = segue.source as? DetailTableViewController,
           let selectedIndexPath = tableView.indexPathForSelectedRow {
            // 因為member 是 ？ 是我設定的, 所以這邊要在判斷
            //countryNames[selectedIndexPath.row] = source.nation  "member is nil"
            //上面修改為
            nations[selectedIndexPath.row] = source.nation ?? Nation(country: "", capital: "", usesEuro: true)
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic )
        }else {
            // 插入
            if let source = segue.source as? DetailTableViewController {
                let newIndex = IndexPath(row: countryNames.count, section: 0)
                print("newIndex\(newIndex)")
                if source.nation != nil {
                    //countryNames.append(source.nation ?? "no input")
                    nations.append(source.nation ?? Nation(country: "", capital: "", usesEuro: true))
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
//        return countryNames.count
        return nations.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondView", for: indexPath)
        
        cell.textLabel?.text = nations[indexPath.row].country
        cell.detailTextLabel?.text = nations[indexPath.row].capital
        
        print("indexPath: \(indexPath.row)")
      
        
        return cell
    }
    
    // 編輯 這邊我們使用delete 刪除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            countryNames.remove(at: indexPath.row)
            nations.remove(at: indexPath.row)
            
            //使用 delete 不能使用reloadRows 會報錯
            //tableView.reloadRows(at: [indexPath], with: .fade)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    // 移動
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = nations[sourceIndexPath.row]
//        countryNames.remove(at: sourceIndexPath.row)
//        countryNames.insert(itemToMove, at: destinationIndexPath.row)
        nations.remove(at: sourceIndexPath.row)
        nations.insert(itemToMove, at: destinationIndexPath.row)
    }

}


