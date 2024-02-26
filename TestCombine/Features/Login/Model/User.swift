//
//  User.swift
//  TestCombine
//
//  Created by Fermin Esquisabel Garcia on 26/2/24.
//

import Foundation

struct User: Codable {
    let message: String
    let success: UserInfo?
}

struct UserInfo: Codable {
    let idUsuario: Int
    let usuario: String
    let nombre: String
    let apellidos: String
}
