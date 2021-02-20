//
//  HomeViewController.swift
//  PiggyBank
//
//  Created by 村井海斗 on 2021/02/07.
//

import UIKit
import Firebase
import FirebaseFirestore
import MBCircularProgressBar

class HomeViewController: UIViewController {
    
    @IBOutlet weak var total10000Label: UILabel!
    @IBOutlet weak var total5000Label: UILabel!
    @IBOutlet weak var total1000Label: UILabel!
    @IBOutlet weak var total500Label: UILabel!
    @IBOutlet weak var total100Label: UILabel!
    @IBOutlet weak var total50Label: UILabel!
    @IBOutlet weak var total10Label: UILabel!
    @IBOutlet weak var total5Label: UILabel!
    @IBOutlet weak var total1Label: UILabel!
    
    @IBOutlet weak var moneyView1: UIView!
    @IBOutlet weak var moneyView2: UIView!
    @IBOutlet weak var moneyView3: UIView!
    @IBOutlet weak var moneyView4: UIView!
    @IBOutlet weak var moneyView5: UIView!
    @IBOutlet weak var moneyView6: UIView!
    @IBOutlet weak var moneyView7: UIView!
    @IBOutlet weak var moneyView8: UIView!
    @IBOutlet weak var moneyView9: UIView!
    
    @IBOutlet weak var moneyLabel1: UILabel!
    @IBOutlet weak var moneyLabel2: UILabel!
    @IBOutlet weak var moneyLabel3: UILabel!
    @IBOutlet weak var moneyLabel4: UILabel!
    @IBOutlet weak var moneyLabel5: UILabel!
    @IBOutlet weak var moneyLabel6: UILabel!
    @IBOutlet weak var moneyLabel7: UILabel!
    @IBOutlet weak var moneyLabel8: UILabel!
    @IBOutlet weak var moneyLabel9: UILabel!
    
    
    
    @IBOutlet weak var plusButton1: UIButton!
    @IBOutlet weak var plusButton2: UIButton!
    @IBOutlet weak var plusButton3: UIButton!
    @IBOutlet weak var plusButton4: UIButton!
    @IBOutlet weak var plusButton5: UIButton!
    @IBOutlet weak var plusButton6: UIButton!
    @IBOutlet weak var plusButton7: UIButton!
    @IBOutlet weak var plusButton8: UIButton!
    @IBOutlet weak var plusButton9: UIButton!
    
    @IBOutlet weak var minusButton1: UIButton!
    @IBOutlet weak var minusButton2: UIButton!
    @IBOutlet weak var minusButton3: UIButton!
    @IBOutlet weak var minusButton4: UIButton!
    @IBOutlet weak var minusButton5: UIButton!
    @IBOutlet weak var minusButton6: UIButton!
    @IBOutlet weak var minusButton7: UIButton!
    @IBOutlet weak var minusButton8: UIButton!
    @IBOutlet weak var minusButton9: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var goMoneyButton: UIButton!
    
    
    
    
    
    @IBOutlet weak var ThisTimeTotalMoneyLabel: UILabel!
    @IBOutlet weak var ThisTimeTotalTextLabel: UILabel!
    
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var totalMoneyTextLabel: UILabel!
    
    
    var totalMoney = 0
    var count10000 = 0
    var total10000 = 0
    var count5000 = 0
    var total5000 = 0
    var count1000 = 0
    var total1000 = 0
    var count500 = 0
    var total500 = 0
    var count100 = 0
    var total100 = 0
    var count50 = 0
    var total50 = 0
    var count10 = 0
    var total10 = 0
    var count5 = 0
    var total5 = 0
    var count1 = 0
    var total1 = 0
    
    var ThisTimeTotalMoney = 0
    var saveTotalMoney = 0
    var goalMoney = 0
    var achievementRate = 0.00
    
    var db = Firestore.firestore()
    
    let uuid = UserDefaults.standard.object(forKey: "ID")
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var progressView: MBCircularProgressBarView!
    @IBOutlet weak var goalMoneyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        grabStoryboard()
        print(UIScreen.main.bounds.size.height)
        
        //progressViewのレイアウト
        let myBoundSize: CGSize = UIScreen.main.bounds.size
        let width = myBoundSize.width
        let progressViewWidth = width / 2.3
        
