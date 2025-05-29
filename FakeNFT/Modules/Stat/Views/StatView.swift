//
//  StatView.swift
//  FakeNFT
//
//  Created by alex_tr on 18.04.2025.
//

import SwiftUI

struct StatView: View {
    @ObservedObject var viewModel: ProfileStatViewModel
    @State private var showActionSheet = false
    @State private var showErrorAlert = false
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                VStack {
                    ProgressView()
                        .scaleEffect(1.5)
                    Text("Подгружаем пользователей...")
                }
            } else if viewModel.allUsersList.isEmpty {
                if #available(iOS 17.0, *) {
                    ContentUnavailableView(
                        "Нет данных",
                        systemImage: "person.3",
                        description: Text("Не удалось загрузить список пользователей.\nВернитесь на главную страницу и попробуйте еще раз."))
                } else {
                    EmptyStatView (
                        title: "Нет данных",
                        imageName: "person.3",
                        description: "Не удалось загрузить список пользователей. \nВернитесь на главную страницу и попробуйте еще раз."
                    )
                }
            } else {
                VStack(alignment: .trailing) {
                    HStack {
                        Button(action: {
                            showActionSheet.toggle()
                        }) {
                            Image(colorScheme == .dark ? .sortingButtonDark : .sortingButtonLight) // Иконка меню
                        }
                        .confirmationDialog("Сортировка", isPresented: $showActionSheet, titleVisibility: .visible) {
                            Button("По имени") {
                                viewModel.sortOrder = .name
                            }
                            Button("По рейтингу") {
                                viewModel.sortOrder = .rating
                            }
                            Button("Закрыть", role: .cancel) {}
                        }
                    }
                    .padding(.vertical, 14.7)
                    List {
                        ForEach(0..<viewModel.allUsersList.count, id: \.self) { index in
                            HStack(spacing: 8) {
                                Text("\(index + 1)")
                                    .font(.system(size: 15, weight: .regular))
                                    .frame(width: 27)
                                StatCellView(user: viewModel.allUsersList[index])
                            }
//                            .task {
//                                if viewModel.allUsersList[index].description == nil {
//                                    print("[DEBUG] user.description", viewModel.allUsersList[index].name, viewModel.allUsersList[index].description ?? "nil")
//                                }
//                                if viewModel.allUsersList[index].website.isEmpty {
//                                    print("[DEBUG] user.website", viewModel.allUsersList[index].name, viewModel.allUsersList[index].website ?? "nil")
//                                }
//                            }
                            .background(
                                NavigationLink(
                                    "",
                                    destination: StatDetailedView(
                                        user: viewModel.allUsersList[index],
                                        statUserViewModel: viewModel))
                            )
                        }
                        .padding(.leading, 16)
                        .padding(.bottom, 8)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    }
                    .listStyle(.plain)
                    .ignoresSafeArea(edges: .bottom)
                    .scrollIndicators(.never)
                }
                .padding(.trailing, 16)
                .alert("Ошибка", isPresented: $showErrorAlert) {
                    Button("Повторить", role: nil) {
                        viewModel.fetchData() // Повторная попытка при нажатии
                    }
                    Button("Отменить", role: .cancel) {
                        // Действие при отмене
                    }
                } message: {
                    Text("Не удалось получить данные")
                }
                Spacer()
            }
        }
        .onAppear(){
            viewModel.fetchData()
        }
    }
}

#Preview("Light Theme") {
    var viewModel = ProfileStatViewModel()
    StatView(viewModel: viewModel)
        .preferredColorScheme(.light)
}

#Preview("Dark Theme") {
    var viewModel = ProfileStatViewModel()
    StatView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}
