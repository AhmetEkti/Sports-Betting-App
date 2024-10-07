//
//  TrackingPermissionManager.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/7/24.
//

import Foundation
import AppTrackingTransparency

class TrackingPermissionManager {
    static let shared = TrackingPermissionManager()
    
    private init() {}
    
    func requestTrackingPermission(completion: @escaping (Bool) -> Void) {
        if #available(iOS 14.5, *) {
            let currentStatus = ATTrackingManager.trackingAuthorizationStatus
            
            ATTrackingManager.requestTrackingAuthorization { status in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        completion(true)
                    case .denied:
                        completion(false)
                    case .restricted:
                        completion(false)
                    case .notDetermined:
                        completion(false)
                    @unknown default:
                        completion(false)
                    }
                }
            }
        } else {
            completion(true)
        }
    }
}
