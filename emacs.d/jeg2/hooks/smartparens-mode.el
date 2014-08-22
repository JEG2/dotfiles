;; don't pair Rust lifetimes or apostrophes
(sp-pair "'" nil :unless '(jeg2/sp-in-rust-mode sp-point-after-word-p))
