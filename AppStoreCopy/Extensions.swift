//
//  Extensions.swift
//  AppStoreCopy
//
//  Created by Vadim on 28.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit

extension UIView {
    
    func constraintsWithVisualFormatApp(format: String, views: UIView...) {
        
        var viewDictionary = [String: AnyObject]()
        
        for (index, view) in views.enumerate() {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
}
