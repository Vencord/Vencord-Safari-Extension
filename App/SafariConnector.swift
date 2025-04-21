//
//  SafariConnector.swift
//  Vencord Web
//
//  Created by samara on 21.04.2025.
//

#if os(macOS)
import Foundation
import SafariServices

enum SafariConnector {
    static func extensionIsEnabled() async -> Bool {
        await withCheckedContinuation { continuation in
            SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: EXTENSION_BUNDLE_ID) { state, error in
                let isEnabled = (error == nil) && (state?.isEnabled == true)
                continuation.resume(returning: isEnabled)
            }
        }
    }
    
    static func openExtensionPrefs() async {
        await withCheckedContinuation { continuation in
            SFSafariApplication.showPreferencesForExtension(withIdentifier: EXTENSION_BUNDLE_ID) { _ in
                continuation.resume()
            }
        }
    }
}


#endif
