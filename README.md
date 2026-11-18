# PayME Miniapp iOS SDK: Swift Package Manager

[Tiếng Việt](#tiếng-việt) | [English](#english)

## Tiếng Việt

Gói SwiftPM của [PayME Miniapp iOS SDK](https://github.com/PayME-Miniapp/native-ios). Hướng dẫn tích hợp, cấu hình `Info.plist` và API: xem [README của native-ios](https://github.com/PayME-Miniapp/native-ios/blob/main/README.md).

> Từ 0.15.0, Swift Package Manager là cách cài được khuyến nghị. CocoaPods (qua repo spec của PayME) vẫn được hỗ trợ ít nhất tới 11/2027.

### Yêu cầu

- Xcode 26.2 trở lên. iOS 13.0 trở lên.
- Ứng dụng tự dùng iProov thì dùng **`iProov/ios-spm`** (không dùng `iProov/ios`), nếu không SwiftPM báo lỗi `multiple similar targets 'iProov', 'iProovTargets' appear in package 'ios' and 'ios-spm'`. Từ 0.16.0 gói không dùng Lottie: ứng dụng dùng Lottie bản nào, cài kiểu nào cũng được.

### Cài đặt

Xcode → **File → Add Package Dependencies…** → `https://github.com/PayME-Miniapp/payme-miniapp-spm.git`, chọn **Up to Next Minor Version** từ `0.16.0`, rồi thêm product `PayMEMiniApp` vào target ứng dụng.

Hoặc trong `Package.swift`:

```swift
.package(url: "https://github.com/PayME-Miniapp/payme-miniapp-spm.git", .upToNextMinor(from: "0.16.0")),
// ...
.product(name: "PayMEMiniApp", package: "payme-miniapp-spm"),
```

Dùng `.upToNextMinor`, không dùng `from:`: với bản 0.x, `from:` sẽ nhận cả bản minor mới có thay đổi phá vỡ.

Gói tự kéo theo KalapaEkycSDK 2.8.x và iProov 12.5.0 (`iProov/ios-spm`). Binary `PayMEMiniApp.xcframework.zip` là asset của [GitHub Release](https://github.com/PayME-Miniapp/native-ios/releases) trên native-ios, cùng zip và cùng sha256 với pod `PayME-Miniapp`.

### Ví dụ

`Examples/SPMSmoke`: ứng dụng nhỏ nhất dùng gói này (đường dẫn `../..`), mở PayME ở sandbox và kiểm tra web server cục bộ (`localhost:29398`).

```sh
xcodebuild build -project Examples/SPMSmoke/SPMSmoke.xcodeproj -scheme SPMSmoke \
  -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO
```

### Giấy phép

MIT (`LICENSE`). Phần mềm bên thứ ba trong binary: `NOTICE` (SwiftyRSA MIT, ZIPFoundation MIT).

## English

Swift Package Manager package for the [PayME Miniapp iOS SDK](https://github.com/PayME-Miniapp/native-ios). Integration guide, `Info.plist` setup and API: see the [native-ios README](https://github.com/PayME-Miniapp/native-ios/blob/main/README.en.md).

> From 0.15.0, Swift Package Manager is the recommended installation. CocoaPods (through PayME's spec repo) stays supported at least until November 2027.

### Requirements

- Xcode 26.2 or later. iOS 13.0 or later.
- If your app uses iProov itself, use **`iProov/ios-spm`** (not `iProov/ios`); otherwise SwiftPM fails with `multiple similar targets 'iProov', 'iProovTargets' appear in package 'ios' and 'ios-spm'`. From 0.16.0 the package does not use Lottie: your app can use any Lottie version, installed any way.

### Installation

Xcode → **File → Add Package Dependencies…** → `https://github.com/PayME-Miniapp/payme-miniapp-spm.git`, choose **Up to Next Minor Version** from `0.16.0`, then add the `PayMEMiniApp` product to your app target.

Or in `Package.swift`:

```swift
.package(url: "https://github.com/PayME-Miniapp/payme-miniapp-spm.git", .upToNextMinor(from: "0.16.0")),
// ...
.product(name: "PayMEMiniApp", package: "payme-miniapp-spm"),
```

Use `.upToNextMinor`, not `from:`: for 0.x versions, `from:` also accepts new minor versions with breaking changes.

The package brings KalapaEkycSDK 2.8.x and iProov 12.5.0 (`iProov/ios-spm`). The `PayMEMiniApp.xcframework.zip` binary is an asset of the native-ios [GitHub Release](https://github.com/PayME-Miniapp/native-ios/releases): the same zip and sha256 as the `PayME-Miniapp` pod.

### Example

`Examples/SPMSmoke`: the smallest app using this package (path `../..`). It opens PayME in sandbox and checks the local web server (`localhost:29398`).

```sh
xcodebuild build -project Examples/SPMSmoke/SPMSmoke.xcodeproj -scheme SPMSmoke \
  -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO
```

### License

MIT (`LICENSE`). Third-party software in the binaries: `NOTICE` (SwiftyRSA MIT, ZIPFoundation MIT).
