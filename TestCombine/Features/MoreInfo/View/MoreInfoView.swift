//
//  MoreInfoView.swift
//  TestCombine
//
//  Created by Fermin Esquisabel Garcia on 26/2/24.
//

import UIKit
import Combine

class MoreInfoView: UIViewController {
    
    var moreInfoViewModel: MoreInfoViewModel? = nil
    
    var cancellables = Set<AnyCancellable>()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBindingViewWithViewModel()
    }
    
    private func createBindingViewWithViewModel() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = false
    }
    
}
