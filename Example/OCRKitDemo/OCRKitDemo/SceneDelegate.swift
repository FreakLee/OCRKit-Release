//
//  SceneDelegate.swift
//  OCRKitDemo
//
//  Created by min Lee on 2026/04/05.
//  Copyright © 2026 min Lee. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        let nav = UINavigationController(rootViewController: ViewController())
        nav.navigationBar.prefersLargeTitles = true
        window.rootViewController = nav
        self.window = window
        window.makeKeyAndVisible()
    }
}
