//
//  ViewController.swift
//  NMTimeSettingTableViewDemo
//
//  Created by Natalia Macambira on 07/05/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NMTimeSettingTableViewControllerDelegate {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var daysOfTheWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var hours: [[String]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Day and Time"
    }
    
    //MARK: Helper methods
    func convertToString(_ hoursArray: [[String]]) -> String {
        var dayAndTimeString = ""
        for (index, hours) in hoursArray.enumerated() {
            if !hours.isEmpty {
                if hours[2] == "" {
                    dayAndTimeString += "\(daysOfTheWeek[index]): \(hours[0]) - \(hours[1])\n"
                } else {
                    dayAndTimeString += "\(daysOfTheWeek[index]): \(hours[0]) - \(hours[1]) | \(hours[2]) - \(hours[3])\n"
                }
            }
        }
        return dayAndTimeString
    }
    
    //MARK: Navigation    
    func timeSettingTableViewControllerData(timeArray: [[String]]) {
        self.timeLabel.text = convertToString(timeArray)
        self.hours = timeArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == "timeSettingTableView" {
            if let destination = segue.destination as? NMTimeSettingTableViewController {
                destination.timeSettingDelegate = self
                destination.hoursLabels = self.hours
            }
        }
    }
}
