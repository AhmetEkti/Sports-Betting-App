//
//  AppInitializer.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/7/24.
//

import Foundation
import FirebaseCore

class AppInitializer {
    static let shared = AppInitializer()
    
    private init() {}
    
    func initialize(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            TrackingPermissionManager.shared.requestTrackingPermission { granted in
                if granted {
                    FirebaseApp.configure()
                }
                completion()
            }
        }
    }
}
