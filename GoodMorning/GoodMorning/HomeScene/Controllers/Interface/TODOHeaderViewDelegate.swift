//
//  TODOHeaderViewDelegate.swift
//  GoodMorning
//
//  Created by Miro on 2023/08/06.
//

import UIKit

protocol ToDoHeaderViewDelegate: AnyObject {

    func ToDoHeaderView(_ TODOHeaderView: ToDoHeaderView, didEditButtonTapped sender: UIButton)
    func ToDoHeaderView(_ TODOHeaderView: ToDoHeaderView, didPlusButtonTapped sender: UIButton)

}
