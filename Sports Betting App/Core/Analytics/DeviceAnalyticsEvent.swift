//
//  DeviceAnalyticsEvent.swift
//  Vivi Messenger
//
//  Created by Ahmet Ekti on 11/29/24.
//

import UIKit
import SystemConfiguration

enum DeviceAnalyticsEvent: AnalyticsEvent {
    case deviceStats
       
       var name: String {
           switch self {
           case .deviceStats: return "device_stats"
           }
       }
       
       var parameters: [String: Any]? {
           switch self {
           case .deviceStats:
               return [
                   // Timestamp
                   "timestamp": Date().timeIntervalSince1970,
                   "formatted_date": formatDate(Date()),
                   
                   // Device Info
                   "device_model": formatDeviceModel(UIDevice.current.model),
                   "device_os": "iOS " + UIDevice.current.systemVersion,
                   "device_language": formatLanguage(Locale.current.language.languageCode?.identifier ?? "unknown"),
                   "device_region": formatRegion(Locale.current.region?.identifier ?? "unknown"),
                   "device_timezone": formatTimezone(TimeZone.current.identifier),
                   
                   // Battery Info
                   "battery_level": formatBatteryPercentage(UIDevice.current.batteryLevel),
                   "battery_state": formatChargingStatus(UIDevice.current.batteryState),
                   "battery_saver": ProcessInfo.processInfo.isLowPowerModeEnabled ? "Enabled" : "Disabled",
                   
                   // System Info
                   "memory_usage": formatMemoryUsage(getMemoryUsage()),
                   "disk_space": formatDiskSpace(getFreeDiskSpace()),
                   
                   // Network Info
                   "network_type": formatNetworkType(getCurrentNetworkType()),
                   "vpn_enabled": isVPNConnected() ? "Connected" : "Not Connected"
               ]
           }
       }
  
    // MARK: - Formatting Methods
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
    
    private func formatDeviceModel(_ model: String) -> String {
        return model
    }
    
    private func formatLanguage(_ code: String) -> String {
        let locale = Locale(identifier: code)
        return locale.localizedString(forLanguageCode: code)?.capitalized ?? code
    }
    
    private func formatRegion(_ code: String) -> String {
        let locale = Locale(identifier: code)
        return locale.localizedString(forRegionCode: code)?.capitalized ?? code
    }
    
    private func formatTimezone(_ identifier: String) -> String {
        guard let timezone = TimeZone(identifier: identifier) else { return identifier }
        let hours = timezone.secondsFromGMT() / 3600
        let sign = hours >= 0 ? "+" : ""
        let location = identifier.components(separatedBy: "/").last?.replacingOccurrences(of: "_", with: " ") ?? identifier
        return "\(location) (UTC\(sign)\(hours))"
    }
    
    private func formatBatteryPercentage(_ level: Float) -> String {
        return "\(Int(level * 100))%"
    }
    
    private func formatChargingStatus(_ state: UIDevice.BatteryState) -> String {
        switch state {
        case .charging: return "Charging"
        case .full: return "Fully Charged"
        case .unplugged: return "Not Charging"
        case .unknown: return "Unknown"
        @unknown default: return "Unknown"
        }
    }
    
    private func formatMemoryUsage(_ usage: Double) -> String {
        if usage >= 1024 {
            return String(format: "%.1f GB", usage / 1024)
        }
        return String(format: "%.1f MB", usage)
    }
    
    private func formatDiskSpace(_ bytes: Int64) -> String {
        let gb = Double(bytes) / 1024 / 1024 / 1024
        return String(format: "%.1f GB", gb)
    }
    
    private func formatNetworkType(_ type: String) -> String {
        switch type {
        case "wifi": return "Wi-Fi"
        case "cellular": return "Cellular"
        default: return "Unknown"
        }
    }
    
    private func formatTimeInterval(_ interval: TimeInterval) -> [String: Int] {
        let seconds = Int(interval.truncatingRemainder(dividingBy: 60))
        let minutes = Int((interval / 60).truncatingRemainder(dividingBy: 60))
        let hours = Int(interval / 3600)
        
        var result: [String: Int] = [:]
        
        if hours > 0 {
            result["hours"] = hours
            result["minutes"] = minutes
            result["seconds"] = seconds
        } else if minutes > 0 {
            result["minutes"] = minutes
            result["seconds"] = seconds
        } else {
            result["seconds"] = seconds
        }
        
        return result
    }
    
    // MARK: - Helper Methods
    private func getMemoryUsage() -> Double {
        var taskInfo = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        return kerr == KERN_SUCCESS ? Double(taskInfo.resident_size) / 1024.0 / 1024.0 : 0
    }
    
    private func getFreeDiskSpace() -> Int64 {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return 0
        }
        
        do {
            let attributes = try FileManager.default.attributesOfFileSystem(forPath: path)
            return (attributes[.systemFreeSize] as? NSNumber)?.int64Value ?? 0
        } catch {
            return 0
        }
    }
    
    private func getCurrentNetworkType() -> String {
        let reachability = SCNetworkReachabilityCreateWithName(nil, "8.8.8.8")
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        
        let isWiFi = flags.contains(.isWWAN) == false && flags.contains(.reachable)
        let isCellular = flags.contains(.isWWAN)
        
        if isWiFi {
            return "wifi"
        } else if isCellular {
            return "cellular"
        }
        return "unknown"
    }
    
    private func isVPNConnected() -> Bool {
        if let cfDict = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as NSDictionary? {
            let keys = cfDict["__SCOPED__"] as? NSDictionary
            return (keys?.allKeys ?? []).contains { key in
                "\(key)".contains("tap") || "\(key)".contains("tun") ||
                "\(key)".contains("ppp") || "\(key)".contains("ipsec")
            }
        }
        return false
    }
}
// AnalyticsLogger extension
extension AnalyticsLogger {
    func logDeviceStats() {
        logEvent(DeviceAnalyticsEvent.deviceStats)
    }
}
