//
//  Theme.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/4/24.
//

import UIKit

enum Theme {
    enum Colors {
        static let navigationBarBackground = UIColor(named: "NavigationBarBackground")!
        static let tabBarBackground = UIColor(named: "TabBarBackground")!
        static let primaryText = UIColor(named: "PrimaryText")!
        static let secondaryText = UIColor(named: "SecondaryText")!
        static let ratioBackground = UIColor(named: "RatioBackground")!
        static let border = UIColor(named: "Border")!
        static let selectedRatio = UIColor(named: "SelectedRatio")!
    }
    
    enum Images {
        static let headerLogo = UIImage(named: "HeaderLogo")!
        static let BettingList = UIImage(named: "BettingList")!
        static let ticket = UIImage(systemName: "ticket")!.withRenderingMode(.alwaysTemplate)
        static let magnifyingglass = UIImage(systemName: "magnifyingglass")!.withRenderingMode(.alwaysTemplate)
    }
}
