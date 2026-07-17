#!/bin/bash
set -e

echo "Bootstrapping iOS app…"

if ! command -v xcodegen &> /dev/null; then
    brew install xcodegen
fi

mkdir -p SignerApp
cd SignerApp

cat > project.yml << 'EOF'
name: SignerApp
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

mkdir -p Sources

cat > Sources/AppDelegate.swift << 'EOF'
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool { true }
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
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: ContentView())
        self.window = window
        window.makeKeyAndVisible()
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

xcodegen generate
echo "iOS app created."
