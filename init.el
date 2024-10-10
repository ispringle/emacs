(load (expand-file-name "elpaca.el" user-emacs-directory))

(message "Loading files.")

(mapc 'load
      (directory-files
       (expand-file-name "lisp" user-emacs-directory) 't "^[^#]*el$"))

(put 'narrow-to-region 'disabled nil)
