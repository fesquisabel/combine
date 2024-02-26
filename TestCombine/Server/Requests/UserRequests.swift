//
//  UserRequests.swift
//  TestCombine
//
//  Created by Fermin Esquisabel Garcia on 26/2/24.
//

import Foundation
import Combine

class UserRequests {
    
    var cancellables = Set<AnyCancellable>()

    func login(username: String, password: String) -> AnyPublisher<User?, Error> {
        return NetworkManager.shared.get(method: "login?usuario=\(username)&password=\(password)").eraseToAnyPublisher()
    }
    
}
