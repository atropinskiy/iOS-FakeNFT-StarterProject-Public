//
//  CatalogGridCell.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI



struct CatalogGridCell: View {
    @State var likeState: Bool = false
    
    private let imgName: String
    init (imgName: String) {
        self.imgName = imgName
    }
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Image(imgName)
                    .resizable()
                    .frame(width: 108, height: 108)
                
                Button(action: {
                    likeState.toggle()
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(likeState ? Color(hex: "#F56B6C") : Color.white) //
                        .font(.system(size: 20))
                }
                .padding(10)
            }
            .padding(.bottom, 3)
            ZStack {
                VStack(spacing:0) {
                    CatalogStars(stars: 3)
                    Text("Archie")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 17, weight: .bold))
                        .padding(.top, 5)
                    Text("1 ETH")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 10, weight: .regular))
                        .padding(.top, 5)
                }
                CatalogTrash(inCart: true)
            }
            
            
            
            
        }
        .frame(maxWidth: 108)
    }
}

private struct CatalogStars: View {
    @State private var stars: Int
    
    init (stars: Int) {
        self.stars = stars
    }
    var body: some View {
        HStack (spacing: 2) {
            ForEach(0..<5) { index in
                Image(systemName: "star.fill")
                    .foregroundColor(index < self.stars ? Color.yellow : Color(hex: "#F7F7F8"))
                    .font(.system(size: 12))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

private struct CatalogTrash: View {
    @State private var inCart: Bool
    
    init (inCart: Bool) {
        self.inCart = inCart
    }
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                inCart.toggle()
            }) {
                Image(inCart ? "CatalogTrash" : "CatalogTrashCross")
                    .padding(.trailing, 12)
                    .padding(.top, 12)
            }
            
        }
    }
}

#Preview {
    CatalogGridCell(imgName: "MockNFTImg")
}
