//
//  RegisterViewController.swift
//  PiggyBank
//
//  Created by 村井海斗 on 2021/02/05.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var moneyField: UITextField!
    @IBOutlet weak var decisionButton: UIButton!
    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var alertMoneyLabel: UILabel!
    
    let uuid = UUID()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decisionButton?.layer.cornerRadius = 20
        decisionButton?.layer.borderColor = UIColor.black.cgColor
        decisionButton?.layer.borderWidth = 2.0
        self.moneyField?.keyboardType = UIKeyboardType.numberPad
        
        alertTitleLabel.isHidden = true
        alertMoneyLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @IBAction func touchRegister(_ sender: Any) {
        
        if titleField.text?.isEmpty == false && moneyField.text?.isEmpty == false{
            UserDefaults.standard.set(titleField.text, forKey: "title")
            UserDefaults.standard.set(moneyField.text, forKey: "goalMoney")
            UserDefaults.standard.set(String(describing: uuid), forKey: "ID")
            UserDefaults.standard.set("", forKey: "achievementRate")
        }else{
            if titleField.text?.isEmpty == true {
                alertTitleLabel.isHidden = false
            }else{
                alertTitleLabel.isHidden = true
            }
            
            if moneyField.text?.isEmpty == true {
                alertMoneyLabel.isHidden = false
            }else{
                alertMoneyLabel.isHidden = true
            }
            
            return
        }
        
        
        performSegue(withIdentifier: "goHome", sender: nil)
        
        print(UserDefaults.standard.object(forKey: "title") as Any)
        print(UserDefaults.standard.object(forKey: "goalMoney") as Any)
        print(UserDefaults.standard.object(forKey: "ID") as Any)
        print(UserDefaults.standard.object(forKey: "achievementRate") as Any)
    }
    
        /*    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
