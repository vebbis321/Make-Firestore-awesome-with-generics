//
//  Services.swift
//  Make-Firestore-Awesom-With-Generics-Draft
//
//  Created by Vebjørn Daniloff on 9/5/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ToDoServiceProtocol {
    func create(toDo: ToDo) async throws
}


final class ToDoService: ToDoServiceProtocol {
    func create(toDo: ToDo) async throws {
        _ = try Firestore.firestore().collection("toDos").addDocument(from: toDo)
    }
}
