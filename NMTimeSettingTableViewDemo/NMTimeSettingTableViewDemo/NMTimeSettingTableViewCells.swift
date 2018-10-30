//
//  NMTimeSettingTableViewCells.swift
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

final class NMDaysOfTheWeekCell: UITableViewCell {
    
    let dayOfTheWeekLabel: UILabel = UILabel()
    let aSwitch: NMSwitch = NMSwitch()
 
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dayOfTheWeekLabel.font = UIFont.systemFont(ofSize: 13.0)
        
        self.backgroundColor = UIColor.lightGrayCustom()
        self.selectionStyle = .none
        
        dayOfTheWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        aSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(dayOfTheWeekLabel)
        contentView.addSubview(aSwitch)
        
        let views: [String: Any] = [
            "dayOfTheWeekLabel": dayOfTheWeekLabel,
            "aSwitch": aSwitch
        ]
        
        dayOfTheWeekLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        aSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        var allConstraints = [NSLayoutConstraint]()
        
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-16-[dayOfTheWeekLabel]-16-[aSwitch]-16-|",
            options: [.alignAllCenterY],
            metrics: nil,
            views: views)
        
        allConstraints += horizontalConstraints

        NSLayoutConstraint.activate(allConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


final class NMAddTimeCell: UITableViewCell {
    
    let addTimeLabel: UILabel = UILabel()
    let columnDividerRight: UILabel = UILabel()
    let columnDividerLeft: UILabel = UILabel()
    let lineDividerBottom : UILabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        
        addTimeLabel.font = UIFont.systemFont(ofSize: 12.0)
        addTimeLabel.textColor = UIColor.systemDefaultColor()
        
        columnDividerRight.backgroundColor = UIColor.lightGrayCustom()
        columnDividerLeft.backgroundColor = UIColor.lightGrayCustom()
        lineDividerBottom.backgroundColor = UIColor.lightGrayCustom()
        
        addTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        columnDividerRight.translatesAutoresizingMaskIntoConstraints = false
        columnDividerLeft.translatesAutoresizingMaskIntoConstraints = false
        lineDividerBottom.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(columnDividerLeft)
        contentView.addSubview(columnDividerRight)
        contentView.addSubview(addTimeLabel)
        contentView.addSubview(lineDividerBottom)
        
        let views: [String: Any] = [
            "addTimeLabel": addTimeLabel,
            "columnDividerRight": columnDividerRight,
            "columnDividerLeft": columnDividerLeft,
            "lineDividerBottom": lineDividerBottom
        ]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let addTimeLabelHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[columnDividerLeft(2)]-16-[addTimeLabel]-16-[columnDividerRight(2)]|",
            options: [.alignAllCenterY],
            metrics: nil,
            views: views)
        
        allConstraints += addTimeLabelHorizontalConstraint
        
        let columnDividerLeftVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[columnDividerLeft]|",
            options: [],
            metrics: nil,
            views: views)
        
         allConstraints += columnDividerLeftVerticalConstraint
        
        let columnDividerRightVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[columnDividerRight]|",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += columnDividerRightVerticalConstraint
        
        let lineDividerHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[lineDividerBottom]|",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += lineDividerHorizontalConstraint
        
        let lineDividerVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[lineDividerBottom(2)]|",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += lineDividerVerticalConstraint

        NSLayoutConstraint.activate(allConstraints)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


final class NMTimeCell: UITableViewCell {
    
    let fromLabel = UILabel()
    let toLabel = UILabel()
    let time1Label = UILabel()
    let time2Label = UILabel()
    let plusButton = NMButton()
    let columnDividerLeft: UILabel = UILabel()
    let columnDividerCenter: UILabel = UILabel()
    let columnDividerRight: UILabel = UILabel()
    let lineDividerBottom: UILabel = UILabel()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        time1Label.isUserInteractionEnabled = true
        time2Label.isUserInteractionEnabled = true
        
        fromLabel.textColor = UIColor.darkGray
        toLabel.textColor = UIColor.darkGray
        
