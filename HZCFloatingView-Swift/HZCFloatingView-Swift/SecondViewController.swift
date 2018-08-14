//
//  SecondViewController.swift
//  HZCFloatingView-Swift
//
//  Created by Apple on 2018/8/10.
//  Copyright © 2018年 AiChen smart Windows and doors technology co., LTD. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    deinit {
        print("\n- " + (#file as NSString).pathComponents.last! , #function + " line:\(#line) -\n")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "2222"
        view.backgroundColor = UIColor.brown
        // Do any additional setup after loading the view.
    }


    
    @IBAction func clickButton(_ sender: UIButton) {

        HZCFloatView.showWithViewController(floatingVC: self)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
