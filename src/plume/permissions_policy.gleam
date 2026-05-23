//// Permissions-Policy
////
//// This response header lets a site declare which
//// browser features the document and any embedded frames are allowed to use.
//// A policy is a comma-separated list of directives, each pairing a feature
//// name with an allowlist of origins that may use it.
////
//// Each directive has its own browser default when the header is not set —
//// commonly `self`, but some features default to `*`. Omitting a directive
//// defers to whichever default the browser applies. An empty allowlist
//// (`Origins([])`) renders as `()` and disables the feature everywhere.
////
//// ## Examples
////
//// ```gleam
//// Policy([
////   Geolocation(Origins([])),
////   Camera(Origins([Self])),
////   Fullscreen(Wildcard),
//// ])
//// ```
////
//// See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Permissions-Policy).

import gleam/list
import gleam/string

/// A `Permissions-Policy` header value.
///
pub type PermissionsPolicy {
  Policy(List(Directive))
}

/// A single Permissions-Policy directive pairing a feature with an allowlist.
///
pub type Directive {
  /// Controls access to the Accelerometer API.
  Accelerometer(Allowlist)
  /// Controls access to the AmbientLightSensor API.
  AmbientLightSensor(Allowlist)
  /// Controls access to the `ariaNotify()` method used to send notifications
  /// to assistive technologies.
  AriaNotify(Allowlist)
  /// Controls access to the Attribution Reporting API.
  AttributionReporting(Allowlist)
  /// Controls whether media (`<audio>`, `<video>`) is allowed to autoplay.
  Autoplay(Allowlist)
  /// Controls access to the Web Bluetooth API.
  Bluetooth(Allowlist)
  /// Controls access to the Topics API.
  BrowsingTopics(Allowlist)
  /// Controls access to video input devices via `getUserMedia()`.
  Camera(Allowlist)
  /// Controls access to the Captured Surface Control API.
  CapturedSurfaceControl(Allowlist)
  /// Controls whether high-entropy Client Hint values are returned by
  /// `NavigatorUAData.getHighEntropyValues()`.
  ChUaHighEntropyValues(Allowlist)
  /// Controls access to the Compute Pressure API.
  ComputePressure(Allowlist)
  /// Controls whether the document can be treated as cross-origin isolated.
  CrossOriginIsolated(Allowlist)
  /// Controls access to the Fetch API's deferred-fetch capability.
  DeferredFetch(Allowlist)
  /// Smaller-quota variant of `deferred-fetch`.
  DeferredFetchMinimal(Allowlist)
  /// Controls access to screen-share input via `getDisplayMedia()`.
  DisplayCapture(Allowlist)
  /// Controls access to the Encrypted Media Extensions API.
  EncryptedMedia(Allowlist)
  /// Controls the use of `Element.requestFullscreen()`.
  Fullscreen(Allowlist)
  /// Controls access to the Gamepad API.
  Gamepad(Allowlist)
  /// Controls access to the Geolocation API.
  Geolocation(Allowlist)
  /// Controls access to the Gyroscope API.
  Gyroscope(Allowlist)
  /// Controls access to the WebHID API.
  Hid(Allowlist)
  /// Controls access to the Federated Credential Management API's `get()`
  /// method.
  IdentityCredentialsGet(Allowlist)
  /// Controls access to the Idle Detection API.
  IdleDetection(Allowlist)
  /// Controls access to the built-in `LanguageDetector` API.
  LanguageDetector(Allowlist)
  /// Controls access to the Local Font Access API.
  LocalFonts(Allowlist)
  /// Controls access to the Magnetometer API.
  Magnetometer(Allowlist)
  /// Controls access to audio input devices via `getUserMedia()`.
  Microphone(Allowlist)
  /// Controls access to the Web MIDI API.
  Midi(Allowlist)
  /// Controls access to on-device speech recognition in the Web Speech API.
  OnDeviceSpeechRecognition(Allowlist)
  /// Controls access to the WebOTP API.
  OtpCredentials(Allowlist)
  /// Controls access to the Payment Request API.
  Payment(Allowlist)
  /// Controls access to Picture-in-Picture mode for `<video>` elements.
  PictureInPicture(Allowlist)
  /// Controls the ability to issue Private State Tokens.
  PrivateStateTokenIssuance(Allowlist)
  /// Controls the ability to redeem Private State Tokens.
  PrivateStateTokenRedemption(Allowlist)
  /// Controls access to the Web Authentication API's `create()` method.
  PublicKeyCredentialsCreate(Allowlist)
  /// Controls access to the Web Authentication API's `get()` method.
  PublicKeyCredentialsGet(Allowlist)
  /// Controls access to the Screen Wake Lock API.
  ScreenWakeLock(Allowlist)
  /// Controls access to the Web Serial API.
  Serial(Allowlist)
  /// Controls access to the Audio Output Devices API for selecting speakers.
  SpeakerSelection(Allowlist)
  /// Controls access to the Storage Access API.
  StorageAccess(Allowlist)
  /// Controls access to the built-in `Summarizer` API.
  Summarizer(Allowlist)
  /// Controls access to the built-in `Translator` API.
  Translator(Allowlist)
  /// Controls access to the WebUSB API.
  Usb(Allowlist)
  /// Controls access to `navigator.share()` from the Web Share API.
  WebShare(Allowlist)
  /// Controls access to the Window Management API.
  WindowManagement(Allowlist)
  /// Controls access to spatial tracking features in the WebXR Device API.
  XrSpatialTracking(Allowlist)
}

