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

    private let userService: UserServiceProtocol
    private let toDoService: ToDoServiceProtocol
    private let messageService: MessageServiceProtocol

    init(
        userService: UserServiceProtocol,
        toDoService: ToDoServiceProtocol,
        messageService: MessageServiceProtocol
    ) {
        self.userService = userService
        self.toDoService = toDoService
        self.messageService = messageService
    }

    let itemViewModels: [FormItemViewModel] = [
        .init(type: .user),
        .init(type: .message),
        .init(type: .toDo)
    ]

    @MainActor
    func create(type: InputType) async {
        Task {
            do {
                switch type {
                case .user:
                    try await userService.create(user: .init(name: name))
                case .toDo:
                    try await toDoService.create(toDo: .init(task: toDo))
                case .message:
                    try await messageService.create(message: .init(message: message))
                }

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


