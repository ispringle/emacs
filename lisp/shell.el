(use-package eshell
  :ensure nil
  :config
  (setq eshell-scroll-to-bottom-on-input t
        eshell-history-size 10000
        eshell-save-history-on-exit t
        eshell-hist-ignoredups nil)
  (defun isp/eshell-hook ()
    (interactive)
    (setq-local completion-styles '(basic partial-completion)
                corfu-auto t)
    (corfu-mode)
    (setq-local completion-at-point-functions
                (list (cape-capf-super
                       #'pcomplete-completions-at-point
                       #'cape-history)))))

(use-package capf-autosuggest
  :hook (eshell-mode . capf-autosuggest-mode))