        progressView.frame.size.width = progressViewWidth
        progressView.frame.size.height = progressViewWidth
        progressView.frame = CGRect(x:width / 2 - (progressViewWidth / 2),y:29,width:progressViewWidth,height:progressViewWidth)
        goalMoneyLabel.text = "目標金額　¥" + String(goalMoney)
        goalMoneyLabel.frame = CGRect(x: 0, y: 8, width: width, height: 21)
        
        progressView.progressLineWidth = 3
        progressView.progressColor = .systemYellow
        progressView.progressStrokeColor = .systemYellow
        progressView.emptyLineWidth = 3
        
        
        
        
        //合計貯金額ラベルのレイアウト
        let totalMoneyTextLabelWidth = progressViewWidth / 2
        totalMoneyTextLabel.frame = CGRect(x:progressViewWidth / 2 - (totalMoneyTextLabelWidth / 2),y:progressViewWidth / 3,width:progressViewWidth / 2,height:27)
        
        let totalMoneyLabelWidth = progressViewWidth / 2
        totalMoneyLabel.frame = CGRect(x:progressViewWidth / 2 - (totalMoneyLabelWidth / 2),y:progressViewWidth / 3 + 27,width:progressViewWidth / 2,height:27)
        
        //moneyView layout
        let moneyViewSize = width * 0.278
        //右端と左端の空白
        let padding = width * 0.06
        let space = width * 0.024
        
        moneyView1.frame = CGRect(x:padding , y: progressViewWidth + 40, width: moneyViewSize, height: moneyViewSize)
        moneyView2.frame = CGRect(x:padding + space + moneyViewSize , y: progressViewWidth + 40, width: moneyViewSize, height: moneyViewSize)
        moneyView3.frame = CGRect(x:padding + space * 2 + moneyViewSize * 2 , y: progressViewWidth + 40, width: moneyViewSize, height: moneyViewSize)
        moneyView4.frame = CGRect(x:padding , y: progressViewWidth + 40 + moneyViewSize + space, width: moneyViewSize, height: moneyViewSize)
        moneyView5.frame = CGRect(x:padding + space + moneyViewSize , y: progressViewWidth + 40 + moneyViewSize + space , width: moneyViewSize, height: moneyViewSize)
        moneyView6.frame = CGRect(x:padding + space * 2 + moneyViewSize * 2  , y: progressViewWidth + 40 + moneyViewSize + space, width: moneyViewSize, height: moneyViewSize)
        moneyView7.frame = CGRect(x:padding , y: progressViewWidth + 40 + moneyViewSize * 2 + space * 2, width: moneyViewSize, height: moneyViewSize)
        moneyView8.frame = CGRect(x:padding + space + moneyViewSize , y: progressViewWidth + 40 + moneyViewSize * 2 + space * 2 , width: moneyViewSize, height: moneyViewSize)
        moneyView9.frame = CGRect(x:padding + space * 2 + moneyViewSize * 2 , y: progressViewWidth + 40 + moneyViewSize * 2 + space * 2, width: moneyViewSize, height: moneyViewSize)
        //-------------------------------------------------
        
        //moneyLabel layout
        let moneyLabelWidth = moneyViewSize * 0.86
        let moneyLabelHeight = moneyViewSize * 0.217
        let moneyLabelPositionY = moneyViewSize * 0.069
        let moneyLabelPositionX = (moneyViewSize / 2) - (moneyLabelWidth / 2)
        
        moneyLabel1.frame = CGRect(x:moneyLabelPositionX , y:moneyLabelPositionY , width:moneyLabelWidth , height: moneyLabelHeight)
        moneyLabel2.frame = CGRect(x:moneyLabelPositionX , y:moneyLabelPositionY , width:moneyLabelWidth , height: moneyLabelHeight)
        moneyLabel3.frame = CGRect(x:moneyLabelPositionX , y:moneyLabelPositionY , width:moneyLabelWidth , height: moneyLabelHeight)
        moneyLabel4.frame = CGRect(x:moneyLabelPositionX , y:moneyLabelPositionY , width:moneyLabelWidth , height: moneyLabelHeight)
        moneyLabel5.frame = CGRect(x:moneyLabelPositionX , y:moneyLabelPositionY , width:moneyLabelWidth , height: moneyLabelHeight)
        moneyLabel6.frame = CGRect(x:moneyLabelPositionX , y:moneyLabelPositionY , width:moneyLabelWidth , height: moneyLabelHeight)
        moneyLabel7.frame = CGRect(x:moneyLabelPositionX , y:moneyLabelPositionY , width:moneyLabelWidth , height: moneyLabelHeight)
        moneyLabel8.frame = CGRect(x:moneyLabelPositionX , y:moneyLabelPositionY , width:moneyLabelWidth , height: moneyLabelHeight)
        moneyLabel9.frame = CGRect(x:moneyLabelPositionX , y:moneyLabelPositionY , width:moneyLabelWidth , height: moneyLabelHeight)
        
