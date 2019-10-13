//
//  TimePickerVC.swift
//  myEsp
//
//  Created by ujs on 10/5/19.
//  Copyright © 2019 ksm. All rights reserved.
//

import UIKit
import Alamofire

class TimePickerVC: UIViewController {

    @IBOutlet weak var selecttime: UILabel!
    @IBOutlet weak var timepicker: UIDatePicker!
    @IBOutlet weak var savebtn: UIButton!
    
    var hour: Int!
    var minute: Int!
    
    private let networkingClient = NetworkingClient()
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
        
        guard let urlToExcute = URL(string: "http://192.168.0.197/update?hour=" + makehour2(param: String(self.hour)) + "&minute=" + makehour2(param: String(self.minute))) else { return }
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
                            if(value as? String == "updated"){
                                
                                let controller = self.storyboard?.instantiateViewController(withIdentifier: "ControlDeviceVC") as! ControlDeviceVC
                                //            controller.webVIewUrl = url
                                controller.selecthour = self.hour
                                controller.selectminute = self.minute
                                
                                self.navigationController?.pushViewController(controller, animated: true)
                                
                            }
                  
                        }
                        
                    }
                }
                
            }
            
        }
    
        
        

        
        
    }
    @IBAction func onChangeTime(_ sender: UIDatePicker, forEvent event: UIEvent) {
        
//            selecttime?.text = "hour: \(sender.date.getDayMonthYearHourMnuteSecond().hour), min: \(sender.date.getDayMonthYearHourMnuteSecond().minute)"
        
//        self.hour = makehour2(param: String(sender.date.getDayMonthYearHourMnuteSecond().hour))
//        self.minute = makehour2(param: String(sender.date.getDayMonthYearHourMnuteSecond().minute))
        
        self.hour = sender.date.getDayMonthYearHourMnuteSecond().hour
        self.minute = sender.date.getDayMonthYearHourMnuteSecond().minute
    
        selecttime?.text = "hour:" + makehour2(param: String(self.hour)) + " min:" + makehour2(param: String(self.minute))
        
    }
    
    func makehour2(param:String) ->String{
        
        let hour_return:String!
        
        if(param.count == 1){
            hour_return = "0"+param
        }
        else {
            hour_return = param
        }
        return hour_return
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
