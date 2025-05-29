import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: TabBarView())
        self.window = window
        window.makeKeyAndVisible()
    }
}

//final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//    var window: UIWindow?
//
//    let servicesAssembly = ServicesAssembly(
//        networkClient: DefaultNetworkClient(),
//        nftStorage: NftStorageImpl()
//    )
//
//    func scene(_: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
//        let tabBarController = window?.rootViewController as? TabBarController
//        tabBarController?.servicesAssembly = servicesAssembly
//    }
//}
