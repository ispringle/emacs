(defun gen-env-file (path)
  "Save envvars to a file at path"
  (let ((dirname (file-name-directory path)))
    (make-directory dirname t))
  (with-temp-file path
    (setq-local coding-system-to-write 'utf-8-unix)
    (insert
     ";; -*- mode: emacs-lisp -*-\n"
     ";; This file was automatically genereated and will be overwritten.\n")
    (insert (pp-to-string process-environment))))

(gen-env-file "~/.config/emacs/local/env.el")