        //金額毎の現在の合計を表示するラベル layout
        let thisTimeMoneyPositionY = (moneyViewSize / 2) - (moneyLabelHeight / 2)
        total10000Label.frame = CGRect(x: moneyLabelPositionX, y: thisTimeMoneyPositionY, width: moneyLabelWidth, height: moneyLabelHeight)
        total5000Label.frame = CGRect(x: moneyLabelPositionX, y: thisTimeMoneyPositionY, width: moneyLabelWidth, height: moneyLabelHeight)
        total1000Label.frame = CGRect(x: moneyLabelPositionX, y: thisTimeMoneyPositionY, width: moneyLabelWidth, height: moneyLabelHeight)
        total500Label.frame = CGRect(x: moneyLabelPositionX, y: thisTimeMoneyPositionY, width: moneyLabelWidth, height: moneyLabelHeight)
        total100Label.frame = CGRect(x: moneyLabelPositionX, y: thisTimeMoneyPositionY, width: moneyLabelWidth, height: moneyLabelHeight)
        total50Label.frame = CGRect(x: moneyLabelPositionX, y: thisTimeMoneyPositionY, width: moneyLabelWidth, height: moneyLabelHeight)
        total10Label.frame = CGRect(x: moneyLabelPositionX, y: thisTimeMoneyPositionY, width: moneyLabelWidth, height: moneyLabelHeight)
        total5Label.frame = CGRect(x: moneyLabelPositionX, y: thisTimeMoneyPositionY, width: moneyLabelWidth, height: moneyLabelHeight)
        total1Label.frame = CGRect(x: moneyLabelPositionX, y: thisTimeMoneyPositionY, width: moneyLabelWidth, height: moneyLabelHeight)
        //-------------------------------------------------
        
        //plusButton layout
        let buttonWidth = moneyViewSize * 0.391
        let buttonHeight = moneyViewSize * 0.217
        let plusX = (moneyViewSize / 2) + (moneyLabelPositionX / 2)
        let buttonY = moneyViewSize - buttonHeight - moneyLabelPositionX
                
