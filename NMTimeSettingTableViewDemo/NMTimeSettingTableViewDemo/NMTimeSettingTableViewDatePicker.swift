//
//  NMTimeSettingTableViewDatePicker.swift
//  NMTimeSettingTableViewDemo
//
//  Created by Natalia Macambira on 21/05/17.
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

protocol NMTimeSettingTableViewDatePickerDelegate {
    func datePickerSelectButtonAction(dateSelected: Date, gesture: NMTapGestureRecognizer, dateFormatter: DateFormatter)
    func datePickerCancelButtonAction()
}

class NMTimeSettingTableViewDatePicker: UIView {
    
    var delegate: NMTimeSettingTableViewDatePickerDelegate?
    var gesture: NMTapGestureRecognizer!
    var dateFormatter: DateFormatter!
    var titleLabel: UILabel = UILabel()
    var datePicker: UIDatePicker!
    var cancelButton: UIButton = UIButton(type: .system)
    var selectButton: UIButton = UIButton(type: .system)    
    private var backgroundView: UIView!
    private var contentView = UIView()
    
    init(delegate:NMTimeSettingTableViewDatePickerDelegate?, gesture: NMTapGestureRecognizer, dateFormatter: DateFormatter) {
        super.init(frame: CGRect.zero)
        
        self.delegate = delegate
        self.gesture = gesture
        self.dateFormatter = dateFormatter
        self.datePicker = UIDatePicker()
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.titleLabel.roundCorners(corners: [.topRight,.topLeft], radius: 4)
            self.titleLabel.layer.masksToBounds = true
            
            self.cancelButton.roundCorners(corners: [.bottomLeft], radius: 4)
            self.cancelButton.layer.masksToBounds = true
            
            self.selectButton.roundCorners(corners: [.bottomRight], radius: 4)
            self.selectButton.layer.masksToBounds = true
        }
        self.layoutIfNeeded()
    }
    
    private func setupView() {        
        let keyWindow = UIApplication.shared.keyWindow
        let keyWindowBounds: CGRect = (keyWindow?.bounds)!
        self.frame = keyWindowBounds
        keyWindow?.addSubview(self)
        
        backgroundView = UIView(frame: keyWindowBounds)
        backgroundView.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        backgroundView.alpha = 0
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(NMTimeSettingTableViewDatePicker.dismiss))
        backgroundView.addGestureRecognizer(tapRecognizer)
        addSubview(backgroundView)
        
        contentViewConfig()
        addSubview(contentView)
        
        show()
    }
    
    private func contentViewConfig() {
        /* ContentView */
        contentView.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 320)
        contentView.addSubview(titleLabel)
        contentView.addSubview(datePicker)
        contentView.addSubview(cancelButton)
        contentView.addSubview(selectButton)
        
        /* Title */
        titleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight(rawValue: 0.2))
        titleLabel.text = "Please choose the time and press 'Select' or 'Cancel'"
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.gray
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor.white
        
        /* DatePicker */
        datePicker.backgroundColor = UIColor.white
        
        /* Cancel button */
        cancelButton.setTitle("Cancel",for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight(rawValue: 0.3))
        cancelButton.backgroundColor = UIColor.white
        cancelButton.addTarget(self, action: #selector(NMTimeSettingTableViewDatePicker.cancelButtonPressed(_:)), for: .touchUpInside)
        
        /* Selection button */
        selectButton.setTitle("Select",for: .normal)
        selectButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        selectButton.backgroundColor = UIColor.white
        selectButton.addTarget(self, action: #selector(NMTimeSettingTableViewDatePicker.selectButtonPressed(_:)), for: .touchUpInside)
        
        /* Constraints */
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: Any] = [
            "titleLabel": titleLabel,
            "datePicker": datePicker,
            "cancelButton": cancelButton,
            "selectButton": selectButton
        ]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[titleLabel(50)]-1-[datePicker(200)]-1-[cancelButton(50)]-16-|",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += verticalConstraints
        
        let titleLabelHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-16-[titleLabel]-16-|",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += titleLabelHorizontalConstraint
        
        let datePickerHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-16-[datePicker]-16-|",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += datePickerHorizontalConstraint
        
        let buttonsHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-16-[cancelButton(==selectButton)]-1-[selectButton]-16-|",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += buttonsHorizontalConstraint
        
        let selectebuttonVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[datePicker]-1-[selectButton(50)]",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += selectebuttonVerticalConstraint
        
        NSLayoutConstraint.activate(allConstraints)
    }

    @objc func cancelButtonPressed(_ sender: UIButton) {
        dismiss()
        delegate?.datePickerCancelButtonAction()
    }
    
    @objc func selectButtonPressed(_ sender: UIButton) {
        dismiss()
        let date = self.datePicker.date
        delegate?.datePickerSelectButtonAction(dateSelected: date, gesture: self.gesture, dateFormatter: self.dateFormatter)
    }
    
    func show() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .beginFromCurrentState, animations: { () -> Void in
            self.contentView.frame = CGRect(x: 0, y: self.frame.height - self.contentView.frame.height, width: self.frame.width, height: self.contentView.frame.height)
            self.backgroundView.alpha = 1.0
        })
    }
    
    @objc func dismiss() {
        UIView.animate(withDuration: 0.6, delay: 0, options: .beginFromCurrentState, animations: { () -> Void in
            self.contentView.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: self.contentView.frame.height)
            self.backgroundView.alpha = 0
        }) { (Bool) -> Void in
            self.removeFromSuperview()
        }
    }
}
