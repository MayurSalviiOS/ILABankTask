//
//  AppDelegate.swift
//  MayurILATask
//
//  Created by Neosoft on 16/05/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Created Window and setup root
        setupRootViewController()
        
        return true
    }
    
    func setupRootViewController(){
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let homeViewModel = HomeViewModel()
        let homeVC = HomeViewController(viewModel: homeViewModel)
        let navigationController = UINavigationController(rootViewController: homeVC)
        self.window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
