//
//  ContentView.swift
//  Make-Firestore-Awesom-With-Generics-Draft
//
//  Created by Vebjørn Daniloff on 9/5/23.
//

import SwiftUI

struct CreateView: View {

    @StateObject var viewModel = CreateViewModel(
        userService: UserService(),
        toDoService: ToDoService(),
        messageService: MessageService()
    )

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack(spacing: 15) {
                Text("Create")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()

                ForEach(viewModel.itemViewModels, id: \.type) { itemViewModel in
                    createInputBtnForm(itemViewModel: itemViewModel) {
                        Task {
                            await viewModel.create(type: itemViewModel.type)
                        }
                    }
                }
                Spacer()
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}

extension CreateView {
    @ViewBuilder
    func createInputBtnForm(
        itemViewModel: CreateViewModel.FormItemViewModel,
        action: @escaping ()->()
    ) -> some View {
        VStack(alignment: .center, spacing: 15) {
            TextField(
                itemViewModel.title,
                text: getStringBinding(type: itemViewModel.type)
            )
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal)
            .padding(.top)


            Button(action: action) {
                HStack {
                    Spacer()
                    Text(itemViewModel.btnTitle)
                    Spacer()
                }
                .padding(4)
            }
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(5)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color.white)
        .cornerRadius(10)
    }
}

extension CreateView {
    func getStringBinding(type: CreateViewModel.InputType) -> Binding<String> {
        switch type {
        case .user:
            return $viewModel.name
        case .toDo:
            return $viewModel.toDo
        case .message:
            return $viewModel.message
        }
    }
}
