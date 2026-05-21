import plume/referrer_policy as rp

pub fn to_header_test() {
  assert rp.to_string(rp.NoReferrer) == "no-referrer"
  assert rp.to_string(rp.NoReferrerWhenDowngrade) == "no-referrer-when-downgrade"
  assert rp.to_string(rp.Origin) == "origin"
  assert rp.to_string(rp.OriginWhenCrossOrigin) == "origin-when-cross-origin"
  assert rp.to_string(rp.SameOrigin) == "same-origin"
  assert rp.to_string(rp.StrictOrigin) == "strict-origin"
  assert rp.to_string(rp.StrictOriginWhenCrossOrigin)
    == "strict-origin-when-cross-origin"
  assert rp.to_string(rp.UnsafeUrl) == "unsafe-url"
}
