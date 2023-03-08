# Compilation
cargo build --target wasm32-unknown-emscripten
cp target/wasm32-unknown-emscripten/debug/wasm{-emscripten.js,_emscripten.wasm} html/
