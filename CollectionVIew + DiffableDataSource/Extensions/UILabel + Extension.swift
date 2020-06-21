//
//  UILabel + Extension.swift
//  GymChoice
//
//  Created by Антон Скидан on 17.03.2020.
//  Copyright © 2020 Anton Skidan. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenir24()) {
        self.init()
        
        self.text = text
        self.font = font
    }
}


