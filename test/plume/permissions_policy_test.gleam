import plume/permissions_policy as pp

pub fn to_header_empty_test() {
  assert pp.to_string(pp.Policy([])) == ""
}

pub fn to_header_join_test() {
  assert pp.to_string(
      pp.Policy([
        pp.Camera(pp.Origins([])),
        pp.Geolocation(pp.Origins([pp.Self])),
      ]),
    )
    == "camera=(), geolocation=(self)"
}

pub fn directive_to_header_test() {
  assert pp.to_string(pp.Policy([pp.Accelerometer(pp.Origins([pp.Self]))]))
    == "accelerometer=(self)"
  assert pp.to_string(pp.Policy([pp.AmbientLightSensor(pp.Origins([pp.Self]))]))
    == "ambient-light-sensor=(self)"
  assert pp.to_string(pp.Policy([pp.AriaNotify(pp.Origins([pp.Self]))]))
    == "aria-notify=(self)"
  assert pp.to_string(
      pp.Policy([pp.AttributionReporting(pp.Origins([pp.Self]))]),
    )
    == "attribution-reporting=(self)"
  assert pp.to_string(pp.Policy([pp.Autoplay(pp.Origins([pp.Self]))]))
    == "autoplay=(self)"
  assert pp.to_string(pp.Policy([pp.Bluetooth(pp.Origins([pp.Self]))]))
    == "bluetooth=(self)"
  assert pp.to_string(pp.Policy([pp.BrowsingTopics(pp.Origins([pp.Self]))]))
    == "browsing-topics=(self)"
  assert pp.to_string(pp.Policy([pp.Camera(pp.Origins([pp.Self]))]))
    == "camera=(self)"
  assert pp.to_string(
      pp.Policy([pp.CapturedSurfaceControl(pp.Origins([pp.Self]))]),
    )
    == "captured-surface-control=(self)"
  assert pp.to_string(
      pp.Policy([pp.ChUaHighEntropyValues(pp.Origins([pp.Self]))]),
    )
    == "ch-ua-high-entropy-values=(self)"
  assert pp.to_string(pp.Policy([pp.ComputePressure(pp.Origins([pp.Self]))]))
    == "compute-pressure=(self)"
  assert pp.to_string(pp.Policy([pp.CrossOriginIsolated(pp.Origins([pp.Self]))]))
    == "cross-origin-isolated=(self)"
  assert pp.to_string(pp.Policy([pp.DeferredFetch(pp.Origins([pp.Self]))]))
    == "deferred-fetch=(self)"
  assert pp.to_string(
      pp.Policy([pp.DeferredFetchMinimal(pp.Origins([pp.Self]))]),
    )
    == "deferred-fetch-minimal=(self)"
  assert pp.to_string(pp.Policy([pp.DisplayCapture(pp.Origins([pp.Self]))]))
    == "display-capture=(self)"
  assert pp.to_string(pp.Policy([pp.EncryptedMedia(pp.Origins([pp.Self]))]))
    == "encrypted-media=(self)"
  assert pp.to_string(pp.Policy([pp.Fullscreen(pp.Origins([pp.Self]))]))
    == "fullscreen=(self)"
  assert pp.to_string(pp.Policy([pp.Gamepad(pp.Origins([pp.Self]))]))
    == "gamepad=(self)"
  assert pp.to_string(pp.Policy([pp.Geolocation(pp.Origins([pp.Self]))]))
    == "geolocation=(self)"
  assert pp.to_string(pp.Policy([pp.Gyroscope(pp.Origins([pp.Self]))]))
    == "gyroscope=(self)"
  assert pp.to_string(pp.Policy([pp.Hid(pp.Origins([pp.Self]))]))
    == "hid=(self)"
  assert pp.to_string(
      pp.Policy([pp.IdentityCredentialsGet(pp.Origins([pp.Self]))]),
    )
    == "identity-credentials-get=(self)"
  assert pp.to_string(pp.Policy([pp.IdleDetection(pp.Origins([pp.Self]))]))
    == "idle-detection=(self)"
  assert pp.to_string(pp.Policy([pp.LanguageDetector(pp.Origins([pp.Self]))]))
    == "language-detector=(self)"
  assert pp.to_string(pp.Policy([pp.LocalFonts(pp.Origins([pp.Self]))]))
    == "local-fonts=(self)"
  assert pp.to_string(pp.Policy([pp.Magnetometer(pp.Origins([pp.Self]))]))
    == "magnetometer=(self)"
  assert pp.to_string(pp.Policy([pp.Microphone(pp.Origins([pp.Self]))]))
    == "microphone=(self)"
  assert pp.to_string(pp.Policy([pp.Midi(pp.Origins([pp.Self]))]))
    == "midi=(self)"
  assert pp.to_string(
      pp.Policy([pp.OnDeviceSpeechRecognition(pp.Origins([pp.Self]))]),
    )
    == "on-device-speech-recognition=(self)"
  assert pp.to_string(pp.Policy([pp.OtpCredentials(pp.Origins([pp.Self]))]))
    == "otp-credentials=(self)"
  assert pp.to_string(pp.Policy([pp.Payment(pp.Origins([pp.Self]))]))
    == "payment=(self)"
  assert pp.to_string(pp.Policy([pp.PictureInPicture(pp.Origins([pp.Self]))]))
    == "picture-in-picture=(self)"
  assert pp.to_string(
      pp.Policy([pp.PrivateStateTokenIssuance(pp.Origins([pp.Self]))]),
    )
    == "private-state-token-issuance=(self)"
  assert pp.to_string(
      pp.Policy([pp.PrivateStateTokenRedemption(pp.Origins([pp.Self]))]),
    )
    == "private-state-token-redemption=(self)"
  assert pp.to_string(
      pp.Policy([pp.PublickeyCredentialsCreate(pp.Origins([pp.Self]))]),
    )
    == "publickey-credentials-create=(self)"
  assert pp.to_string(
      pp.Policy([pp.PublickeyCredentialsGet(pp.Origins([pp.Self]))]),
    )
    == "publickey-credentials-get=(self)"
  assert pp.to_string(pp.Policy([pp.ScreenWakeLock(pp.Origins([pp.Self]))]))
    == "screen-wake-lock=(self)"
  assert pp.to_string(pp.Policy([pp.Serial(pp.Origins([pp.Self]))]))
    == "serial=(self)"
  assert pp.to_string(pp.Policy([pp.SpeakerSelection(pp.Origins([pp.Self]))]))
    == "speaker-selection=(self)"
  assert pp.to_string(pp.Policy([pp.StorageAccess(pp.Origins([pp.Self]))]))
    == "storage-access=(self)"
  assert pp.to_string(pp.Policy([pp.Summarizer(pp.Origins([pp.Self]))]))
    == "summarizer=(self)"
  assert pp.to_string(pp.Policy([pp.Translator(pp.Origins([pp.Self]))]))
    == "translator=(self)"
  assert pp.to_string(pp.Policy([pp.Usb(pp.Origins([pp.Self]))]))
    == "usb=(self)"
  assert pp.to_string(pp.Policy([pp.WebShare(pp.Origins([pp.Self]))]))
    == "web-share=(self)"
  assert pp.to_string(pp.Policy([pp.WindowManagement(pp.Origins([pp.Self]))]))
    == "window-management=(self)"
  assert pp.to_string(pp.Policy([pp.XrSpatialTracking(pp.Origins([pp.Self]))]))
    == "xr-spatial-tracking=(self)"
}

pub fn allowlist_to_header_test() {
  assert pp.to_string(pp.Policy([pp.Camera(pp.Wildcard)])) == "camera=*"
  assert pp.to_string(pp.Policy([pp.Camera(pp.Origins([]))])) == "camera=()"
  assert pp.to_string(pp.Policy([pp.Camera(pp.Origins([pp.Self]))]))
    == "camera=(self)"
  assert pp.to_string(pp.Policy([pp.Camera(pp.Origins([pp.Src]))]))
    == "camera=(src)"
  assert pp.to_string(
      pp.Policy([pp.Camera(pp.Origins([pp.Url("https://example.com")]))]),
    )
    == "camera=(\"https://example.com\")"
  assert pp.to_string(
      pp.Policy([
        pp.Camera(pp.Origins([pp.Self, pp.Url("https://example.com")])),
      ]),
    )
    == "camera=(self \"https://example.com\")"
}
