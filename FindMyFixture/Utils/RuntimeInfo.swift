//
//  RunTimeInfo.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 03.03.22.
//

import Foundation

public struct RuntimeInfo {

    public static var isUnderTesting: Bool = {
        NSClassFromString("XCTestCase") != nil
    }()

    public static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"

    public static var isAppStore: Bool {
        return isRelease && !isTestFlight
    }

    public static var isRelease: Bool {
        #if RELEASE
        return true
        #else
        return false
        #endif
    }

    public static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }

    public static var isAlpha: Bool {
        #if ALPHA
        return true
        #else
        return false
        #endif
    }

    public static var isProfile: Bool {
        #if PROFILE
        return true
        #else
        return false
        #endif
    }

    public static var isMockingEnabled: Bool = {
        isEnabled(variableName: "com.wetter.isMockingEnabled")
    }()

    public static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }

    public static var shouldShowDeveloperBackdoorScreen: Bool = {
        isEnabled(variableName: "com.wetter.shouldShowDeveloperBackdoorScreen")
    }()

    public static var isUnderSwiftUIPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil
    }

    public static var shouldNotShow3rdPartyLogs: Bool = {
        isEnabled(variableName: "com.wetter.shouldNotShow3rdPartyLogs")
    }()

    public static var isFirebaseDebugEnabled: Bool = {
        isEnabled(variableName: "com.wetter.isFirebaseDebugEnabled")
    }()

    private static func isEnabled(variableName: String, defaultValue: Bool = false) -> Bool {
        let variable = ProcessInfo.processInfo.environment[variableName]
        if let value = variable?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
            return value == "yes" || value == "true"
        } else {
            return defaultValue
        }
    }
}
