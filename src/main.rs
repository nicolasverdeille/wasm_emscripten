use std::ffi::{c_char, CStr, CString};
static COIN: &CStr = unsafe { CStr::from_bytes_with_nul_unchecked(b"Vive les petits canards\0") };

extern "C" {
    pub fn canard(s: *const c_char);
}

#[no_mangle]
pub extern "C" fn add(left: usize, right: usize) -> usize {
    left + right
}

#[no_mangle]
pub extern "C" fn coin() -> *const c_char {
    let s = CString::new("Vive les canards!").expect("CString::new failed");
    unsafe { canard(s.as_ptr()) }
    COIN.as_ptr()
}

pub fn main() {
}
