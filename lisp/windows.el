;;; For window management and such

(use-package ace-window
  :general
  ("C-x o" 'ace-window)
  ("M-o" 'ace-window)
  :config
  (setq aw-scope 'frame
        aw-ignore-current t
        aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?\;))
  (defun isp--set-other-window-scroll-buffer (window)
    "Set buffer in window to other-window-scroll-buffer"
    (setq other-window-scroll-buffer (window-buffer window)))
  (push '( ; With this you can C-x o r <window> to control other window's scrolling
          ?r isp--set-other-window-scroll-buffer
             "Set other-window-scroll-buffer")
        aw-dispatch-alist))
