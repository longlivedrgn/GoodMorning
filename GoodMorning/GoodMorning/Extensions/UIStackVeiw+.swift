//
//  UIStackVeiw+.swift
//  GoodMorning
//
//  Created by Sunny on 2023/08/10.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
    
}
