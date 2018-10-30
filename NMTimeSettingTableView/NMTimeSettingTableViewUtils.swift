//
//  NMTimeSettingTableViewUtils.swift
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

enum TimeFormat: String {
    case american = "hh:mm a"
    case british = "HH:mm"
}

class NMButton: UIButton {
    var indexPath: IndexPath!
}

class NMSwitch: UISwitch {
    var indexPath: IndexPath!    
}

class NMTapGestureRecognizer: UITapGestureRecognizer {
    var indexPath: IndexPath!
    var tag: Int?
}

extension UIColor {    
    public class func systemDefaultColor() -> UIColor {
        return UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
    }
    
    public class func lightGrayCustom() -> UIColor {
        return UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
