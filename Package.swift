// swift-tools-version:5.9
// PayME Miniapp iOS SDK, Swift Package Manager (PREVIEW).
//
// The binaries are assets of the GitHub Release in PayME-Miniapp/native-ios (same zip and sha256 as the
// `PayME-Miniapp` pod). Tags of this repository always equal the pod version; a released checksum never changes.
import PackageDescription

let v = "0.14.1"
let base = "https://github.com/PayME-Miniapp/native-ios/releases/download/\(v)"

let package = Package(
  name: "PayMEMiniApp",
  platforms: [.iOS(.v13)],
  products: [
    .library(name: "PayMEMiniApp", targets: ["PayMEMiniApp", "PayMEMiniAppDeps"]),
  ],
  dependencies: [
    // Apps must use lottie-spm (not airbnb/lottie-ios from source) and iProov/ios-spm (not iProov/ios):
    // SwiftPM rejects two packages that vend the same product/module name.
    .package(url: "https://github.com/airbnb/lottie-spm.git", exact: "4.6.1"),
    .package(url: "https://github.com/KalapaJSC/kalapa-ekyc-ios-sdk.git", .upToNextMinor(from: "2.8.9")),
    .package(url: "https://github.com/iProov/ios-spm.git", exact: "12.5.0"),
  ],
  targets: [
    .binaryTarget(
      name: "PayMEMiniApp",
      url: "\(base)/PayMEMiniApp.xcframework.zip",
      checksum: "0847fc3c3ebb0e0525cd89d08731a0a31aea91b2ff84393d2ec8502846985fa9"),
    // Preview only (until the SDK ships its own local web server): GCDWebServer 3.5.4, built from the same archive
    // as PayMEMiniApp so the install name and symbols match. BSD license inside each GCDWebServer.framework.
    .binaryTarget(
      name: "GCDWebServer",
      url: "\(base)/GCDWebServer.xcframework.zip",
      checksum: "1903a856f81e3f1005a97321cd61990ac841326fdc4c8c46a00ceabce0ededcf"),
    // A binaryTarget cannot declare dependencies: this source target makes SwiftPM link and embed them in the app.
    .target(
      name: "PayMEMiniAppDeps",
      dependencies: [
        .product(name: "Lottie", package: "lottie-spm"),
        .product(name: "KalapaEkycSDK", package: "kalapa-ekyc-ios-sdk"),
        .product(name: "iProov", package: "ios-spm"),
        "GCDWebServer",
      ],
      path: "Sources/PayMEMiniAppDeps"),
  ]
)
