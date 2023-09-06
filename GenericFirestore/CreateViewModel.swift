//
//  ViewModel.swift
//  Make-Firestore-Awesom-With-Generics-Draft
//
//  Created by Vebjørn Daniloff on 9/5/23.
//

import SwiftUI
import FirebaseFirestore

final class CreateViewModel: ObservableObject {

    @Published var name = ""
    @Published var message = ""
    @Published var toDo = ""

    private let db = Firestore.firestore()

    let itemViewModels: [FormItemViewModel] = [
        .init(type: .user),
        .init(type: .message),
        .init(type: .toDo)
    ]

    @MainActor
    func create(type: InputType) async {

        Task {
            var model: any Codable
            var path: String

            do {
                switch type {
                case .user:
                    model = UserPublic(name: name)
                    path = "users"

                case .toDo:
                    model = ToDo(task: toDo)
                    path = "toDos"

                case .message:
                    model = Message(message: message)
                    path = "messages"
                }
                try await db.create(path: path, model: model)
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - Model
extension CreateViewModel {
    enum InputType: String {
        case user
        case toDo
        case message
    }
}

// MARK: - FormItemViewModel
extension CreateViewModel {
    struct FormItemViewModel {
        var type: InputType

        var title: String {
            switch type {
            case .user:
                return "Type name of the user"
            case .toDo:
                return "Type something you have to do"
            case .message:
                return "Leave a message"
            }
        }

        var btnTitle: String {
            "Create a \(type.rawValue)"
        }
    }
}


