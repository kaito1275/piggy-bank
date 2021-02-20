//
//  HistoryViewController.swift
//  PiggyBank
//
//  Created by 村井海斗 on 2021/02/08.
//

import UIKit
import Firebase
import FirebaseFirestore

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var dataSets = [HistoryModel]()
    let uuid = UserDefaults.standard.object(forKey: "ID")
    let db = Firestore.firestore()
    
    var totalMoney = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let total10000 = dataSets[indexPath.row].count10000 * 10000
        let total5000 = dataSets[indexPath.row].count5000 * 5000
        let total1000 = dataSets[indexPath.row].count1000 * 1000
        let total500 = dataSets[indexPath.row].count500 * 500
        let total100 = dataSets[indexPath.row].count100 * 100
        let total50 = dataSets[indexPath.row].count50 * 50
        let total10 = dataSets[indexPath.row].count10 * 10
        let total5 = dataSets[indexPath.row].count5 * 5
        let total1 = dataSets[indexPath.row].count1 * 1
        
        let total = total10000 + total5000 + total1000 + total500 + total100 + total50 + total10 + total5 + total1
        
        let totalLabel = cell.contentView.viewWithTag(1) as! UILabel
        totalLabel.text = "¥" + String(total)
        
        let width = UIScreen.main.bounds.size.width
        totalLabel.frame = CGRect(x: width / 2, y: 0, width: width * 0.449, height: 50)
        
        let postDateLabel = cell.contentView.viewWithTag(2) as! UILabel
        postDateLabel.text = dataSets[indexPath.row].postDateString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let id = dataSets[indexPath.row].id
        
        if editingStyle == .delete {
            
            //firestoreのindexPath.row番目のデータ削除
            db.collection(Optional(uuid) as! String).document(id).delete()
            dataSets.remove(at: indexPath.row)
            
            
            db.collection("\(Optional(uuid) as! String)").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let docTotal = document.data()["total"] as! Int
                        self.totalMoney = self.totalMoney + docTotal
                        
                    }
                }
                
                //tabBarController間の値の受け渡し
                let HomeVC = self.tabBarController!.viewControllers![1] as! HomeViewController
                HomeVC.totalMoneyLabel.text = "¥" +  String(self.totalMoney)
                UserDefaults.standard.setValue(String(self.totalMoney ), forKey: "totalMoney")
                HomeVC.saveTotalMoney = self.totalMoney
                HomeVC.goalMoney = Int((UserDefaults.standard.object(forKey: "goalMoney") as! NSString).doubleValue)
                HomeVC.achievementRate = Double(HomeVC.saveTotalMoney) / Double(HomeVC.goalMoney) * 10
                UserDefaults.standard.setValue(String(HomeVC.achievementRate), forKey: "achievementRate")
                HomeVC.progressView.value = CGFloat(HomeVC.achievementRate)
                
            }
            
            
            
            
            
            self.totalMoney = 0
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
        } }
    
    
    
    
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
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
