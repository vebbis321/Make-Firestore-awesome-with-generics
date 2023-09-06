//
//  UserService.swift
//  Make-Firestore-Awesom-With-Generics-Draft
//
//  Created by Vebjørn Daniloff on 9/6/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol UserServiceProtocol {
    func create(user: UserPublic) async throws
}


final class UserService: UserServiceProtocol {
    func create(user: UserPublic) async throws {
        _ = try Firestore.firestore().collection("users").addDocument(from: user)
    }
}

