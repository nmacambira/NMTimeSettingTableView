//
//  NMTimeSettingTableViewController.swift
//  NMTimeSettingTableViewDemo
//
//  Created by Natalia Macambira on 07/05/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

protocol NMTimeSettingTableViewControllerDelegate {
    func timeSettingTableViewControllerData(timeArray: [[String]])
}

@IBDesignable
final class NMTimeSettingTableViewController: UIViewController, NMTimeSettingTableViewDatePickerDelegate {
    
    // MARK: - Inspectables
    @IBInspectable var tableViewTitle: String = "Time setting" {
        didSet {
            tableViewTitleString = tableViewTitle
        }
    }
    
    @IBInspectable var mondayLabel: String = "MONDAY" {
        didSet {
            daysOfTheWeek[0] = mondayLabel.uppercased()
        }
    }
    
    @IBInspectable var tuesdayLabel: String = "TUESDAY" {
        didSet {
            daysOfTheWeek[1] = tuesdayLabel.uppercased()
        }
    }
    
    @IBInspectable var wednesdayLabel: String = "WEDNESDAY"{
        didSet {
            daysOfTheWeek[2] = wednesdayLabel.uppercased()
        }
    }
    
    @IBInspectable var thursdayLabel: String = "THURSDAY" {
        didSet {
            daysOfTheWeek[3] = thursdayLabel.uppercased()
        }
    }
    
    @IBInspectable var fridayLabel: String = "FRIDAY" {
        didSet {
            daysOfTheWeek[4] = fridayLabel.uppercased()
        }
    }
    
    @IBInspectable var saturdayLabel: String = "SATURDAY" {
        didSet {
            daysOfTheWeek[5] = saturdayLabel.uppercased()
        }
    }
    
    @IBInspectable var sundayLabel: String = "SUNDAY" {
        didSet {
            daysOfTheWeek[6] = sundayLabel.uppercased()
        }
    }
    
    @IBInspectable var addTimeLabel: String = "ADD TIME" {
        didSet {
            addTimeString = addTimeLabel.uppercased()
        }
    }
    
    @IBInspectable var fromLabel: String = "FROM" {
        didSet {
            fromString = fromLabel.uppercased()
        }
    }
    
    @IBInspectable var toLabel: String = "TO" {
        didSet {
            toString = toLabel.uppercased()
        }
    }
    
    @IBInspectable var closedLabel: String = "Closed" {
        didSet {
            closedString = closedLabel
        }
    }
    
    @IBInspectable var timeFrom: String = "09:00" {
        didSet {
            initialHour[0] = timeFrom
        }
    }
    
    @IBInspectable var timeTo: String = "17:00" {
        didSet {
            initialHour[1] = timeTo
        }
    }
    
    @IBInspectable var datePickerTitle: String = "Please choose the time and press 'Select' or 'Cancel'" {
        didSet {
            datePickerTitleString = datePickerTitle
        }
    }
    
    @IBInspectable var datePickerCancel: String = "Cancel" {
        didSet {
            datePickerCancelString = datePickerCancel
        }
    }
    
    @IBInspectable var datePickerSelect: String = "Select" {
        didSet {
            datePickerSelectString = datePickerSelect
        }
    }
    
    // MARK: - Instance Properties
    let tableView = UITableView()
    let daysOfTheWeekCelIdentifier = "header"
    let addTimeCellIdentifier = "addTime"
    let timeCellIdentifier = "body"
    
    var daysOfTheWeekSelected: [Int] = []
    var addTimeBool: [Int] = []
    var secondBodyLineThatIsShown: [Int] = []
    var lastSwitchActive: Int!
    var hoursLabels: [[String]] = []
    
    var tableViewTitleString = "Time setting"
    var daysOfTheWeek: [String] = ["MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", "SUNDAY"]
    var addTimeString: String = "ADD TIME"
    var fromString: String = "FROM"
    var toString: String = "TO"
    var closedString: String = "Closed"
    var initialHour: [String] = ["09:00", "17:00"]
    
