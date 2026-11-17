// SPMSmoke: the smallest app that links PayMEMiniApp through Swift Package Manager.
// It opens the PayME miniapp in sandbox, then checks that the SDK's local web server answers on localhost:29398.
// Look for "SPMSMOKE:" lines in the console (`xcrun simctl launch --console-pty <udid> vn.payme.SPMSmoke`).
import PayMEMiniApp
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   configurationForConnecting connectingSceneSession: UISceneSession,
                   options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    let config = UISceneConfiguration(name: "Default", sessionRole: connectingSceneSession.role)
    config.delegateClass = SceneDelegate.self
    return config
  }
}

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = SmokeViewController()
    window?.makeKeyAndVisible()
  }
}

final class SmokeViewController: UIViewController, PayMEDelegate {
  private var payme: PayME?
  private var opened = false
  private let status = UILabel()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    status.numberOfLines = 0
    status.textAlignment = .center
    status.text = "SPMSmoke"
    status.frame = view.bounds.insetBy(dx: 16, dy: 80)
    status.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(status)

    PayMEConfig.instance.env = .sbx
    PayMEConfig.instance.setMode("miniapp_sandbox")
    let payme = PayME(locale: .vi)
    payme.delegate = self
    self.payme = payme
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    guard !opened, let payme else { return }
    opened = true
    log("opening PayME (sandbox)")
    payme.open(with: .payme(), from: self, type: .screen)
    DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in self?.checkLocalServer() }
  }

  private func checkLocalServer() {
    var request = URLRequest(url: URL(string: "http://localhost:29398/")!)
    request.cachePolicy = .reloadIgnoringLocalCacheData
    URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
      let code = (response as? HTTPURLResponse)?.statusCode ?? -1
      DispatchQueue.main.async {
        self?.log("local server GET / -> \(code), \(data?.count ?? 0) bytes\(error.map { ", error \($0)" } ?? "")")
      }
    }.resume()
  }

  private func log(_ message: String) {
    print("SPMSMOKE: \(message)")
    status.text = message
  }

  func onResponse(action: PayMEAction, response: [String: Any]) { log("onResponse \(action)") }
  func onError(action: PayMEAction, error: PayMEError) { log("onError \(action) \(error.code)") }
}
