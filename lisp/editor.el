;;; Stuff related to editing files
(use-package emacs
  :ensure nil
  :config
  (delete-selection-mode)
  (electric-pair-mode 1)
  (setq electric-pair-pairs '((?\" . ?\")
                              (?\{ . ?\})
                              (?\< . ?\>)))
  (column-number-mode 1)
  (global-display-line-numbers-mode 1)
  (setq line-number-mode t
        column-number-mode t)
  (dolist (mode '(org-mode-hook
                  term-mode-hook
                  eshell-mode-hook))
    (add-hook mode (lambda () (display-line-numbers-mode 0)))))

(use-package change-inner
  :general
  ("C-c i" '(change-inner :wk "Change inside surround")
   "C-c o" '(change-outer :wk "Delete surround")))

(use-package crux
  :general
  ("C-k" 'crux-smart-kill-line)
  ("C-RET" 'crux-smart-open-line-above)
  ("S-RET" 'crux-smart-open-line)
  ("C-c TAB" 'crux-cleanup-buffer-or-region)
  ("C-c D" 'crux-delete-file-and-buffer)
  ("C-c d" 'crux-duplicate-current-line-or-region)
  ("C-c M-d" 'crux-duplicate-and-comment-current-line-or-region))

(use-package easy-kill
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill)
  (global-set-key [remap mark-sexp] 'easy-mark))

(use-package expand-region
  :commands expand-region
  :general
  ("C-," 'er/expand-region))


;; idk if I should go with https://github.com/Fuco1/smartparens or https://github.com/cute-jumper/embrace.el
(use-package smartparens
  :ensure
  :hook (prog-mode text-mode markdown-mode)
  :config
  (require 'smartparens-config))

(use-package embrace
  :general
  ("C-c s" '(embrace-commander :wk "Embrace")
   "C-c C-s a" '(embrace-add :wk "Add surround")
   "C-c C-s d" '(embrace-delete :wk "Delete surround")
   "C-c C-s c" '(embrace-change :wk "Change surround")))

(use-package evil-nerd-commenter
  :general
  ("M-;" 'evilnc-comment-or-uncomment-lines))
