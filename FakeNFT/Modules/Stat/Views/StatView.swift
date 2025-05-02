//
//  StatView.swift
//  FakeNFT
//
//  Created by alex_tr on 18.04.2025.
//

import SwiftUI

struct StatView: View {
    @ObservedObject var viewModel = ProfileStatViewModel()
    @State private var showActionSheet = false
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Button(action: {
                    showActionSheet.toggle()
                }) {
                    Image(colorScheme == .dark ? "sortingButtonDark" : "sortingButtonLight") // Иконка меню
                }
                .confirmationDialog("Сортировка", isPresented: $showActionSheet, titleVisibility: .visible) {
                    Button("По имени") { print("Option 1 - Сортировка по имени") }
                    Button("По рейтингу") { print("Option 2 - Сортировка по рейтингу") }
                    Button("Закрыть", role: .cancel) {}
                }
                //                .actionSheet(isPresented: $showActionSheet) {
                //                    ActionSheet(title: Text(""), message: Text("Сортировка"), buttons: [
                //                        .default(Text("По имени")) { print("Option 1 - Сортировка по имени") },
                //                        .default(Text("По рейтингу")) { print("Option 2 - Сортировка по рейтингу") },
                //                        .cancel(Text("Закрыть"))
                //                    ])
                //                }
            }
            .padding(.top, 14.7)
            .padding(.bottom, 14.7)
            List {
                ForEach(0..<viewModel.profileStatViews.count) { value in
                    //            ForEach(viewModel.profileStatViews, id: \.self) { value in
                    HStack {
                        Text("\(value + 1)")
                        StatCellView(profile: viewModel.profileStatViews[value])
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .padding(.bottom, 8)
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            .ignoresSafeArea(edges: .bottom)
            .scrollIndicators(.never)
        }
        .padding(.horizontal, 16)
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
