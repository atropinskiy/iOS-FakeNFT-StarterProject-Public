//
//  WebView.swift
//  FakeNFT
//
//  Created by Oleg Kozyrev
//
import SwiftUI
import WebKit

struct CartWebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
            let request = URLRequest(url: url)
            uiView.load(request)
    }
}

