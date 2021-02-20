//
//  SettingsTableViewController.swift
//  PiggyBank
//
//  Created by 村井海斗 on 2021/02/13.
//

import UIKit
import Firebase
import FirebaseFirestore


class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet var SettingsTableView: UITableView!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var achievementRateLabel: UILabel!
    
    
    
    var ac:UIAlertController!
    
    let db = Firestore.firestore()
    let uuid = UserDefaults.standard.object(forKey: "ID")
    
    
    var saveTotalMoney = 0
    var goalMoney = 0
    var achievementRate = 0.00
    var dataSets = [HistoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = UserDefaults.standard.string(forKey: "title")
        moneyLabel.text = "¥" + UserDefaults.standard.string(forKey: "goalMoney")! as String
        
        tableView.isScrollEnabled = false
        
        if let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            versionLabel.text = version
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalMoneyLabel.text = "¥" + UserDefaults.standard.string(forKey: "totalMoney")! as String
        achievementRateLabel.text = UserDefaults.standard.string(forKey: "achievementRate")! as String + "%"
        
        loadData()
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: // 「設定」のセクション
            return 1
        case 1: // 「その他」のセクション
            return 2
        case 2:
            return 2
        case 3:
            return 1
        default: // ここが実行されることはないはず
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 0 && indexPath.row == 0{
            
            return
            
        }else if indexPath.section == 1 && indexPath.row == 0{
            
            return
            
        }else if indexPath.section == 1 && indexPath.row == 1{
            
            return
            
        }else if indexPath.section == 2 && indexPath.row == 0{
            
            var uiTextField = UITextField()
            let ac = UIAlertController(title: "目標のタイトル", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                print(uiTextField.text!)
                UserDefaults.standard.setValue(uiTextField.text, forKey: "title")
                self.titleLabel.text = UserDefaults.standard.string(forKey: "title")
            }
            let cancel = UIAlertAction(title: "キャンセル", style: .default) { (action) in
                print(uiTextField.text!)
            }
            ac.addTextField { (textField) in
                textField.text = UserDefaults.standard.string(forKey: "title")
                uiTextField = textField
            }
            
            ac.addAction(cancel)
            ac.addAction(ok)
            present(ac, animated: true, completion: nil)
            
        }else if indexPath.section == 2 && indexPath.row == 1{
            
            var uiTextField = UITextField()
            
            let ac = UIAlertController(title: "目標金額", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                print(uiTextField.text!)
                UserDefaults.standard.setValue(uiTextField.text, forKey: "goalMoney")
                self.moneyLabel.text = "¥" + UserDefaults.standard.string(forKey: "goalMoney")! as String
                
                let total = Int((UserDefaults.standard.object(forKey: "totalMoney") as! NSString).doubleValue)
                let goal = Int((UserDefaults.standard.object(forKey: "goalMoney") as! NSString).doubleValue)
                self.achievementRate = Double(total) / Double(goal) * 100
                UserDefaults.standard.setValue(self.achievementRate, forKey: "achievementRate")
                let HomeVC = self.tabBarController!.viewControllers![1] as! HomeViewController
                HomeVC.progressView.value = CGFloat(self.achievementRate)
                
                
                print(UserDefaults.standard.object(forKey: "achievementRate") as Any)
                print(HomeVC.progressView.value)
                
            }
            let cancel = UIAlertAction(title: "キャンセル", style: .default) { (action) in
                print(uiTextField.text!)
            }
            ac.addTextField { (textField) in
                textField.text = UserDefaults.standard.string(forKey: "goalMoney")
                uiTextField = textField
            }
            
            ac.addAction(cancel)
            ac.addAction(ok)
            uiTextField.keyboardType = UIKeyboardType.numberPad
            present(ac, animated: true, completion: nil)
            
        }else if indexPath.section == 3 && indexPath.row == 0{
            
            let ac = UIAlertController(title: "貯金履歴をリセットしますか", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                

                
                for count in 0..<self.dataSets.count{
                    let id = self.dataSets[count].id
                    self.db.collection(Optional(self.uuid) as! String).document(id).delete()
                }
                
                self.achievementRate = 0.0
                UserDefaults.standard.setValue(0, forKey: "totalMoney")
                UserDefaults.standard.setValue(self.achievementRate, forKey: "achievementRate")
                let HomeVC = self.tabBarController!.viewControllers![1] as! HomeViewController
                HomeVC.totalMoneyLabel.text = "¥" +  UserDefaults.standard.string(forKey: "totalMoney")! as String
                HomeVC.progressView.value = CGFloat(self.achievementRate)
                
                
                
            }
            let cancel = UIAlertAction(title: "キャンセル", style: .default) { (action) in
                
            }
            
            ac.addAction(cancel)
            ac.addAction(ok)
            
            present(ac, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    func loadData(){
        
        db.collection("\(Optional(uuid) as! String)").order(by: "postDate").addSnapshotListener { (snapShot, error) in
            
            
            self.dataSets = []
            if error != nil{
                return
            }
            
            if let snapShotDoc = snapShot?.documents{
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    
                    let total = data["total"] as? Int
                    let count10000 = data["10000"] as? Int
                    let count5000 = data["5000"] as? Int
                    let count1000 = data["1000"] as? Int
                    let count500 = data["500"] as? Int
                    let count100 = data["100"] as? Int
                    let count50 = data["50"] as? Int
                    let count10 = data["10"] as? Int
                    let count5 = data["5"] as? Int
                    let count1 = data["1"] as? Int
                    let postDate = data["postDate"] as? Double
                    let postDateString = data["postDateString"] as? String
                    let id = doc.documentID
                    
                    
                    let historyModel = HistoryModel(total: total!,count10000: count10000!, count5000: count5000!, count1000: count1000!, count500: count500!, count100: count100!, count50: count50!, count10: count10!, count5: count5!, count1: count1!,postDate: postDate!,postDateString:postDateString!,id:id)
                    
                    self.dataSets.insert(historyModel, at: 0)
                }
                
                self.tableView.reloadData()
                
            }
        }
        
    }
    
    
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
