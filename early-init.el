;; HACK: Work around for MacOS 
(setenv "LIBRARY_PATH"
  	(string-join
  	 '("/opt/homebrew/opt/gcc/lib/gcc/13"
  	   "/opt/homebrew/opt/libgccjit/lib/gcc/13"
  	   "/opt/homebrew/opt/gcc/lib/gcc/13/gcc/aarch64-apple-darwin23/13")
  	 ":"))

(setq gc-cons-threshold 10000000
      read-process-output-max (* 1024 1024 3)) ; 3mb 

;; Be a little quieter
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)
(setq inhibit-startup-echo-area-message (user-login-name))

;; Visual changes that we want done before first-paint to avoid flashing
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t
      default-frame-alist '((ns-transparent-titlebar . t)
                            (full-screen . maximized)
                            (vertical-scroll-bar . nil)
                            (horizontal-scroll-bar . nil))
      visual-bell t
      display-time-default-load-average nil)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)

;; Disable package.el, we're going to use Elpaca
(setq package-enable-at-startup nil
      package-quickstart nil)
