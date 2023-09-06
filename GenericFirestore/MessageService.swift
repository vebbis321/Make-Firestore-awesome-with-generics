//
//  MessageService.swift
//  Make-Firestore-Awesom-With-Generics-Draft
//
//  Created by Vebjørn Daniloff on 9/6/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// MARK: - Message
protocol MessageServiceProtocol {
    func create(message: Message) async throws
}

final class MessageService: MessageServiceProtocol {
    func create(message: Message) async throws {
        _ = try Firestore.firestore().collection("messages").addDocument(from: message)
    }
}
