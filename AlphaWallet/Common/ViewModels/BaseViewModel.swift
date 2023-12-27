//
//  BaseViewModel.swift
//  AlphaWallet
//
//  Created by Mukesh Shakya on 26/12/2023.
//

import Foundation
import Combine

class BaseViewModel {
    
    let trigger = PassthroughSubject<AppRoutable, Never>()
    var disposeBag = Set<AnyCancellable>()
    
    init() {
        
    }
    
    deinit {
        disposeBag.forEach({
            $0.cancel()
        })
        debugPrint("De-Initialized --> \(String(describing: self))")
    }

}
