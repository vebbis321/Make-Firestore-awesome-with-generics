//
//  Models.swift
//  Make-Firestore-Awesom-With-Generics-Draft
//
//  Created by Vebjørn Daniloff on 9/6/23.
//

import Foundation
import FirebaseFirestoreSwift

struct UserPublic: Codable {
    @DocumentID var id: String?
    var name: String
}

struct ToDo: Codable {
    @DocumentID var id: String?
    var task: String
}

struct Message: Codable {
    @DocumentID var id: String?
    var message: String
}