/// The set of origins allowed to use a feature.
///
pub type Allowlist {
  /// Allow the feature in any origin. Rendered as `*`.
  Wildcard
  /// Allow the feature in the listed origins. An empty list renders as `()`
  /// and disables the feature everywhere — for the document and any nested
  /// frames. Use `Wildcard` to allow any origin instead.
  Origins(List(Origin))
}

/// An origin entry within an `Allowlist`.
///
pub type Origin {
  /// The document's own origin. Rendered as `self`.
  Self
  /// The origin of the iframe's `src` attribute. Primarily meaningful in
  /// iframe `allow=` contexts.
  Src
  /// A specific origin URL. Rendered as `"<url>"`.
  Url(String)
}

/// Encode as the `Permissions-Policy` header value.
///
pub fn to_string(value: PermissionsPolicy) -> String {
  let Policy(directives) = value
  directives
  |> list.map(directive_to_string)
  |> string.join(", ")
}

fn directive_to_string(directive: Directive) -> String {
  case directive {
    Accelerometer(allowlist) -> render_directive("accelerometer", allowlist)
    AmbientLightSensor(allowlist) ->
      render_directive("ambient-light-sensor", allowlist)
    AriaNotify(allowlist) -> render_directive("aria-notify", allowlist)
    AttributionReporting(allowlist) ->
      render_directive("attribution-reporting", allowlist)
    Autoplay(allowlist) -> render_directive("autoplay", allowlist)
    Bluetooth(allowlist) -> render_directive("bluetooth", allowlist)
    BrowsingTopics(allowlist) -> render_directive("browsing-topics", allowlist)
    Camera(allowlist) -> render_directive("camera", allowlist)
    CapturedSurfaceControl(allowlist) ->
      render_directive("captured-surface-control", allowlist)
    ChUaHighEntropyValues(allowlist) ->
      render_directive("ch-ua-high-entropy-values", allowlist)
    ComputePressure(allowlist) ->
      render_directive("compute-pressure", allowlist)
    CrossOriginIsolated(allowlist) ->
      render_directive("cross-origin-isolated", allowlist)
    DeferredFetch(allowlist) -> render_directive("deferred-fetch", allowlist)
    DeferredFetchMinimal(allowlist) ->
      render_directive("deferred-fetch-minimal", allowlist)
    DisplayCapture(allowlist) -> render_directive("display-capture", allowlist)
    EncryptedMedia(allowlist) -> render_directive("encrypted-media", allowlist)
    Fullscreen(allowlist) -> render_directive("fullscreen", allowlist)
    Gamepad(allowlist) -> render_directive("gamepad", allowlist)
    Geolocation(allowlist) -> render_directive("geolocation", allowlist)
    Gyroscope(allowlist) -> render_directive("gyroscope", allowlist)
    Hid(allowlist) -> render_directive("hid", allowlist)
    IdentityCredentialsGet(allowlist) ->
      render_directive("identity-credentials-get", allowlist)
    IdleDetection(allowlist) -> render_directive("idle-detection", allowlist)
    LanguageDetector(allowlist) ->
      render_directive("language-detector", allowlist)
    LocalFonts(allowlist) -> render_directive("local-fonts", allowlist)
    Magnetometer(allowlist) -> render_directive("magnetometer", allowlist)
    Microphone(allowlist) -> render_directive("microphone", allowlist)
    Midi(allowlist) -> render_directive("midi", allowlist)
    OnDeviceSpeechRecognition(allowlist) ->
      render_directive("on-device-speech-recognition", allowlist)
    OtpCredentials(allowlist) -> render_directive("otp-credentials", allowlist)
    Payment(allowlist) -> render_directive("payment", allowlist)
    PictureInPicture(allowlist) ->
      render_directive("picture-in-picture", allowlist)
    PrivateStateTokenIssuance(allowlist) ->
      render_directive("private-state-token-issuance", allowlist)
    PrivateStateTokenRedemption(allowlist) ->
      render_directive("private-state-token-redemption", allowlist)
    PublicKeyCredentialsCreate(allowlist) ->
      render_directive("publickey-credentials-create", allowlist)
    PublicKeyCredentialsGet(allowlist) ->
      render_directive("publickey-credentials-get", allowlist)
    ScreenWakeLock(allowlist) -> render_directive("screen-wake-lock", allowlist)
    Serial(allowlist) -> render_directive("serial", allowlist)
    SpeakerSelection(allowlist) ->
      render_directive("speaker-selection", allowlist)
    StorageAccess(allowlist) -> render_directive("storage-access", allowlist)
    Summarizer(allowlist) -> render_directive("summarizer", allowlist)
    Translator(allowlist) -> render_directive("translator", allowlist)
    Usb(allowlist) -> render_directive("usb", allowlist)
    WebShare(allowlist) -> render_directive("web-share", allowlist)
    WindowManagement(allowlist) ->
      render_directive("window-management", allowlist)
    XrSpatialTracking(allowlist) ->
      render_directive("xr-spatial-tracking", allowlist)
  }
}

fn render_directive(name: String, allowlist: Allowlist) -> String {
  name <> "=" <> allowlist_to_string(allowlist)
}

fn allowlist_to_string(allowlist: Allowlist) -> String {
  case allowlist {
    Wildcard -> "*"
    Origins(origins) ->
      "(" <> string.join(list.map(origins, origin_to_string), " ") <> ")"
  }
}

fn origin_to_string(origin: Origin) -> String {
  case origin {
    Self -> "self"
    Src -> "src"
    Url(value) -> "\"" <> value <> "\""
  }
}
