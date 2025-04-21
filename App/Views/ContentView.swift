//
//  ContentView.swift
//  Vencord Web
//
//  Created by samara on 21.04.2025.
//

import SwiftUI

// MARK: - View
struct ContentView: View {
	@State private var enabled = false
	
	#if os(macOS)
	private var message: String {
		enabled
		? "Extension is enabled"
		: "Extension is disabled. Enable it in Safari Preferences."
	}
	#endif
	
	// MARK: Body
	var body: some View {
		VStack(spacing: 12) {
			#if os(macOS)
			_icon()
			
			_message()
			
			Button("Quit and Open Safari Preferences") {
				_openPreferences()
			}
			#else
			Text("Welcome to Vencord!")
			#endif
		}
		.onAppear {
			Task {
				self.enabled = await SafariConnector.extensionIsEnabled()
			}
		}
	}
	
	private func _openPreferences() {
		Task {
			await SafariConnector.openExtensionPrefs()
			NSApplication.shared.terminate(nil)
		}
	}
}

// MARK: - Extension: View
extension ContentView {
	@ViewBuilder
	private func _icon() -> some View {
		Image("LargeIcon")
			.resizable()
			.frame(width: 100, height: 100)
	}
	
	#if os(macOS)
	@ViewBuilder
	private func _message() -> some View {
		Text(message)
	}
	#endif
}
