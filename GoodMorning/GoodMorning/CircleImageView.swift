//
//  CircleImageView.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/04.
//

import UIKit

class CircleImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = min(frame.width/2, frame.height/2)
        clipsToBounds = true
    }

}
