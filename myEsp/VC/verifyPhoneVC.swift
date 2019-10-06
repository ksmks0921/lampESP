//
//  verifyPhoneVC.swift
//  myEsp
//
//  Created by ujs on 10/2/19.
//  Copyright © 2019 ksm. All rights reserved.
//

import UIKit

class verifyPhoneVC: UIViewController {

    @IBOutlet weak var activatebtn: UIButton!
    @IBOutlet weak var resendbtn: UIButton!
    @IBOutlet weak var backbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activatebtn.backgroundColor = .clear
        activatebtn.layer.borderColor = UIColor.black.cgColor
        activatebtn.layer.borderWidth = 1
        
        resendbtn.backgroundColor = .clear
        resendbtn.layer.borderColor = UIColor.black.cgColor
        resendbtn.layer.borderWidth = 1

        // Do any additional setup after loading the view.
    }
    
    @IBAction func activate(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! homeVC
        //            controller.webVIewUrl = url
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func resend(_ sender: Any) {
        
    }
    /*
     @IBAction func gotoback(_ sender: Any) {
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
