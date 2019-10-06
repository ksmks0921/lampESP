//
//  TimePickerVC.swift
//  myEsp
//
//  Created by ujs on 10/5/19.
//  Copyright © 2019 ksm. All rights reserved.
//

import UIKit

class TimePickerVC: UIViewController {

    @IBOutlet weak var selecttime: UILabel!
    @IBOutlet weak var timepicker: UIDatePicker!
    @IBOutlet weak var savebtn: UIButton!
    
    var hour: Int!
    var minute: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savebtn.backgroundColor = .clear
        savebtn.layer.borderColor = UIColor.black.cgColor
        savebtn.layer.borderWidth = 1
        
        timepicker?.datePickerMode = UIDatePicker.Mode.time
        timepicker?.minimumDate = Date.calculateDate(day: 1, month: 1, year: 2017, hour: 0, minute: 0)
        timepicker?.maximumDate = Date.calculateDate(day: 31, month: 1, year: 2017, hour: 0, minute: 0)
       
       
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ControlDeviceVC") as! ControlDeviceVC
        //            controller.webVIewUrl = url
        controller.selecthour = String(self.hour)
        controller.selectminute = String(self.minute)
        controller.data_flag = true

        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    @IBAction func onChangeTime(_ sender: UIDatePicker, forEvent event: UIEvent) {
        
            selecttime?.text = "hour: \(sender.date.getDayMonthYearHourMnuteSecond().hour), min: \(sender.date.getDayMonthYearHourMnuteSecond().minute)"
            
            self.hour = sender.date.getDayMonthYearHourMnuteSecond().hour
            self.minute = sender.date.getDayMonthYearHourMnuteSecond().minute
        
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
