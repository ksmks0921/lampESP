//
//  ControlDeviceVC.swift
//  myEsp
//
//  Created by ujs on 10/2/19.
//  Copyright © 2019 ksm. All rights reserved.
//

import UIKit
import Alamofire
import UserNotifications

class ControlDeviceVC: BaseViewController {

    @IBOutlet weak var center: UIView!
    @IBOutlet weak var manualbtn: UIButton!
    @IBOutlet weak var timebtn: UIButton!
    @IBOutlet weak var current_time: UILabel!
    @IBOutlet weak var selectTime: UILabel!
    
    var status: String?
    var statuscode: String?
    var onoff: Bool?
    
    var selecthour: String!
    var selectminute: String!
    var data_flag:Bool?
    
    private let networkingClient = NetworkingClient()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        addSlideMenuButton()
        
        manualbtn.backgroundColor = .clear
        manualbtn.layer.borderColor = UIColor.black.cgColor
        manualbtn.layer.borderWidth = 1
        
        timebtn.backgroundColor = .clear
        timebtn.layer.borderColor = UIColor.black.cgColor
        timebtn.layer.borderWidth = 1
        onoff = true // at first the lamp is turned off status
        
        center.backgroundColor = .clear
        center.layer.borderColor = UIColor.black.cgColor
        center.layer.borderWidth = 1
        
        selectTime.backgroundColor = .clear
        selectTime.layer.borderColor = UIColor.black.cgColor
        selectTime.layer.borderWidth = 1
        
        if(data_flag == true)
        {
            selectTime.text = self.selecthour + ":" + self.selectminute
        }
        else {
            selectTime.text = "Select Time"
        }
        
        Timer.scheduledTimer(timeInterval: 0.1, target:self, selector: Selector(("updateTime")), userInfo:nil, repeats:true)
        
        Timer.scheduledTimer(timeInterval: 1, target:self, selector: Selector(("startAuto")), userInfo:nil, repeats:true)
        
        
        let timepicker = UITapGestureRecognizer(target: self, action: #selector(alertTimePicker(gesture:)))
        selectTime.isUserInteractionEnabled = true
        selectTime.addGestureRecognizer(timepicker)
        
        
        
        // Do any additional setup after loading the view.
    }
    @objc func updateTime(){
        
        current_time.text = DateFormatter.localizedString(from: NSDate() as Date,dateStyle: DateFormatter.Style.none,timeStyle: DateFormatter.Style.full)
 
    }
    @objc func startAuto(){
        
        let date = Date()
        let calender = Calendar.current
        let hour = String(calender.component(.hour, from: date))
        let minute = String(calender.component(.minute, from: date))
        let second = String(calender.component(.second, from: date))
        if(self.selecthour != nil){
            if(self.selecthour == hour){
                if(self.selectminute == minute){
                    if(second == "0"){
                        autoTurnOn()
                    }
                    
                }
                
            }
        }
 
    }
    
    @objc func alertTimePicker(gesture: UIGestureRecognizer) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "TimePickerVC") as! TimePickerVC
        //            controller.webVIewUrl = url
        self.navigationController?.pushViewController(controller, animated: true)

       
        
    }

    func sendNotification(flag:Bool){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            //
        }
        let content = UNMutableNotificationContent()
        content.title = "Hey! I am a notification."
        content.body = "Look at me!"
        
        let date = Date()
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        center.add(request) { (error) in
            //
        }
//        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: )
        if (flag == true){
            
        }
        else{
            
        }
    }
    func autoTurnOn(){
        if (onoff == true)
        {
            self.statuscode = "1"
        }
        else{
            self.statuscode = "0"
        }
        guard let urlToExcute = URL(string: "https://cloud.arest.io/ksmks0921/digital/4/"+self.statuscode! ) else { return }
        networkingClient.execute(urlToExcute) {  (json, error) in
            if error != nil {
                
            } else if let json = json {
                let parseData = json
                
                for obj in parseData {
                    
                    for (key, value) in obj {
                        
                        if (key == "connected") {
                            if(value as? Bool == true){
                                self.status = value as? String;
                                
                                if (self.onoff == true)
                                {
                                    self.sendNotification(flag:true)
                                    self.onoff = false
                                    self.manualbtn.setTitle("OFF",for: .normal)
                                    
                                }
                                else{
                                    self.sendNotification(flag:false)
                                    self.onoff = true
                                    self.manualbtn.setTitle("ON",for: .normal)
                                }
                            }
                            else{
                                let alert = UIAlertController(title: "Alert", message: "Please make sure your device is online!", preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
                                //                                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                                
                                self.present(alert, animated: true)
                            }
                            
                        }
                    }
                    
                }
                
            }
            
        }//end of excute netWordingClient
    }
    @IBAction func startManual(_ sender: Any) {
        if (onoff == true)
        {
            self.statuscode = "1"
        }
        else{
            self.statuscode = "0"
        }
        guard let urlToExcute = URL(string: "https://cloud.arest.io/ksmks0921/digital/4/"+self.statuscode! ) else { return }
        networkingClient.execute(urlToExcute) {  (json, error) in
            if error != nil {
                
            } else if let json = json {
                let parseData = json
                
                for obj in parseData {
                    
                    for (key, value) in obj {
                        
                        if (key == "connected") {
                            if(value as? Bool == true){
                                self.status = value as? String;
                                if (self.onoff == true)
                                {
                                    self.onoff = false
                                    self.manualbtn.setTitle("OFF",for: .normal)
                                }
                                else{
                                    self.onoff = true
                                    self.manualbtn.setTitle("ON",for: .normal)
                                }
                            }
                            else{
                                let alert = UIAlertController(title: "Alert", message: "Please make sure your device is online!", preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
//                                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                                
                                self.present(alert, animated: true)
                            }
                            
                        }
                    }
                    
                }

            }
            
        }//end of excute netWordingClient
    }
    
    @IBAction func startwithTime(_ sender: Any) {
        
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
