pub type DnsPrefetchControl {
  On
  Off
}

pub fn to_string(value: DnsPrefetchControl) -> String {
  case value {
    On -> "on"
    Off -> "off"
  }
}
