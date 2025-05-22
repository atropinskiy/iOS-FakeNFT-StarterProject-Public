//
//  UserSiteView.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 09.05.2025.
//

import SwiftUI
import WebKit

struct UserSiteView: View {
    let urlString = "https://practicum.yandex.ru"
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            if let url = URL(string: urlString), isValidURL(url) {
                UserWebView(url: url)
                    .ignoresSafeArea(.all, edges: .bottom)
            } else {
                errorWebView
            }
        }
        .navigationTitle("Яндекс Практикум")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }

    private func isValidURL(_ url: URL) -> Bool {
        url.absoluteString.contains("yandex.ru")
    }

    private var errorWebView: some View {
        VStack {
            Text("Ошибка загрузки")
                .foregroundStyle(Color(.tRedUn))
            Text("Проверьте подключение к интернету и попробуйте позже.")
            Button("Назад") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Color(.tWhite))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 5)
    }
}

#Preview {
    UserSiteView()
}

struct UserWebView: UIViewRepresentable {
    let url: URL
    let progressHUD = ProgressHUDService.shared
    @State private var isLoading: Bool = true

    func makeUIView(context: Context) -> WKWebView {

        // Настройка конфигурации с новым API
        let config = WKWebViewConfiguration()
        // Создаем настройки для загрузки страницы
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        preferences.preferredContentMode = .mobile
        config.defaultWebpagePreferences = preferences

        // Настройки страницы
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.url == nil || uiView.url?.host() != url.host {
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
            // Загружаем с учетом preferences
            uiView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    final class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: UserWebView

        init(parent: UserWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
            parent.progressHUD.showProgress(message: "Загрузка...")
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
            parent.progressHUD.dismiss()
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
            parent.isLoading = false
            parent.progressHUD.dismiss()
        }

        // MARK: WkUIDelegate

        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
    }
}
