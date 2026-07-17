#!/bin/bash
set -e

echo "Bootstrapping iOS app…"

# Install xcodegen if missing
if ! command -v xcodegen &> /dev/null; then
    brew install xcodegen
fi

mkdir -p SignerApp
cd SignerApp

# Create project.yml
cat > project.yml << 'EOF'
name: SignerApp
options:
  minimumXcodeGenVersion: 2.0.0

targets:
  SignerApp:
    type: application
    platform: iOS
    deploymentTarget: "15.0"
    sources:
      - Sources
    settings:
      PRODUCT_BUNDLE_IDENTIFIER: com.jeremiah.signerapp
      DEVELOPMENT_TEAM: YOUR_TEAM_ID
      SWIFT_VERSION: 5.0
EOF

# Create source files
mkdir -p Sources

cat > Sources/AppDelegate.swift << 'EOF'
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        return true
    }
}
EOF

cat > Sources/SceneDelegate.swift << 'EOF'
import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: ContentView())
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
EOF

cat > Sources/ContentView.swift << 'EOF'
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Signer App Ready")
            .padding()
    }
}
EOF

echo "Generating Xcode project…"
xcodegen generate

echo "iOS app created successfully."
