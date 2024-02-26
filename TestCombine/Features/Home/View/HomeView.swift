//
//  HomeView.swift
//  TestCombine
//
//  Created by Fermin Esquisabel Garcia on 26/2/24.
//

import UIKit
import Combine

class HomeView: UIViewController {
    
    var homeViewModel: HomeViewModel? = nil
    
    var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var moreInfoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBindingViewWithViewModel()
    }
    
    private func createBindingViewWithViewModel() {
        homeViewModel?.$userModel.sink { [weak self] user in
            if let user {
                self?.welcomeLabel.text = "Hola \(user.success?.usuario ?? "Unknown")"
            }
        }.store(in: &cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func seeMoreInfo(_ sender: Any) {
        performSegue(withIdentifier: "moreInfoSegue", sender: self)
    }
    
}