        fromLabel.font = UIFont.systemFont(ofSize: 12.0)
        toLabel.font = UIFont.systemFont(ofSize: 12.0)
        time1Label.font = UIFont.systemFont(ofSize: 14.0)
        time2Label.font = UIFont.systemFont(ofSize: 14.0)
        
        plusButton.setTitleColor(UIColor.systemDefaultColor(), for: .normal)
        plusButton.setTitle("✚", for: UIControlState())
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        
        columnDividerLeft.backgroundColor = UIColor.lightGrayCustom()
        columnDividerCenter.backgroundColor = UIColor.lightGrayCustom()
        columnDividerRight.backgroundColor = UIColor.lightGrayCustom()
        lineDividerBottom.backgroundColor = UIColor.lightGrayCustom()
       
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        time1Label.translatesAutoresizingMaskIntoConstraints = false
        time2Label.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        columnDividerLeft.translatesAutoresizingMaskIntoConstraints = false
        columnDividerCenter.translatesAutoresizingMaskIntoConstraints = false
        columnDividerRight.translatesAutoresizingMaskIntoConstraints = false
        lineDividerBottom.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(fromLabel)
        contentView.addSubview(toLabel)
        contentView.addSubview(time1Label)
        contentView.addSubview(time2Label)
        contentView.addSubview(plusButton)
        contentView.addSubview(columnDividerLeft)
        contentView.addSubview(columnDividerCenter)
        contentView.addSubview(columnDividerRight)
        contentView.addSubview(lineDividerBottom)
        
        
        let views: [String: Any] = [
            "fromLabel": fromLabel,
            "toLabel": toLabel,
            "time1Label": time1Label,
            "time2Label": time2Label,
            "plusButton": plusButton,
            "columnDividerLeft": columnDividerLeft,
            "columnDividerCenter": columnDividerCenter,
            "columnDividerRight": columnDividerRight,
            "lineDividerBottom": lineDividerBottom
        ]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let columnDividerLeftHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[columnDividerLeft(2)]-16-[fromLabel]",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += columnDividerLeftHorizontalConstraint
        
        let columnDividerLeftVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[columnDividerLeft]|",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += columnDividerLeftVerticalConstraint
        
        let fromVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[fromLabel][time1Label]",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += fromVerticalConstraint
        
        let time1LabelHoritontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[columnDividerLeft]-16-[time1Label(100)]-4-[columnDividerCenter]",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += time1LabelHoritontalConstraint
        
        let time1LabelVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[time1Label(25)][lineDividerBottom]",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += time1LabelVerticalConstraint
        
        let columnDividerCenterHoritontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[columnDividerCenter(2)]-16-[time2Label]",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += columnDividerCenterHoritontalConstraint
        
        let columnDividerCenterVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[columnDividerCenter]-1-[lineDividerBottom]",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += columnDividerCenterVerticalConstraint
        
        let toHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[columnDividerCenter]-16-[toLabel]",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += toHorizontalConstraint
        
        let toVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[toLabel][time2Label]",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += toVerticalConstraint

        let time2LabelHoritontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[columnDividerCenter]-16-[time2Label(100)]",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += time2LabelHoritontalConstraint
        
        let time2LabelVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[time2Label(25)][lineDividerBottom]",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += time2LabelVerticalConstraint
        
        let plusButtonHoritontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:[plusButton(44)]-6-[columnDividerRight(2)]|",
            options: [.alignAllCenterY],
            metrics: nil,
            views: views)
        
        allConstraints += plusButtonHoritontalConstraint
        
        let plusButtonVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[plusButton(33)]",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += plusButtonVerticalConstraint

        
        let columnDividerRightVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[columnDividerRight]|",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += columnDividerRightVerticalConstraint
        
        let lineDividerHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[lineDividerBottom]|",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += lineDividerHorizontalConstraint
        
        let lineDividerVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[lineDividerBottom(2)]|",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += lineDividerVerticalConstraint
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
