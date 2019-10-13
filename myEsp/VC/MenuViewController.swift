//
//  MenuViewController.swift
//  myEsp
//
//  Created by ujs on 10/2/19.
//  Copyright © 2019 ksm. All rights reserved.
//

import UIKit
protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sections = [
        "Personal Information", "Pairing", "About", "Contact US"
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
//        cell.textLabel?.text = sections[indexPath]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ControlDeviceVC") as! ControlDeviceVC
        //            controller.webVIewUrl = url
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBOutlet weak var btnCloseMenuOverlay: UIButton!
    
    var btnMenu : UIButton!
    var delegate : SlideMenuDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        btnMenu.tag = 0
        btnMenu.isHidden = false
        if (self.delegate != nil) {
            var index = Int32(sender.tag)
            if(sender == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
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
