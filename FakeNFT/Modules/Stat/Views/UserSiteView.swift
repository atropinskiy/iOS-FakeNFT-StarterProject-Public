//
//  UserSiteView.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 09.05.2025.
//

import SwiftUI
import WebKit

struct UserSiteView: View {
    let url = URL(string: "https://practicum.yandex.ru")!
    //    let url = URL(string: "https://www.apple.com")!
    @State private var isLoading = true
    @State private var showError = false
    var body: some View {
        ZStack {
            UserWebView(url: url, isLoading: $isLoading, showError: $showError)
                .edgesIgnoringSafeArea(.bottom)
            if isLoading {
                VStack {
                    ProgressView()
                        .scaleEffect(1.5)
                    Text("Загрузка...")
                }
            }
            if showError {
                VStack {
                    Text("Ошибка загрузки")
                        .foregroundColor(.red)
                    Text("Проверьте подключение к интернету и попробуйте позже.")
                    Button("Повторить загрузку") {
                        Task {
                            showError = false
                            isLoading = true
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(Color(.tWhite))
                .cornerRadius(12)
                .shadow(radius: 5)
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
}

#Preview {
    UserSiteView()
}

struct UserWebView: UIViewRepresentable {
    let url: URL
    @Binding var isLoading: Bool
    @Binding var showError: Bool

    func makeUIView(context: Context) -> WKWebView {

        // Настройка конфигурации с новым API
        let config = WKWebViewConfiguration()
        // Создаем настройки для загрузки страницы
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        preferences.preferredContentMode = .mobile
        config.defaultWebpagePreferences = preferences
        config.websiteDataStore = .default()
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        config.preferences.isFraudulentWebsiteWarningEnabled = true
        config.suppressesIncrementalRendering = false
        config.allowsInlineMediaPlayback = true
        config.allowsPictureInPictureMediaPlayback = false
        config.mediaTypesRequiringUserActionForPlayback = []

        // Настройки страницы
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        webView.evaluateJavaScript("document.body.style.pointerEvents = 'auto';") { _, _ in }

        // Добавляем user agent для мобильных устройств
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1"
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

    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: UserWebView
        private var pendingNavigation = Set<WKNavigation>()

        init(parent: UserWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("1) didStartProvisionalNavigation")
            Task { @MainActor in
                parent.isLoading = true
                parent.showError = false
                pendingNavigation.insert(navigation)
            }
        }

        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            print("2) Loading network content...")
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("3) didFinish")
            Task { @MainActor in
                if pendingNavigation.contains(navigation) {
                    parent.isLoading = false
                    pendingNavigation.remove(navigation)
                }
            }
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
            return .allow
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
            return .allow
        }


        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
            print("5) didFail")
            Task { @MainActor in
                if pendingNavigation.contains(navigation) {
                    parent.isLoading = false
                    parent.showError = true
                    pendingNavigation.remove(navigation)
                }
                // Игнорируем ошибку -999 (отмененные запросы)
                if (error as NSError).code != NSURLErrorCancelled {
                    print("Ошибка навигации: \(error.localizedDescription)")
                }
            }
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: any Error) {
            print("4) didFailProvisionalNavigation")
            Task { @MainActor in
                if pendingNavigation.contains(navigation) {
                    parent.isLoading = false
                    parent.showError = true
                    pendingNavigation.remove(navigation)
                }
                // Игнорируем ошибку -999
                if (error as NSError).code != NSURLErrorCancelled {
                    print("Ошибка навигации: \(error.localizedDescription)")
                }
            }
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
