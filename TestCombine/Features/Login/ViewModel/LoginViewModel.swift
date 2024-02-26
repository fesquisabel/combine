//
//  LoginViewModel.swift
//  TestCombine
//
//  Created by Fermin Esquisabel Garcia on 26/2/24.
//

import Foundation
import Combine

class LoginViewModel {
    
    @Published var username = ""
    @Published var password = ""
    @Published var isEnabled = false
    @Published var showLoading = false
    @Published var errorMessage: String = ""
    @Published var userModel: User?

    var cancellables = Set<AnyCancellable>()
    
    let userRequests: UserRequests
    
    init(_ userRequests: UserRequests) {
        self.userRequests = userRequests
        
        formValidation()
    }

    func formValidation() {
        Publishers.CombineLatest($username, $password)
            .sink { username, password in
                self.isEnabled = username.count >= 5 && password.count >= 5
        }.store(in: &cancellables)
    }
    
    @MainActor
    func userLogin(username: String, password: String) {
        errorMessage = ""
        showLoading = true
        
        userRequests.login(username: username, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.showLoading = false
                
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] user in
                if let user {
                    self?.userModel = user
                }
            })
            .store(in: &cancellables)
    }
    
}
