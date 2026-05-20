import plume/dns_prefetch_control as dpc

pub fn to_header_test() {
  assert dpc.to_string(dpc.On) == "on"
  assert dpc.to_string(dpc.Off) == "off"
}
