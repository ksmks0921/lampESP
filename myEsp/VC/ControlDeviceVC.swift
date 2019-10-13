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
    @IBOutlet weak var autobtn: UIButton!
    
    var status: String?
    var statuscode: String?
    var onoff: Bool?
    var time_value:String?
    var selecthour: Int!
    var selectminute: Int!
    var auto_onoff:String!
    
    private let networkingClient = NetworkingClient()
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        
        getStatus()
        getAutoStatus()
        initui()
   
        Timer.scheduledTimer(timeInterval: 0.1, target:self, selector: Selector(("updateTime")), userInfo:nil, repeats:true)
        Timer.scheduledTimer(timeInterval: 1, target:self, selector: Selector(("startAuto")), userInfo:nil, repeats:true)
        
        
        let timepicker = UITapGestureRecognizer(target: self, action: #selector(alertTimePicker(gesture:)))
        selectTime.isUserInteractionEnabled = true
        selectTime.addGestureRecognizer(timepicker)
        
        
//        NotificationCenter.default.addObserver(self, selector: <#T##Selector#>, name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
        // Do any additional setup after loading the view.
    }
    
    func initui() {
        
        addSlideMenuButton()
        
        let colorBtn = UIColor(red: 38.0/255.0, green: 229.0/255.0, blue: 122.0/255.0, alpha: 1)
        let colorWhite = UIColor(red: 38, green: 229, blue: 122, alpha: 1)
//        if(self.auto_onoff == true){
//             manualbtn.backgroundColor = colorBtn
//        }
//        else {
//            manualbtn.backgroundColor = colorWhite
//        }
        manualbtn.backgroundColor = colorWhite
       
        
        manualbtn.layer.borderColor = UIColor.black.cgColor
        manualbtn.layer.borderWidth = 1
        
        timebtn.backgroundColor = colorWhite
        timebtn.layer.borderColor = UIColor.black.cgColor
        timebtn.layer.borderWidth = 1
        onoff = true // at first the lamp is turned off status
        
        center.backgroundColor = .clear
        center.layer.borderColor = UIColor.black.cgColor
        center.layer.borderWidth = 1
        
        selectTime.backgroundColor = .clear
        selectTime.layer.borderColor = UIColor.black.cgColor
        selectTime.layer.borderWidth = 1
     
    }
    func getStatus(){
       
        let urlToExcute = URL(string: "http://192.168.0.197/time")
        networkingClient.execute(urlToExcute!) {  (json, error) in
            if error != nil {
                self.selectTime.text = "No connection to server!"
            } else if let json = json {
                let parseData = json
                
                for obj in parseData {
                    
                    for (key, value) in obj {
                        
                        if (key == "value") {
                            
                            self.selectTime.text = value as? String
                            
                        }
                        
                    }
                }
                
            }
            
        }
        
        
    }
    func getAutoStatus(){
        let urlToExcute = URL(string: "http://192.168.0.197/getauto")
        networkingClient.execute(urlToExcute!) {  (json, error) in
            if error != nil {
                self.autobtn.setTitle("No connection to server!",for: .normal)
            } else if let json = json {
                let parseData = json
                
                for obj in parseData {
                    
                    for (key, value) in obj {
                        
                        if (key == "value") {
                            
                            self.auto_onoff = (value as! String)
                 

                                if (self.auto_onoff! == "start"){
                                    print(self.auto_onoff!)
                                    self.timebtn.setTitle("Pause", for: .normal)
                                    self.manualbtn.isEnabled = false
                                }
                                else if (self.auto_onoff! == "stop"){
                                    self.timebtn.setTitle("Start",for: .normal)
                                    self.manualbtn.isEnabled = true
                                }
                                else {
                                    self.timebtn.setTitle("No Data!",for: .normal)
                                }

                            
                        }
                        
                    }
                }
                
            }
            
        }
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
        
        if (self.auto_onoff == "start"){
            
            if(self.selecthour != nil){
                if(String(self.selecthour) == hour){
                    if(String(self.selectminute) == minute){
                        if(second == "0"){
                            
                            autoTurnOn()
                        }
                        
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

//    func sendNotification(flag:Bool){
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
//            //
//        }
//        let content = UNMutableNotificationContent()
//        content.title = "Hey! I am a notification."
//        content.body = "Look at me!"
//
//        let date = Date()
//        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//        let uuidString = UUID().uuidString
//        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
//        center.add(request) { (error) in
//            //
//        }
////        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: )
//        if (flag == true){
//
//        }
//        else{
//
//        }
//    }
    func autoTurnOn(){
        
        guard let urlToExcute = URL(string: "http://192.168.0.197/ledOn") else { return }
        networkingClient.execute(urlToExcute) {  (json, error) in
            if error != nil {
                let alert = UIAlertController(title: "Alert", message: "Please make sure your device is online!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
                //                                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
            } else if let json = json {
                let parseData = json
                
                for obj in parseData {
                    
                    for (key, value) in obj {
                        
                        if (key == "status") {
                         
                            if(value as? String == "on"){
                                self.onoff = false
                                self.manualbtn.setTitle("OFF",for: .normal)
                                
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
            self.statuscode = "ledOn"
        }
        else{
            self.statuscode = "ledOff"
        }
        guard let urlToExcute = URL(string: "http://192.168.0.197/"+self.statuscode! ) else { return }
        networkingClient.execute(urlToExcute) {  (json, error) in
            if error != nil {
                let alert = UIAlertController(title: "Alert", message: "Please make sure your device is online!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
                //                                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
            } else if let json = json {
                let parseData = json
                
                for obj in parseData {
                    
                    for (key, value) in obj {
                        
                        if (key == "status") {
                            print(value)
                            if(value as? String == "on"){
 
                                self.onoff = false
                                self.manualbtn.setTitle("OFF",for: .normal)
                               
                              
                            }
                            else{
                                self.onoff = true
                                self.manualbtn.setTitle("ON",for: .normal)
                        
                            }
                            
                        }
                    }
                    
                }

            }
            
        }//end of excute netWordingClient
    }
    
    @IBAction func startwithTime(_ sender: Any) {
     
        guard let urlToExcute = URL(string: "http://192.168.0.197/auto?status=" + String(self.auto_onoff)) else { return }
        networkingClient.execute(urlToExcute) {  (json, error) in
            if error != nil {
                let alert = UIAlertController(title: "Alert", message: "Please make sure your device is online!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
                //                                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
            } else if let json = json {
                let parseData = json
                
                for obj in parseData {
                    
                    for (key, value) in obj {
                        
                        if (key == "status") {
                            if(value as? String == "start"){
                                self.timebtn.setTitle("Pause",for: .normal)
                                self.auto_onoff = "stop"
                                self.manualbtn.isEnabled = false
                                
                                
                            }
                            else{
                                self.timebtn.setTitle("Start",for: .normal)
                                self.auto_onoff = "start"
                                self.manualbtn.isEnabled = true
                            }
                            
                        }
                        
                    }
                }
                
            }
            
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
