;;; For completion stuff
;; idk if this will get broken out but now I'm throwing a lot in here...

(use-package corfu
  :ensure (corfu :files (:defaults "extensions/*")
		 :inclues (corfu-history
			   corfu-popupinfo))
  :defer 5
  :custom
  (corfu-auto nil)
  (corfu-auto-delay 0.1)
  (corfu-cycle t)
  (corfu-excluded-modes '(erc-mode
			  circe-mode
			  help-mode
			  gud-mode))
  (corfu-separator ?\s)
  (corfu-preview-current 'insert)
  (corfu-on-exact-match nil)
  (corfu-quit-on-boundary nil)
  (corfu-quit-no-match 'separator t)
  :config
  (defun corfu-enable-always-in-minibuffer ()
    "Enable Corfu in the minibuffer if Vertico/Mct are not active."
    (unless (or (bound-and-true-p mct--active)
		(bound-and-true-p vertico--input)
		(eq (current-local-map) read-passwd-map))
      ;; (setq-local corfu-auto nil) ;; Enable/disable auto completion
      (setq-local corfu-echo-delay nil ;; Disable automatic echo and popup
                  corfu-popupinfo-delay nil)
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1)
  (corfu-history-mode)
  (add-to-list 'savehist-additional-variables 'corfu-history)
  (add-hook 'corfu-mode #'corfu-popupinfo-mode)
  (global-corfu-mode 1))

(use-package corfu-candidate-overlay
  :ensure (:type git
                 :repo "https://code.bsdgeek.org/adam/corfu-candidate-overlay"
                 :files (:defaults "*.el"))
  :after corfu
  :config
  (corfu-candidate-overlay-mode +1)
  :general
  ("S-<tab>" 'corfu-complete))

(use-package consult
  :demand
  :init
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)  
  (setq consult-preview-key "C-l")
  (setq consult-narrow-key "<"
        consult-widen-key ">")
  :general
  ("C-c M-x" 'consult-mode-command)
  :config
  (global-set-key [remap imenu] 'consult-imenu)
  (global-set-key [remap switch-to-buffer] 'consult-buffer)
  (global-set-key [remap goto-line] 'consult-goto-line)
  (consult-customize consult-theme
                     :preview-key
                     '("M-."
                       :debounce 0.5 "<up>" "<down>"
                       :debounce 1 any)))

(use-package consult-dir
  :ensure t
  :bind (("C-x C-d" . consult-dir)
         :map vertico-map
         ("C-x C-d" . consult-dir)
         ("C-x C-j" . consult-dir-jump-file)))

;; look into 'flat' mode which might be nicer. Also maybe look at prot's mct as an alternative.
(use-package vertico
  :ensure (vertico :files (:defaults "extensions/*"))
  :custom
  (vertico-count 13)
  (vertico-resize t)
  (vertico-cycle t)
  (vertico-multiform-categories '((embark-keybinding grid)))
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("S-DEL" . vertico-directory-delete-word))
  :hook
  ('rfn-eshadow-update-overlay #'vertico-directory-tidy)
  :init
  (vertico-mode))

;; embark doesn't go here at all, but it's here for now...
(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)
   ("M-." . embark-dwim)
   ("C-h B" . embark-bindings))
  :custom
  (prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\'\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . embark-consult-preview-minor-mode))

(use-package marginalia
  :bind
  (:map minibuffer-local-map
	("M-A" . 'marginalia-cycle))
  :custom
  (marginalia-max-relative-age 0)
  (marginalia-align 'right)
  :init
  (marginalia-mode))

(use-package orderless
  :demand t
  :config
  (defun +orderless--consult-suffix ()
    "Regexp which matches the end of string with Consult tofu support."
    (if (and (boundp 'consult--tofu-char) (boundp 'consult--tofu-range))
        (format "[%c-%c]*$"
      	        consult--tofu-char
      	        (+ consult--tofu-char consult--tofu-range -1))
      "$"))

  (defun +orderless-consult-dispatch (word _index _total)
    (cond
     ((string-suffix-p "$" word)
      `(orderless-regexp . ,(concat (substring word 0 -1) (+orderless--consult-suffix))))
     ((and (or minibuffer-completing-file-name
      	       (derived-mode-p 'eshell-mode))
           (string-match-p "\\`\\.." word))
      `(orderless-regexp . ,(concat "\\." (substring word 1) (+orderless--consult-suffix))))))

  (orderless-define-completion-style +orderless-with-initialism
    (orderless-matching-styles '(orderless-initialism orderless-literal orderless-regexp)))

  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion))
      				        (command (styles +orderless-with-initialism))
      				        (variable (styles +orderless-with-initialism))
      				        (symbol (styles +orderless-with-initialism)))
        orderless-component-separator #'orderless-escapable-split-on-space
        orderless-style-dispatchers (list #'+orderless-consult-dispatch
      				          #'orderless-affix-dispatch)))
