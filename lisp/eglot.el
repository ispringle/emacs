(use-package eglot
  :ensure nil
  :after (corfu cape orderless)
  :defer t
  :hook ((js-ts-mode . eglot-ensure)
         (typescript-ts-mode. eglot-ensure))
  :init
  (setq completion-category-overrides '((eglot (styles orderless))))
  (advice-add 'eglot-completion-at-point :around #'cape-wrap-buster)
  :custom
  (eglot-send-change-idle-time 0.1)
  (eglot-autoshutdown t)
  (eglot-extend-to-xref t)
  (eglot-ignored-server-capabilities
   '(:documentHighlightProvider
     :documentFormattingProvider
     :documentRangeFormattingProvider
     :documentOnTypeFormattingProvider
     :colorProvider))
  (eglot-workspace-configuration
   '(:typescript-language-server
     (:plugins [
  		((:name "ts-lit-Plugin")
  		 (:location "/Users/IPringle/.asdf/installs/nodejs/18.17.0/lib/node_modules/ts-lit-plugin/"))
  		((:name "typescript-lit-html-plugin")
  		 (:location "/Users/IPringle/.asdf/installs/nodejs/18.17.0/lib/node_modules/typescript-lit-html-plugin/"))
  		])))
  :config
  (fset #'jsonrpc--log-event #'ignore)

  
  (add-to-list 'eglot-server-programs
               '(astro-ts-mode . ("astro-ls" "--stdio")))
  (add-to-list 'eglot-server-programs
               (cl-substitute-if
                (cons
                 '(js-mode js-ts-mode
                           tsx-ts-mode typescript-ts-mode typescript-mode)
                 '("typescript-language-server" "--stdio" :initializationOptions
                   (:preferences
                    (
                     ;; https://github.com/microsoft/TypeScript/blob/main/src/server/protocol.ts#L3410-L3539
                     :disableSuggestions                                    :json-false     ;; boolean
                     :quotePreference                                       "double"        ;; "auto" | "double" | "single"
                     :includeCompletionsForModuleExports                    t               ;; boolean
                     :includeCompletionsForImportStatements                 t               ;; boolean
                     :includeCompletionsWithSnippetText                     t               ;; boolean
                     :includeCompletionsWithInsertText                      t               ;; boolean
                     :includeAutomaticOptionalChainCompletions              t               ;; boolean
                     :includeCompletionsWithClassMemberSnippets             t               ;; boolean
                     :includeCompletionsWithObjectLiteralMethodSnippets     t               ;; boolean
                     :useLabelDetailsInCompletionEntries                    t               ;; boolean
                     :allowIncompleteCompletions                            t               ;; boolean
                     :importModuleSpecifierPreference                       "shortest"      ;; "shortest" | "project-relative" | "relative" | "non-relative"
                     :importModuleSpecifierEnding                           "minimal"       ;; "auto" | "minimal" | "index" | "js"
                     :allowTextChangesInNewFiles                            t               ;; boolean
                     :providePrefixAndSuffixTextForRename                   t               ;; boolean
                     :provideRefactorNotApplicableReason                    :json-false     ;; boolean
                     :allowRenameOfImportPath                               t               ;; boolean
                     :jsxAttributeCompletionStyle                           "auto"          ;; "auto" | "braces" | "none"
                     :displayPartsForJSDoc                                  t               ;; boolean
                     :generateReturnInDocTemplate                           t               ;; boolean
                     :includeInlayParameterNameHints                        "all"           ;; "none" | "literals" | "all"
                     :includeInlayParameterNameHintsWhenArgumentMatchesName t               ;; boolean
                     :includeInlayFunctionParameterTypeHints                t               ;; boolean,
                     :includeInlayVariableTypeHints                         t               ;; boolean
                     :includeInlayVariableTypeHintsWhenTypeMatchesName      t               ;; boolean
                     :includeInlayPropertyDeclarationTypeHints              t               ;; boolean
                     :includeInlayFunctionLikeReturnTypeHints               t               ;; boolean
                     :includeInlayEnumMemberValueHints                      t               ;; boolean
                     :disableLineTextInReferences                           :json-false     ;; boolean
                     ))))
                (lambda (server-program)
                  (and
                   (listp (car server-program))
                   (member 'tsx-ts-mode (car server-program))))
                eglot-server-programs))

  (defun /typescript-ts-base-mode-hook-function ()
    (add-hook 'before-save-hook #'/eglot-organize-imports nil t))
  (add-hook 'typescript-ts-base-mode-hook #'/typescript-ts-base-mode-hook-function)

  (defun /eglot-organize-imports ()
    (interactive)
    (if (derived-mode-p major-mode #'typescript-ts-base-mode)
        (seq-do
         (lambda (kind) (interactive)
           (ignore-errors
             (eglot-code-actions (buffer-end 0) (buffer-end 1) kind t)))
         ;; https://github.com/typescript-language-server/typescript-language-server#code-actions-on-save
         (list
          "source.addMissingImports.ts"
          "source.fixAll.ts"
          "source.addMissingImports.ts"
          "source.removeUnusedImports.ts"))
      (funcall-interactively #'eglot-code-action-organize-imports))))
