(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c C-c")
  :custom
  (lsp-log-io nil) ; ensure this is off when not debugging
  (lsp-eldoc-render-all t)
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))
(use-package lsp-ui
  :commands lsp-ui-mode)
