(use-package magit
  :defer t
  :config
  (transient-bind-q-to-quit))

;; This ensures we're using the latest version of seq and not the one bundled with
;; Emacs. This is important as some packages, like magit, want the dev version of
;; this built-in.
(defun fv--elpaca-unload-transient (e)
  (and (featurep 'transient) (unload-feature 'transient t))
  (elpaca--continue-build e))

(defun fv--elpaca-transient-build-steps ()
  (append (butlast (if (file-exists-p (expand-file-name "transient" elpaca-builds-directory))
                       elpaca--pre-built-steps elpaca-build-steps))
          (list 'fv--elpaca-unload-transient 'elpaca--activate-package)))

(use-package seq :ensure `(transient :build ,(fv--elpaca-transient-build-steps)))

;; I dislike the emacs provided vc to manage version-control. It locks stuff up. This disables it.
(with-eval-after-load 'vc
  (remove-hook 'find-file-hook 'vc-find-file-hook)
  (remove-hook 'find-file-hook 'vc-refresh-state))
(setq vc-hangled-backends nil)

;; This provides project.el with the needed function since we disabled it in vc.
(defun fv--find-dot-git (dir)
  "Find the .git project root"
  (let ((dgit (and (setq dir (locate-dominating-file dir ".git"))
                   (expand-file-name dir))))
    (and dgit
         (cons 'transient (file-name-directory dgit)))))
(add-hook 'project-find-functions 'fv--find-dot-git)
