(use-package no-littering
  :demand t
  :config
  (setq no-littering-etc-directory (expand-file-name "~/.local/share/emacs/etc/")
        no-littering-var-directory (expand-file-name "~/.local/share/emacs/var/"))
  (with-eval-after-load 'recentf
    (add-to-list 'recentf-exclude no-littering-etc-directory)
    (add-to-list 'recentf-exclude no-littering-var-directory))
  (no-littering-theme-backups))
