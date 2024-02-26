//
//  MoreInfoViewModel.swift
//  TestCombine
//
//  Created by Fermin Esquisabel Garcia on 26/2/24.
//

import Foundation
import Combine

class MoreInfoViewModel {
    
    @Published var userModel: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(_ user: User) {
        self.userModel = user
    }
}
