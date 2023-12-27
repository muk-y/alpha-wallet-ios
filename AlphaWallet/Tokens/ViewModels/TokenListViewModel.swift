//
//  TokenListViewModel.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import Foundation
import Combine

class TokenListViewModel: BaseViewModel {
    
    // MARK: Properties    
    @Published private(set) var models: [WalletToken] = []
    private(set) var isLoading = PassthroughSubject<Bool, Never>()
    private(set) var showError = PassthroughSubject<String, Never>()
    
    // MARK: Other functions
    func getData(withLoading: Bool = true) {
        isLoading.send(true)
        fetchTokenList { [weak self] result in
            self?.isLoading.send(false)
            switch result {
            case .success(let models):
                self?.models = models
            case .failure(let error):
                self?.showError.send(error.localizedDescription)
//                self?.delegate?.show(error)
            }
        }
    }
    
}

// MARK: TokenListApi
extension TokenListViewModel: TokenListApi {
    
}
