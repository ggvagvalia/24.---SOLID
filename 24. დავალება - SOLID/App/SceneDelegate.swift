//
//  SceneDelegate.swift
//  24. დავალება - SOLID
//
//  Created by gvantsa gvagvalia on 5/8/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let photoViewModel = PhotoViewModel()
        window.rootViewController = UINavigationController(rootViewController: MainVC(photoViewModel: photoViewModel))
        self.window = window
        window.backgroundColor = .systemBackground
        window.makeKeyAndVisible()
    }
    
}

