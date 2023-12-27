//
//  TokenListView.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import UIKit
import AlphaWalletFoundation

class TokenListView: BaseView {
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView.buildGroupedTableView()
        tableView.register(TokenTableViewCell.self)
        tableView.estimatedRowHeight = DataEntry.Metric.TableView.estimatedRowHeight
        return tableView
    }()
    
    override func prepareLayout() {
        super.prepareLayout()
        addSubview(tableView)
        tableView.fillSuperView()
    }
    
}
