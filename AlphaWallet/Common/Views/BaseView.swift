//
//  BaseView.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import UIKit.UIView

class BaseView: UIView {
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Other functions
    func prepareLayout() {}
    
    deinit {
        print("deinit \(String(describing: self))")
    }
    
}
