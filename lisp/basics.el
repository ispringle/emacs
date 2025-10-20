;;; Basically this is just all that stuff that's too generic for it's own file or too boring.
(use-package amx
  :general
  ("M-x" 'amx)
  ("C-x C-m" 'amx-major-mode-command))

(use-package beacon
  :ensure t
  :custom
  (beacon-color "#fd7ae1")
  :config
  (beacon-mode 1))

(use-package delight
  :defer 10)

(use-package diminish
  :defer 10)

(use-package helpful
  :custom (elisp-refs-verbose nil)
  :bind
  (("M-g M-d" . 'helpful-at-point)
   ([remap describe-key] . helpful-key)
   ([remap describe-function] . helpful-callable)
   ([remap describe-command] . helpful-command)
   ([remap describe-variable] . helpful-variable)))

(use-package persistent-scratch
  :demand
  :config
  (persistent-scratch-setup-default))
