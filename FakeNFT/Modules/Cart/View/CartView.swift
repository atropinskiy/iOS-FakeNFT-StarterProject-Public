//
//  CartView.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//

import SwiftUI

struct CartView: View {
    @StateObject private var cartViewModel = CartViewModel()
    
    var totalPrice: Double {
        Double(cartViewModel.nfts.reduce(0) { $0 + $1.price })
       }

       var body: some View {
           VStack(spacing: 0) {
               // Верхняя панель с фильтром
               HStack {
                   Spacer()
                   Button {
                       // действие фильтра
                   } label: {
                       Image("CartFilterImage")
                           .padding(.trailing, 9)
                   }
               }

               // Список NFT
               ScrollView {
                   VStack(spacing: 32) {
                       ForEach(cartViewModel.nfts, id: \.id) { nft in
                           CartViewCell(nft: nft) {
                               withAnimation {
                                   cartViewModel.nfts.removeAll { $0.id == nft.id }
                               }
                           }
                       }
                   }
                   .padding(.bottom, 16)
               }

               // Нижняя панель оплаты
               VStack {
                   Divider()
                   HStack {
                       VStack(alignment: .leading) {
                           Text("\(cartViewModel.nfts.count) NFT")
                               .foregroundColor(.gray)
                               .font(.subheadline)
                           Text("\(totalPrice, specifier: "%.2f") ETH")
                               .font(.title3)
                               .bold()
                               .foregroundColor(.blue)
                       }

                       Spacer()
                       
                       Button(action: {
                           // действие оплаты
                       }) {
                           Text("К оплате")
                               .foregroundColor(.white)
                               .fontWeight(.semibold)
                               .frame(maxWidth: .infinity)
                               .frame(height: 44)
                               .background(Color.black)
                               .cornerRadius(16)
                       }
                       .padding(.trailing, 16)
                   }
                   .padding()
               }
               .background(Color(UIColor.systemGray6))
           }
           .background(Color.white)
       }
   }

#Preview {
    CartView()
}
