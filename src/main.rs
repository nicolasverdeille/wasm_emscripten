use std::ffi::{c_char, CStr};
static COIN: &CStr = unsafe { CStr::from_bytes_with_nul_unchecked(b"Vive les petits canards\0") };

#[no_mangle]
pub extern "C" fn add(left: usize, right: usize) -> usize {
    left + right
}

#[no_mangle]
pub extern "C" fn coin() -> *const c_char {
    COIN.as_ptr()
}

pub fn main() {
}
