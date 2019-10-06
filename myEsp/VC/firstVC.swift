//
//  firstVC.swift
//  myEsp
//
//  Created by ujs on 10/2/19.
//  Copyright © 2019 ksm. All rights reserved.
//

import UIKit

class firstVC: UIViewController {

    @IBOutlet weak var signUpbtn: UIButton!
    @IBOutlet weak var signInbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpbtn.backgroundColor = .clear
        signUpbtn.layer.borderColor = UIColor.black.cgColor
        signUpbtn.layer.borderWidth = 1
        
        signInbtn.backgroundColor = .clear
        signInbtn.layer.borderColor = UIColor.black.cgColor
        signInbtn.layer.borderWidth = 1
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! signUpVC
        //            controller.webVIewUrl = url
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    @IBAction func signIn(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "signInVC") as! signInVC
        //            controller.webVIewUrl = url
        self.navigationController?.pushViewController(controller, animated: true)
        
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
