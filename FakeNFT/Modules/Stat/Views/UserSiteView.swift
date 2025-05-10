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
        let webView = WKWebView()
        //        print("Загружаемый URL: \(url.absoluteString)")
        //        print("1) makeUIView")
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        // Настройка конфигурации с новым API
        let config = webView.configuration
        // Создаем настройки для загрузки страницы
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        preferences.preferredContentMode = .mobile
        config.defaultWebpagePreferences = preferences
        config.websiteDataStore = .default()
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        config.preferences.isFraudulentWebsiteWarningEnabled = true
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.url == nil || uiView.url?.host() != url.host {
            let request = URLRequest(url: url)
            // Загружаем с учетом preferences
            uiView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: UserWebView

        init(parent: UserWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            //            print("2) didStartProvisionalNavigation")
            Task { @MainActor in
                parent.isLoading = true
                parent.showError = false
            }
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            //            print("3) didFinish")
            Task { @MainActor in
                parent.isLoading = false
            }
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
            return .allow
        }

        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
            //            print("5) didFail")
            Task { @MainActor in
                parent.isLoading = false
                parent.showError = true
            }
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: any Error) {
            //            print("6) didFailProvisionalNavigation")
            Task { @MainActor in
                parent.isLoading = false
                parent.showError = true
            }
        }
    }
}
