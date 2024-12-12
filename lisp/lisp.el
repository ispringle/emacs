(use-package lispy
  :init
  (defun conditionally-enable-lispy ()
    (when (eq this-command 'eval-expression)
      (lispy-mode 1)))
  :hook
  ((lisp-mode . lispy-mode)
   (elisp-mode . lispy-mode)
   (minibuffer-setup . conditionally-enable-lispy)))
