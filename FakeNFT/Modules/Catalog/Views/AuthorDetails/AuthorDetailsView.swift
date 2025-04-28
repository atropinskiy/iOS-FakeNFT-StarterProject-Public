//
//  AuthorDetailsView.swift
//  FakeNFT
//
//  Created by alex_tr on 28.04.2025.
//

import SwiftUI
import WebKit

struct AuthorDetailsView: View {
    var body: some View {
        // Используем WebView с URL
        WebView(url: URL(string: "http://practicum.yandex.ru/")!)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    let progressHud = ProgressHUDService()
    
    @State private var isLoading = true

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
            parent.progressHud.dismiss()
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            // Скрыть индикатор в случае ошибки
            parent.isLoading = false
            parent.progressHud.dismiss()
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
            parent.progressHud.showProgress(message: "Загрузка")
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
