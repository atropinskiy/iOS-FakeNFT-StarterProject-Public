//
//  StatView.swift
//  FakeNFT
//
//  Created by alex_tr on 18.04.2025.
//

import SwiftUI

struct StatView: View {
    @ObservedObject var viewModel = ProfileStatViewModel()

    var body: some View {
        List {
            ForEach(0..<viewModel.profileStatViews.count) { value in
//            ForEach(viewModel.profileStatViews, id: \.self) { value in
                HStack {
                    Text("\(value + 1)")
//                    Spacer()
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
        .padding(.horizontal, 16)
        .padding(.top, 1)
        .scrollIndicators(.never)
    }
}

#Preview {
    StatView()
}
