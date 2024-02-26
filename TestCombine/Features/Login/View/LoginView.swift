//
//  LoginView.swift
//  TestCombine
//
//  Created by Fermin Esquisabel Garcia on 26/2/24.
//

import UIKit
import Combine

class LoginView: UIViewController {
    
    private let loginViewModel = LoginViewModel(UserRequests())
    
    var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 25
        
        createBindingViewWithViewModel()
    }
    
    private func createBindingViewWithViewModel() {    
        usernameTextField.textPublisher
            .assign(to: \LoginViewModel.username, on: loginViewModel)
        .store(in: &cancellables)
        
        passwordTextField.textPublisher
            .assign(to: \LoginViewModel.password, on: loginViewModel)
        .store(in: &cancellables)
        
        loginViewModel.$isEnabled.sink { [weak self] isEnabled in
            self?.loginButton.isEnabled = isEnabled
            if (isEnabled) {
                self?.loginButton.backgroundColor = .systemBlue
            } else {
                self?.loginButton.backgroundColor = .lightGray
            }
        }.store(in: &cancellables)
        
        loginViewModel.$userModel.sink { [weak self] user in
            if let user {
                self?.performSegue(withIdentifier: "loginSegue", sender: user)
            }
        }.store(in: &cancellables)
        
        loginViewModel.$showLoading.sink { [weak self] showLoading in
            if (showLoading) {
                self?.showProgress(onView: self?.view)
            } else {
                self?.hideProgress()
            }
        }.store(in: &cancellables)
        
        loginViewModel.$errorMessage.sink { [weak self] errorMessage in
            if !errorMessage.isEmpty {
                self?.showAlert(title: "Error", message: errorMessage)
            }
        }.store(in: &cancellables)
    }
    
    @IBAction func doLogin(_ sender: Any) {
        loginViewModel.userLogin(username: usernameTextField.text?.lowercased() ?? "", password: passwordTextField.text?.lowercased() ?? "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? HomeView {
            if let user = sender as? User {
                destinationVC.homeViewModel = HomeViewModel(user)
            }
        }
    }
    
}
