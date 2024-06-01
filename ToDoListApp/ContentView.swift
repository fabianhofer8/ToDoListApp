//
//  ContentView.swift
//  ToDoListApp
//
//  Created by Fabian Hofer on 31.05.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel = ViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter new task", text: $viewModel.newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        viewModel.addTask()
                    }) {
                        Text("Add")
                    }
                    .padding(.leading, 8)
                }
                .padding()

                List {
                    ForEach(viewModel.tasks.indices, id: \.self) { index in
                        HStack {
                            Text(viewModel.tasks[index].name)
                            Spacer()
                            Button(action: {
                                viewModel.toggleTaskCompletion(at: index)
                            }) {
                                Image(systemName: viewModel.tasks[index].isCompleted ? "checkmark.square" : "square")
                            }
                        }
                    }
                }
                .navigationBarTitle("ToDo List")
            }
        }
    }
}

class ViewModel: ObservableObject {
    @Published public var newTask: String = ""
    @Published public var tasks: [Task] = []

    public func addTask() {
        guard !newTask.isEmpty else { return }
        tasks.append(Task(name: newTask))
        newTask = ""
    }

    public func toggleTaskCompletion(at index: Int) {
        tasks[index].isCompleted.toggle()
    }
}

struct Task {
    var name: String
    var isCompleted: Bool = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
