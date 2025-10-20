(use-package pomm
  :commands (pomm pomm-third-time)
  :general
  ("<f5>" 'pomm)
  :config
  (setq pomm-audio-enabled t
        pomm-mode-line-mode 1))
