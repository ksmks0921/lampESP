//
//  signUpVC.swift
//  myEsp
//
//  Created by ujs on 10/2/19.
//  Copyright © 2019 ksm. All rights reserved.
//

import UIKit

class signUpVC: UIViewController {

    @IBOutlet weak var finishbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func finish(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "verifyPhoneVC") as! verifyPhoneVC
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
