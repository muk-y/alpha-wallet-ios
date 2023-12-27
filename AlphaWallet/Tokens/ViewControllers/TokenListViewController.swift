//
//  TokenListViewController.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import UIKit

class TokenListViewController: BaseViewController {
    
    var screenView: TokenListView {
        baseView as! TokenListView
    }
    
    var viewModel: TokenListViewModel {
        baseViewModel as!  TokenListViewModel
    }
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        viewModel.getData()
    }
    
    // MARK: Other functions
    override func observeEvent() {
        viewModel.$models.receive(on: RunLoop.main).sink { [weak self] _ in
            self?.screenView.tableView.reloadData()
        }.store(in: &viewModel.disposeBag)
        viewModel.isLoading.receive(on: RunLoop.main).sink { [weak self] value in
            if value {
                self?.displayLoading()
                return
            }
            self?.hideLoading()
        }.store(in: &viewModel.disposeBag)
        viewModel.showError.receive(on: RunLoop.main).sink { [weak self] value in
            self?.displayError(message: value)
        }.store(in: &viewModel.disposeBag)
    }
    
    private func setupNavBar() {
        navigationItem.title = "Tokens"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.closeBarButton(self, selector: #selector(closeDidSelect))
    }
    
    private func setupTableView() {
        screenView.tableView.dataSource = self
    }
    
    @objc private func closeDidSelect() {
        dismiss(animated: true)
    }
  
}

// MARK: UITableViewDataSource
extension TokenListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TokenTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(viewModel.models[indexPath.row])
        return cell
    }
    
}
