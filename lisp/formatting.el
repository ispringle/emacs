(use-package apheleia
  :defer t
  :custom
  (apheleia-mode-lighter nil)
  (js-indent-level 2)
  (standard-indent 2)
  :init
  (apheleia-global-mode 1)
  :general
  ("C-c f" 'apheleia-format-buffer))
