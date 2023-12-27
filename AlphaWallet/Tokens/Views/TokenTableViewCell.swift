//
//  TokenTableViewCell.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import UIKit

class TokenTableViewCell: UITableViewCell {
    
    // MARK: UI Properties
    private let background = UIView()
    private let titleLabel = UILabel()
    private let chainIDLabel = UILabel()

    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareLayout()
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    // MARK: Other functions
    private func prepareLayout() {
        contentView.addSubview(background)
        background.fillSuperView()
        
        let stackView = [
            titleLabel, chainIDLabel
        ].asStackView(axis: .vertical, spacing: 12)
        background.addSubview(stackView)
        
        stackView.fillSuperView(inset: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    private func setup() {
        selectionStyle = .none

        backgroundColor = Configuration.Color.Semantic.tableViewCellBackground
        background.backgroundColor = Configuration.Color.Semantic.tableViewCellBackground
        contentView.backgroundColor = Configuration.Color.Semantic.tableViewCellBackground
        
        titleLabel.baselineAdjustment = .alignCenters
        titleLabel.numberOfLines = .zero
    }

    func configure(_ model: WalletToken) {
        titleLabel.text = model.name
        chainIDLabel.text = "Chain ID: \(model.id ?? .zero)"
        chainIDLabel.isHidden = model.id == nil
    }
    
}
