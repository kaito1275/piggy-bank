//
//  HomeViewController.swift
//  PiggyBank
//
//  Created by 村井海斗 on 2021/02/06.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = UserDefaults.standard.string(forKey: "title")
        
        self.navigationController?.navigationBar.barTintColor = .systemYellow
        
        selectedIndex = 1
        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.tag == 1) {
            self.navigationItem.title = UserDefaults.standard.string(forKey: "title")
        }else if(item.tag == 2) {
            self.navigationItem.title = "貯金履歴"
        }else if(item.tag == 3){
            self.navigationItem.title = "設定"
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
            
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
