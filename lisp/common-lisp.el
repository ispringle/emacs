(use-package sly
  :defer
  :init
  (setq inferior-lisp-program "sbcl")
  :config
  (setq sly-lisp-implementations
        '((sbcl ("sbcl") :coding-system utf-8-unix)
          (qlot ("qlot" "exec" "sbcl") :coding-system utf-8-unix))))

(use-package sly-overlay
  :bind (:map sly-mode-map
              ("C-M-x" . sly-overlay-eval-defun)))

(use-package sly-asdf
  :init
  (add-to-list 'sly-contribs 'sly-asdf 'append))

(use-package sly-quicklisp)

(use-package sly-macrostep)

(use-package sly-repl-ansi-color
  :init
  (add-to-list 'sly-contribs 'sly-repl-ansi-color 'append))