        plusButton1.frame = CGRect(x: plusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        plusButton2.frame = CGRect(x: plusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        plusButton3.frame = CGRect(x: plusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        plusButton4.frame = CGRect(x: plusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        plusButton5.frame = CGRect(x: plusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        plusButton6.frame = CGRect(x: plusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        plusButton7.frame = CGRect(x: plusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        plusButton8.frame = CGRect(x: plusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        plusButton9.frame = CGRect(x: plusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        
        //minusButton layout
        let minusX = moneyLabelPositionX
        
        minusButton1.frame = CGRect(x: minusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        minusButton2.frame = CGRect(x: minusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        minusButton3.frame = CGRect(x: minusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        minusButton4.frame = CGRect(x: minusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        minusButton5.frame = CGRect(x: minusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        minusButton6.frame = CGRect(x: minusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        minusButton7.frame = CGRect(x: minusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        minusButton8.frame = CGRect(x: minusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        minusButton9.frame = CGRect(x: minusX, y: buttonY, width: buttonWidth, height: buttonHeight)
        
        //-------------------------------------------------
        
        //今回の貯金額のラベルのlayout
        
        let ThisTimeTotalTextLabelPositionY = 8 + goalMoneyLabel.frame.size.height + progressView.frame.size.height + (moneyViewSize * 3) + space * 3
        
        
        ThisTimeTotalTextLabel.frame = CGRect(x:0, y: ThisTimeTotalTextLabelPositionY, width: width, height: 30)
        //-------------------------------------------------
        
        //今回の貯金額の金額部分のlayout
        
        let ThisTimeTotalMoneyLabelPostitionY = ThisTimeTotalTextLabelPositionY + 30
        
        ThisTimeTotalMoneyLabel.frame = CGRect(x:0, y: ThisTimeTotalMoneyLabelPostitionY, width: width, height: 30)
        
        //-------------------------------------------------
        
        //cancelButton layout
        
        let cancelAndGoMoneyButtonPositionY = ThisTimeTotalMoneyLabelPostitionY + 30 + 10
        let cancelAndGoMoneyButtonWidth = (width - padding * 2) / 2
        let cancelAndGoMoneyButtonHeight = width * 0.084
        
        let cancelButtonPositionX = padding
        
        cancelButton.frame = CGRect(x: cancelButtonPositionX, y: cancelAndGoMoneyButtonPositionY, width: cancelAndGoMoneyButtonWidth, height: cancelAndGoMoneyButtonHeight)
        
        
        //plusButton layout
        let plusButtonPositionX = padding + cancelAndGoMoneyButtonWidth
        goMoneyButton.frame = CGRect(x: plusButtonPositionX, y: cancelAndGoMoneyButtonPositionY, width: cancelAndGoMoneyButtonWidth, height: cancelAndGoMoneyButtonHeight)
        
        //scrollView layout
        
        
        
        //print(cancelAndGoMoneyButtonPositionY + cancelAndGoMoneyButtonHeight + 40)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let goalMoney = UserDefaults.standard.integer(forKey: "goalMoney")
        goalMoneyLabel.text = "目標金額 ¥" + String(goalMoney)
        progressAnimation()
    }
    
    
    
    
    @IBAction func addMoney(_ sender: Any) {
        
        //プラスボタンを押したときにボタンのタグによってどこのボタンかを判別し、貯金額を増やす
        
        let button:UIButton = sender as! UIButton
        let tag = button.tag
        
        switch tag{
        case 1:
            if count10000 > 99{
                return
            }
            count10000 = count10000 + 1
            total10000 = 10000 * count10000
            ThisTimeTotalMoney = ThisTimeTotalMoney + 10000
            total10000Label.text = "¥" + String(total10000)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 2:
            if count5000 > 99{
                return
            }
            count5000 = count5000 + 1
            total5000 = 5000 * count5000
            ThisTimeTotalMoney = ThisTimeTotalMoney + 5000
            total5000Label.text = "¥" + String(total5000)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 3:
            if count1000 > 99{
                return
            }
            count1000 = count1000 + 1
            total1000 = 1000 * count1000
            ThisTimeTotalMoney = ThisTimeTotalMoney + 1000
            total1000Label.text = "¥" + String(total1000)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 4:
            if count500 > 99{
                return
            }
            count500 = count500 + 1
            total500 = 500 * count500
            ThisTimeTotalMoney = ThisTimeTotalMoney + 500
            total500Label.text = "¥" + String(total500)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 5:
            if count100 > 99{
                return
            }
            count100 = count100 + 1
            total100 = 100 * count100
            ThisTimeTotalMoney = ThisTimeTotalMoney + 100
            total100Label.text = "¥" + String(total100)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 6:
            if count50 > 99{
                return
            }
            count50 = count50 + 1
            total50 = 50 * count50
            ThisTimeTotalMoney = ThisTimeTotalMoney + 50
            total50Label.text = "¥" + String(total50)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 7:
            if count10 > 99{
                return
            }
            count10 = count10 + 1
            total10 = 10 * count10
            ThisTimeTotalMoney = ThisTimeTotalMoney + 10
            total10Label.text = "¥" + String(total10)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 8:
            if count5 > 99{
                return
            }
            count5 = count5 + 1
            total5 = 5 * count5
            ThisTimeTotalMoney = ThisTimeTotalMoney + 5
            total5Label.text = "¥" + String(total5)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 9:
            if count1 > 99{
                return
            }
            count1 = count1 + 1
            total1 = 1 * count1
            ThisTimeTotalMoney = ThisTimeTotalMoney + 1
            total1Label.text = "¥" + String(total1)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        default:
            break
        }
    }
    
    @IBAction func sendMoney(_ sender: Any) {
        
        if count10000 == 0 && count5000 == 0 && count1000 == 0 && count500 == 0 && count100 == 0 && count50 == 0 && count10 == 0 && count5 == 0 && count1 == 0{
            
            return
            
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM Hm", options: 0, locale: Locale(identifier: "ja_JP"))
        let formatterString = formatter.string(from: Date()) as String
        
        let postDate = Date().timeIntervalSince1970
        
        db.collection(Optional(uuid) as! String).addDocument(
            data:[
                "total": ThisTimeTotalMoney,
                "10000": count10000,
                "5000": count5000,
                "1000": count1000,
                "500": count500,
                "100": count100,
                "50": count50,
                "10": count10,
                "5": count5,
                "1": count1,
                "postDate": postDate,
                "postDateString": formatterString
            ]
        )
        
        
        
        progressAnimation()
       
        
        resetMoney()
        
    }
    
    func progressAnimation(){
        db.collection("\(Optional(uuid) as! String)").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let docTotal = document.data()["total"] as! Int
                    self.totalMoney = self.totalMoney + docTotal
                }
            }
            self.saveTotalMoney = self.totalMoney
            UserDefaults.standard.setValue(String(self.totalMoney), forKey: "totalMoney")
            self.totalMoneyLabel.text = "¥" + String((UserDefaults.standard.object(forKey: "totalMoney") as! NSString).intValue)
            self.totalMoney = 0
            
            self.goalMoney = Int((UserDefaults.standard.object(forKey: "goalMoney") as! NSString).doubleValue)
            self.achievementRate = Double(self.saveTotalMoney) / Double(self.goalMoney) * 100
            UserDefaults.standard.setValue(String(round(self.achievementRate)), forKey: "achievementRate")
            
            
            
            
            UIView.animate(withDuration: 1.0) {
                self.progressView.value = CGFloat(self.achievementRate)
            }
            
            
            
        }
        
    }
    
    @IBAction func removeMoney(_ sender: Any) {
        
        //プラスボタンを押したときにボタンのタグによってどこのボタンかを判別し、貯金額を減らす
        
        let button:UIButton = sender as! UIButton
        let tag = button.tag
        
        switch tag{
        case 1:
            if count10000 < 1{
                return
            }
            count10000 = count10000 - 1
            total10000 = 10000 * count10000
            ThisTimeTotalMoney = ThisTimeTotalMoney - 10000
            total10000Label.text = "¥" + String(total10000)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 2:
            if count5000 < 1{
                return
            }
            count5000 = count5000 - 1
            total5000 = 5000 * count5000
            ThisTimeTotalMoney = ThisTimeTotalMoney - 5000
            total5000Label.text = "¥" + String(total5000)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 3:
            if count1000 < 1{
                return
            }
            count1000 = count1000 - 1
            total1000 = 1000 * count1000
            ThisTimeTotalMoney = ThisTimeTotalMoney - 1000
            total1000Label.text = "¥" + String(total1000)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 4:
            if count500 < 1{
                return
            }
            count500 = count500 - 1
            total500 = 500 * count500
            ThisTimeTotalMoney = ThisTimeTotalMoney - 500
            total500Label.text = "¥" + String(total500)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 5:
            if count100 < 1{
                return
            }
            count100 = count100 - 1
            total100 = 100 * count100
            ThisTimeTotalMoney = ThisTimeTotalMoney - 100
            total100Label.text = "¥" + String(total100)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 6:
            if count50 < 1{
                return
            }
            count50 = count50 - 1
            total50 = 50 * count50
            ThisTimeTotalMoney = ThisTimeTotalMoney - 50
            total50Label.text = "¥" + String(total50)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 7:
            if count10 < 1{
                return
            }
            count10 = count10 - 1
            total10 = 10 * count10
            ThisTimeTotalMoney = ThisTimeTotalMoney - 10
            total10Label.text = "¥" + String(total10)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 8:
            if count5 < 1{
                return
            }
            count5 = count5 - 1
            total5 = 5 * count5
            ThisTimeTotalMoney = ThisTimeTotalMoney - 5
            total5Label.text = "¥" + String(total5)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        case 9:
            if count1 < 1{
                return
            }
            count1 = count1 - 1
            total1 = 1 * count1
            ThisTimeTotalMoney = ThisTimeTotalMoney - 1
            total1Label.text = "¥" + String(total1)
            ThisTimeTotalMoneyLabel.text = "¥" + String(ThisTimeTotalMoney)
        default:
            break
        }
        
    }
    
    
    
    @IBAction func cancel(_ sender: Any) {
        
        //今回の貯金額を0に戻す
        resetMoney()
        
    }
    
    func resetMoney(){
        
        ThisTimeTotalMoney = 0
        
        count10000 = 0
        total10000 = 0
        count5000 = 0
        total5000 = 0
        count1000 = 0
        total1000 = 0
        count500 = 0
        total500 = 0
        count100 = 0
        total100 = 0
        count50 = 0
        total50 = 0
        count10 = 0
        total10 = 0
        count5 = 0
        total5 = 0
        count1 = 0
        total1 = 0
        
        ThisTimeTotalMoneyLabel.text = "¥0"
        
        total10000Label.text = "¥0"
        total5000Label.text = "¥0"
        total1000Label.text = "¥0"
        total500Label.text = "¥0"
        total100Label.text = "¥0"
        total50Label.text = "¥0"
        total10Label.text = "¥0"
        total5Label.text = "¥0"
        total1Label.text = "¥0"
        
    }
    
    func grabStoryboard(){
        let height = UIScreen.main.bounds.size.height
        //iPhoneSE2 or iphone8
        if height == 667 {
            totalMoneyTextLabel.font = UIFont.boldSystemFont(ofSize: 15)
            totalMoneyLabel.font = UIFont.boldSystemFont(ofSize: 15)
            scrollView.contentSize = CGSize(width:self.view.frame.width, height:900)
        //iPod touch7
        } else if height == 568{
            totalMoneyTextLabel.font = UIFont.boldSystemFont(ofSize: 14)
            totalMoneyLabel.font = UIFont.boldSystemFont(ofSize: 14)
            goalMoneyLabel.font = UIFont.systemFont(ofSize: 11)
            moneyLabel1.font = UIFont.boldSystemFont(ofSize: 15)
            moneyLabel2.font = UIFont.boldSystemFont(ofSize: 15)
            moneyLabel3.font = UIFont.boldSystemFont(ofSize: 15)
            moneyLabel4.font = UIFont.boldSystemFont(ofSize: 15)
            moneyLabel5.font = UIFont.boldSystemFont(ofSize: 15)
            moneyLabel6.font = UIFont.boldSystemFont(ofSize: 15)
            moneyLabel7.font = UIFont.boldSystemFont(ofSize: 15)
            moneyLabel8.font = UIFont.boldSystemFont(ofSize: 15)
            moneyLabel9.font = UIFont.boldSystemFont(ofSize: 15)
            
            total10000Label.font = UIFont.boldSystemFont(ofSize: 14)
            total5000Label.font = UIFont.boldSystemFont(ofSize: 14)
            total1000Label.font = UIFont.boldSystemFont(ofSize: 14)
            total500Label.font = UIFont.boldSystemFont(ofSize: 14)
            total100Label.font = UIFont.boldSystemFont(ofSize: 14)
            total50Label.font = UIFont.boldSystemFont(ofSize: 14)
            total10Label.font = UIFont.boldSystemFont(ofSize: 14)
            
            ThisTimeTotalMoneyLabel.font = UIFont.boldSystemFont(ofSize: 17)
            ThisTimeTotalTextLabel.font = UIFont.boldSystemFont(ofSize: 12)
            
            total5Label.font = UIFont.boldSystemFont(ofSize: 14)
            total1Label.font = UIFont.boldSystemFont(ofSize: 14)
            scrollView.contentSize = CGSize(width:self.view.frame.width, height:900)
            
            goMoneyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
         //iphone12 or iphone11Pro
        }else if height == 844 || height == 812{
            totalMoneyTextLabel.font = UIFont.boldSystemFont(ofSize: 15)
            totalMoneyLabel.font = UIFont.boldSystemFont(ofSize: 15)
         //iphone8Plus
        }else if height == 736{
            scrollView.contentSize = CGSize(width:self.view.frame.width, height:900)
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
