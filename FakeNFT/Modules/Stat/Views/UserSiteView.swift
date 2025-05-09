//
//  UserSiteView.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 09.05.2025.
//

import SwiftUI
import WebKit

struct UserSiteView: View {
    var body: some View {
        NavigationStack {
            UserWebView(url: URL(string: "https://practicum.yandex.ru")!)
                .navigationTitle("Яндекс Практикум")
                .navigationBarTitleDisplayMode(.inline)
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        BackButtonView()
                    }
                }
                .toolbar(.hidden, for: .tabBar)
        }
    }
}

#Preview {
    UserSiteView()
}

struct UserWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        // Здесь можно обрабатывать события загрузки страницы
    }
}
