//
//  ViewController.swift
//  The Arithmetic App
//
//  Created by Nalivela,Saikumar on 2/14/19.
//  Copyright © 2019 Nalivela,Saikumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var activityPicker: UIPickerView!
    
    @IBOutlet weak var weightTF: UITextField!
    
    @IBOutlet weak var exerciseTimeTF: UITextField!
    
    @IBOutlet weak var energyConsumedLBL: UILabel!
    
    @IBOutlet weak var timeCountLBL: UILabel!
    
    var dataActivity: [String] = [String]()
    
    @IBAction func clearFunction(_ sender: Any) {
        weightTF.text! = ""
        exerciseTimeTF.text! = ""
        energyConsumedLBL.text! = "0.0 Cal"
        timeCountLBL.text! = "0.0 minutes"
        activityPicker.selectRow(0, inComponent: 0, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.6504521925, blue: 0.8922450174, alpha: 1)
        
        self.activityPicker.delegate = self
        self.activityPicker.dataSource = self
        
        dataActivity = ["Bicycling", "Jumping rope", "Running - slow", "Running - fast", "Tennis", "Swimming"]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataActivity.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataActivity[row]
    }
    
    func eneryConsumed(during: String, weight: Double, time: Double) -> Double {
        var selectedAction = 0.0
        switch during{
        case "Bicycling", "Tennis": selectedAction = 8.0
        case "Jumping rope": selectedAction = 12.3
        case "Running - slow": selectedAction = 9.8
        case "Running - fast": selectedAction = 23.0
        case "Swimming": selectedAction = 5.8
        default: selectedAction = 0.0
        }
        let weightinKg = Double(weight)/2.2
        return selectedAction * 3.5 * weightinKg/Double(200) * time
    }
    
    func timeToLosePounds(during: String, weight: Double) -> Double {
        let eneryConsumedinCalories = eneryConsumed(during: during, weight: weight, time: 1.0)
        if weight == 0.0{
            return 0
        }else{
            return Double(3500)/eneryConsumedinCalories
        }
    }
    
    
    @IBAction func convertIt(_ sender: Any) {
        let selectedValue = dataActivity[activityPicker.selectedRow(inComponent: 0)]
        let energyConsumed = eneryConsumed(during: selectedValue, weight: Double(weightTF.text!) ?? 0.0, time: Double(exerciseTimeTF.text!) ?? 0.0)
        energyConsumedLBL.text = String(format: "%.1f Cal", energyConsumed)
        let timeToLoseAPound = timeToLosePounds(during: selectedValue, weight: Double(weightTF.text!) ?? 0.0)
        timeCountLBL.text! = String(format: "%.1f minutes", timeToLoseAPound)
    }
    
}



