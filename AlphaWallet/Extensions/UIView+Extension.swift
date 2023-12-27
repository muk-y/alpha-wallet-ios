//
//  UIView+Extension.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import UIKit.UIView

extension UIView {
    
    func fillSuperView(inset: UIEdgeInsets = .zero) {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: inset.left).isActive = true
        topAnchor.constraint(equalTo: superView.topAnchor, constant: inset.top).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -inset.right).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -inset.bottom).isActive = true
    }
    
}
