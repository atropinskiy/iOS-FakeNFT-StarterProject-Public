//
//  StatView.swift
//  FakeNFT
//
//  Created by alex_tr on 18.04.2025.
//

import SwiftUI

struct StatView: View {
    @StateObject private var viewModel = ProfileStatViewModel()
    @StateObject private var detailedViewModel = ProfileStatDetailViewModel()
    @State private var showActionSheet = false
    @State private var showErrorAlert = false
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
//        NavigationStack(path: $viewModel.path) {
        NavigationStack {
            VStack(alignment: .trailing) {
                HStack {
                    Button(action: {
                        showActionSheet.toggle()
                    }) {
                        Image(colorScheme == .dark ? .sortingButtonDark : .sortingButtonLight) // Иконка меню
                    }
                    .confirmationDialog("Сортировка", isPresented: $showActionSheet, titleVisibility: .visible) {
                        Button("По имени") { print("Option 1 - Сортировка по имени") }
                        Button("По рейтингу") { print("Option 2 - Сортировка по рейтингу") }
                        Button("Закрыть", role: .cancel) {}
                    }
                }
                .padding(.vertical, 14.7)
                List {
                    ForEach(0..<viewModel.profileStatArray.count, id: \.self) { index in
                        HStack(spacing: 8) {
                                Text("\(index + 1)")
                                    .font(.system(size: 15, weight: .regular))
                                    .frame(width: 27)
                                StatCellView(profile: viewModel.profileStatArray[index])
                        }
                        .background(
                            NavigationLink(
                                "",
                                destination: StatDetailedView(viewModel: detailedViewModel))
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
        }
    }
}

#Preview("Light Theme") {
    StatView()
        .preferredColorScheme(.light)
}

#Preview("Dark Theme") {
    StatView()
        .preferredColorScheme(.dark)
}
