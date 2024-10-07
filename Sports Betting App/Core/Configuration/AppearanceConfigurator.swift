//
//  AppearanceConfigurator.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/7/24.
//

import UIKit

struct AppearanceConfigurator {
    static func configure() {
        configureTabBar()
    }
    
    private static func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Theme.Colors.tabBarBackground
        
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
