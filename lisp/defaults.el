(setq-default
 ad-redefinition-action 'accept         ; Silence warnings for redefinitions
 auto-save-list-file-prefix nil         ; Prevent tracking for auto-saves
 backup-by-copying t                    ; Backups never overwrite original
 comment-multi-line t                   ; Continue comments when filling
 create-lockfiles nil                   ; Locks are more nuisance than blessing
 cursor-in-non-selected-windows nil     ; Hide the cursor in inactive windows
 custom-file null-device                ; Prevent littering
 custom-unlispify-menu-entries nil      ; Prefer kebab-case for titles
 custom-unlispify-tag-names nil         ; Prefer kebab-case for symbols
 delete-by-moving-to-trash t            ; Delete files to trash
 delete-old-versions t                  ; Delete extra backups silently
 epg-pinentry-mode 'loopback            ; Redirect passphrase prompts to self
 fill-column 80                         ; Set width for automatic line breaks
 gc-cons-threshold (* 8 1024 1024)      ; We're not using Game Boys anymore
 help-window-select t                   ; Focus new help windows when opened
 indent-tabs-mode nil                   ; Prefer spaces over tabs to indent
 inhibit-startup-screen t               ; Disable start-up screen
 initial-buffer-choice t                ; Make *scratch* the initial buffer
 initial-scratch-message ""             ; Empty the initial *scratch* buffer
 isearch-allow-scroll t                 ; Allow scroll commands while isearching
 isearch-lazy-count t                   ; Display match count while searching
 lazy-highlight-buffer t                ; Highlight the entire buffer
 ;; TODO Clean up highlights after replace operations
 lazy-highlight-cleanup nil             ; Keep isearch highlights around
 lazy-highlight-initial-delay 0         ; Remove highlight delay
 max-mini-window-height 10              ; Limit height for minibuffer transients
 native-comp-async-report-warnings-errors 'silent ; Skip error buffers
 read-process-output-max (* 1024 1024)  ; Increase read size for data chunks
 recenter-positions '(5 bottom)         ; Set re-centering positions
 ring-bell-function 'ignore             ; Silence error bells
 scroll-conservatively 101              ; Avoid recentering when scrolling far
 scroll-margin 1                        ; Add a margin when scrolling vertically
 select-enable-clipboard t              ; Merge system's and Emacs' clipboard
 sentence-end-double-space nil          ; Use a single space after dots
 show-help-function nil                 ; Disable help text everywhere
 tab-always-indent 'complete            ; Indent first then try completions
 uniquify-buffer-name-style 'forward    ; Uniquify buffer names
 use-short-answers t                    ; Replace yes/no prompts with y/n
 vc-follow-symlinks t                   ; Never prompt when visiting symlinks
 version-control t                      ; Use numeric versions for backups
 window-combination-resize t            ; Resize windows proportionally
 x-stretch-cursor t)                    ; Stretch cursor to the glyph width
