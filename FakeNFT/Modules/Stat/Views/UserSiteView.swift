//
//  UserSiteView.swift
//  FakeNFT
//
//  Created by Valery Zvonarev on 09.05.2025.
//

import SwiftUI
import WebKit

struct UserSiteView: View {
//    let urlString = "https://practicum.yandex.ru"
    let user: User
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading: Bool = true

    init(user: User) {
    self.user = user
    }

    var body: some View {
        ZStack {
            if let url = URL(string: user.website), isValidURL(url) {
                UserWebView(url: url, isLoading: $isLoading)
                    .ignoresSafeArea(.all, edges: .bottom)
            } else {
                errorWebView
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView(isLoading: $isLoading)
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }

    private func isValidURL(_ url: URL) -> Bool {
//        url.absoluteString.contains("yandex.ru")
        // 1. Проверка схемы URL (http/https)
        guard let scheme = url.scheme, ["http", "https"].contains(scheme.lowercased()) else { return false }
        // 2. Проверка хоста (домена)
        guard let host = url.host, !host.isEmpty else { return false }
        // 3. Проверка валидности домена
        let hostPattern = "^([a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,}$"
        let hostTest = NSPredicate(format: "SELF MATCHES %@", hostPattern)
        guard hostTest.evaluate(with: host) else { return false }
        // 4. Дополнительные проверки (опционально)
        do {
            // Проверка с использованием NSDataDetector
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector.matches(in: url.absoluteString, range: NSRange(location: 0, length: url.absoluteString.utf16.count))

            guard let match = matches.first else { return false }
            return match.range.length == url.absoluteString.utf16.count
        } catch {
            return false
        }
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
    let userViewWithImage = User(name: "Alex", avatar: "alex",  description: "Alex Alex Alex", website: "https://ya.ru", nfts: [], rating: "112", id: "1")
    UserSiteView(user: userViewWithImage)
}

struct UserWebView: UIViewRepresentable {
    let url: URL
    let progressHUD = ProgressHUDService.shared
    @Binding var isLoading: Bool

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
        context.coordinator.webView = webView // сохраняем ссылку
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

    static func dismantleUIView(_ uiView: WKWebView, coordinator: Coordinator) {
        uiView.stopLoading() //стоп загрузки
        coordinator.parent.isLoading = false // сброс индикатора загрузки
        coordinator.parent.progressHUD.dismiss() // скрытие индикатора
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    final class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: UserWebView
        weak var webView: WKWebView?

        init(parent: UserWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
            parent.progressHUD.show(message: "Загрузка...")
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
