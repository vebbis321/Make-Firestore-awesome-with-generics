//
//  UserService.swift
//  Make-Firestore-Awesom-With-Generics-Draft
//
//  Created by Vebjørn Daniloff on 9/6/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol FirestoreServiceProtocol {
    func create(path: String, model: some Codable) async throws
}


extension Firestore: FirestoreServiceProtocol {
    func create(path: String, model: some Codable) async throws {
        _ = try Firestore.firestore().collection(path).addDocument(from: model)
    }
}