    var datePickerTitleString: String = "Please choose the time and press 'Select' or 'Cancel'"
    var datePickerCancelString: String = "Cancel"
    var datePickerSelectString: String = "Select"
    
    var timeSettingDelegate: NMTimeSettingTableViewControllerDelegate?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = tableViewTitleString
        setupNavigationItem()
        setupTableView()
        fillHoursLabels()
    }
    
    // MARK: - Setup methods
    func setupNavigationItem() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(saveBarButtonAction(_:)))
        self.navigationItem.rightBarButtonItem  = saveButton
    }
    
    func setupTableView() {
        let screenSize: CGRect = UIScreen.main.bounds
        tableView.frame = CGRect(x: 16, y: 0, width: screenSize.width - 32, height: screenSize.height)
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.register(NMDaysOfTheWeekCell.self, forCellReuseIdentifier: daysOfTheWeekCelIdentifier)
        tableView.register(NMAddTimeCell.self, forCellReuseIdentifier: addTimeCellIdentifier)
        tableView.register(NMTimeCell.self, forCellReuseIdentifier: timeCellIdentifier)
    }
    
    func fillHoursLabels() {
        if hoursLabels.isEmpty {
            populateLabelsWithEmptyStrings()
        } else {
            for (index, dayOfTheWeek) in hoursLabels.enumerated() {
                if dayOfTheWeek.isEmpty {
                    hoursLabels[index] = [initialHour[0], initialHour[1], "", ""]
                } else {
                    daysOfTheWeekSelected.append(index)
                    if dayOfTheWeek[2] != "" && dayOfTheWeek[3] != "" {
                        secondBodyLineThatIsShown.append(index)
                    }
                }
            }
        }
    }
    
    //MARK: - Helper methods
    func populateLabelsWithEmptyStrings () {
        for _ in 0...6 {
            let hours: [String] = [initialHour[0], initialHour[1], "", ""]
            hoursLabels.append(hours)
        }
    }
    
    func timeCellGesture(atIndexPath indexPath: IndexPath, withTag tag: Int) -> NMTapGestureRecognizer  {
        let gesture = NMTapGestureRecognizer(target: self, action: #selector(callDatePicker(_:)))
        gesture.indexPath = indexPath
        gesture.tag = tag
        
        return gesture
    }
    
    func setSecondBodyLineCell(_ cell: NMTimeCell, atIndexPath indexPath: IndexPath, withTitle title: String, andTitleFont font: UIFont) {
        cell.plusButton.isHidden = false
        cell.plusButton.setTitle(title, for: UIControlState())
        cell.plusButton.titleLabel?.font = font
        cell.plusButton.addTarget(self, action: #selector(showHideCellLine(_:)), for: UIControlEvents.touchUpInside)
        cell.plusButton.indexPath = indexPath
    }
    
    //MARK: - Action
    @objc func aSwitchAction (_ sender: NMSwitch) {
        if let indexPath = sender.indexPath {
            aSwitchValueChanged(indexPath, sender: sender)
        }
    }
    
    func aSwitchValueChanged(_ indexPath: IndexPath, sender: NMSwitch) {
        if daysOfTheWeekSelected.contains(indexPath.section) {
            sender.setOn(false, animated:true)
            let index = daysOfTheWeekSelected.index(of: indexPath.section)
            daysOfTheWeekSelected.remove(at: index!)
        } else {
            sender.setOn(true, animated:true)
            daysOfTheWeekSelected.append(indexPath.section)
        }
        
        if lastSwitchActive != nil && indexPath.section != lastSwitchActive {
            if secondBodyLineThatIsShown.contains(lastSwitchActive) {
                secondBodyLineThatIsShown.append(indexPath.section)
            }
            populateNextTextFields(indexPath.section, lastSection: lastSwitchActive)
        }
        
        if daysOfTheWeekSelected.contains(indexPath.section) {
            lastSwitchActive = indexPath.section
        }
        
        if !addTimeBool.contains(indexPath.section) {
            addTimeBool.append(indexPath.section)
        }
        
        let section = IndexSet(integer: indexPath.section)
        self.tableView.beginUpdates()
        self.tableView.reloadSections(section, with: .automatic)
        self.tableView.endUpdates()
    }
    
    func populateNextTextFields(_ actualSection:Int, lastSection: Int) {
        let workingHours = hoursLabels[lastSection]
        hoursLabels[actualSection] = workingHours
    }
    
    @objc func callDatePicker (_ gesture: NMTapGestureRecognizer) {
        let section = gesture.indexPath.section
        let hours = hoursLabels[section]
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "HH:mm"
        
        let datePickerController = NMTimeSettingTableViewDatePicker(delegate: self, gesture: gesture, dateFormatter: dateFormatter)
        datePickerController.datePicker.datePickerMode = UIDatePickerMode.time
        datePickerController.datePicker.minuteInterval = 5
        datePickerController.datePicker.locale = Locale(identifier: "pt_BR")
        datePickerController.titleLabel.text = self.datePickerTitleString
        datePickerController.cancelButton.setTitle(self.datePickerCancelString, for: .normal)
        datePickerController.selectButton.setTitle(self.datePickerSelectString, for: .normal)
        
        if let tag = gesture.tag {
            let label = hours[tag]
            if dateFormatter.date(from: label) != nil {
                datePickerController.datePicker.date = dateFormatter.date(from: label)!
            }
        }
    }
    
    func datePickerCancelButtonAction() {
        print("Date selection was canceled")
    }
    
    func datePickerSelectButtonAction(dateSelected: Date, gesture: NMTapGestureRecognizer, dateFormatter: DateFormatter) {
        if let body = tableView.cellForRow(at: gesture.indexPath) as? NMTimeCell {
            let section = gesture.indexPath.section
            if let tag = gesture.tag {
                if tag == 0 || tag == 2 {
                    body.time1Label.text = dateFormatter.string(from: dateSelected)
                } else {
                    body.time2Label.text = dateFormatter.string(from: dateSelected)
                }
                self.hoursLabels[section][tag] = dateFormatter.string(from: dateSelected)
            }
        }
    }
    
    @objc func showHideCellLine (_ sender: NMButton) {
        if let indexPath = sender.indexPath {
            if secondBodyLineThatIsShown.contains(indexPath.section) {
                let index = secondBodyLineThatIsShown.index(of: indexPath.section)
                secondBodyLineThatIsShown.remove(at: index!)
                hoursLabels[indexPath.section][2] = ""
                hoursLabels[indexPath.section][3] = ""
            } else {
                secondBodyLineThatIsShown.append(indexPath.section)
                let section = sender.indexPath.section
                populateNextLine(section)
            }
            
            let section = IndexSet(integer: indexPath.section)
            self.tableView.beginUpdates()
            self.tableView.reloadSections(section, with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    func populateNextLine(_ section: Int) {
        var hours = hoursLabels[section]
        let lastTime = hours[1]
        let range = Range(lastTime.index(lastTime.startIndex, offsetBy: 2) ..< lastTime.endIndex)
        let lastTimeSubstringEnd = String(lastTime[range])
        
        let start = lastTime.index(lastTime.startIndex, offsetBy: 2)
        let lastTimeSubstringStart = String(lastTime[..<start])
        
        let lastTimeInt = Int(lastTimeSubstringStart)
        
        hours[2] = String(format: "%02d", (lastTimeInt! + 1) % 24) + lastTimeSubstringEnd
        hours[3] = String(format: "%02d", (lastTimeInt! + 2) % 24) + lastTimeSubstringEnd
        
        hoursLabels[section][2] = hours[2]
        hoursLabels[section][3] = hours[3]
    }
    
    @objc func saveBarButtonAction(_ sender: UIBarButtonItem) {
        saveTimeTable()
    }
    
    func saveTimeTable() {
        for index in 0 ..< hoursLabels.count {
            if !daysOfTheWeekSelected.contains(index) {
                hoursLabels[index] = []
            }
        }
        
        print("Time Setting Data: \(hoursLabels)")
        self.timeSettingDelegate?.timeSettingTableViewControllerData(timeArray: hoursLabels)
        self.navigationController?.popViewController(animated: true)
    }
}

extension NMTimeSettingTableViewController: UITableViewDataSource {
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if daysOfTheWeekSelected.contains(section) && secondBodyLineThatIsShown.contains(section) {
            return 3
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if indexPath.row == 0 {
            let header = tableView.dequeueReusableCell(withIdentifier: daysOfTheWeekCelIdentifier, for: indexPath) as! NMDaysOfTheWeekCell
            let dayOfTheWeek = daysOfTheWeek[indexPath.section]
            header.dayOfTheWeekLabel.text = dayOfTheWeek
            header.aSwitch.addTarget(self, action: #selector(aSwitchAction(_:)) , for: UIControlEvents.valueChanged)
            header.aSwitch.indexPath = indexPath
            if daysOfTheWeekSelected.contains(indexPath.section) {
                header.aSwitch.isOn = true
            } else {
                header.aSwitch.isOn = false
            }
            cell = header
            
        } else {
            if !daysOfTheWeekSelected.contains(indexPath.section) {
                let addTime = tableView.dequeueReusableCell(withIdentifier: addTimeCellIdentifier, for: indexPath) as! NMAddTimeCell
                addTime.addTimeLabel.text = "✚ \(addTimeString.uppercased())"
                if addTimeBool.contains(indexPath.section) {
                    addTime.addTimeLabel.text = closedString.capitalized
                    addTime.addTimeLabel.font = UIFont.systemFont(ofSize: 14.0)
                    addTime.addTimeLabel.textColor = UIColor.darkGray
                }
                cell = addTime                
                
            } else {
                let body = tableView.dequeueReusableCell(withIdentifier: timeCellIdentifier, for: indexPath) as! NMTimeCell
                body.fromLabel.text = fromString.uppercased()
                body.toLabel.text = toString.uppercased()
                let hours = hoursLabels[indexPath.section]
                if indexPath.row == 1 {
                    body.time1Label.addGestureRecognizer(timeCellGesture(atIndexPath: indexPath, withTag: 0))
                    body.time1Label.text = hours[0]
                    
                    body.time2Label.addGestureRecognizer(timeCellGesture(atIndexPath: indexPath, withTag: 1))
                    body.time2Label.text = hours[1]
                    
                    if !secondBodyLineThatIsShown.contains(indexPath.section) {
                        setSecondBodyLineCell(body, atIndexPath: indexPath, withTitle: "✚", andTitleFont: UIFont.systemFont(ofSize: 17.0))
                    } else {
                        body.plusButton.isHidden = true
                        body.plusButton.setTitle("", for: UIControlState())
                    }
                    
                } else if secondBodyLineThatIsShown.contains(indexPath.section) && indexPath.row == 2 {
                    body.time1Label.addGestureRecognizer(timeCellGesture(atIndexPath: indexPath, withTag: 2))
                    body.time1Label.text = hours[2]
                    
                    body.time2Label.addGestureRecognizer(timeCellGesture(atIndexPath: indexPath, withTag: 3))
                    body.time2Label.text = hours[3]
                    
                    setSecondBodyLineCell(body, atIndexPath: indexPath, withTitle: "×", andTitleFont: UIFont.systemFont(ofSize: 30.0))
                }
                cell = body
            }
        }
        return cell
    }
    
    // MARK: -
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 6))
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10))
        view.backgroundColor = UIColor.clear
        return view
    }   
}

extension NMTimeSettingTableViewController: UITableViewDelegate {
    //MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !daysOfTheWeekSelected.contains(indexPath.section) {
            if indexPath.row == 1 {
                let headerIndexPath = IndexPath(row: 0, section: indexPath.section)
                if  let header = tableView.cellForRow(at: headerIndexPath) as? NMDaysOfTheWeekCell {
                    let sender = header.aSwitch
                    aSwitchValueChanged(indexPath, sender: sender)
                }
            }
        }
    }
}
