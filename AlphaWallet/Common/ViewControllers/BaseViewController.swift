//
//  BaseViewController.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    /// The baseView of controller
    let baseView: BaseView
    
    /// The baseViewModel of controller
    let baseViewModel: BaseViewModel
    
    /// when view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        observeEvent()
    }
    
    /// Initializer for a controller
    /// - Parameters:
    ///   - baseView: the view associated with the controller
    ///   - baseViewModel: viewModel associated with the controller
    init(screen: BaseView, viewModel: BaseViewModel) {
        baseView = screen
        baseViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    func observeEvent() {}
    
}
