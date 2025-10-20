(use-package which-key
  :demand t
  :config
  (which-key-mode)
  :custom
  (which-key-side-window-location 'bottom)
  (which-key-sort-order 'which-key-key-order-alpha)
  ;;(which-key-idle-delay 0.1/)
  :diminish which-key-mode)
(elpaca-wait)
