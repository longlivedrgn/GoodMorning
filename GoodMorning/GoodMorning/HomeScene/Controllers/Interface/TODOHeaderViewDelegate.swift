//
//  TODOHeaderViewDelegate.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/06.
//

import UIKit

protocol TODOHeaderViewDelegate: AnyObject {

    func TODOHeaderView(_ TODOHeaderView: TODOHeaderView, didEditButtonTapped sender: UIButton)
    func TODOHeaderView(_ TODOHeaderView: TODOHeaderView, didPlusButtonTapped sender: UIButton)

}
