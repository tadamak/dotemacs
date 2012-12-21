;; Allow pasting selection outside of Emacs
(setq x-select-enable-clipboard t)

(setq kill-whole-line t)

;; turn off flyspell-mode
(remove-hook 'message-mode-hook 'flyspell-mode)
(remove-hook 'text-mode-hook 'flyspell-mode)

;; projectile
(add-to-list 'projectile-globally-ignored-directories "bundle")
(add-to-list 'projectile-globally-ignored-directories ".bundle")
(add-to-list 'projectile-globally-ignored-directories "cache")
(add-to-list 'projectile-globally-ignored-directories "tmp")

;; for yasnippet
(setq require-final-newline nil)

;; cua-mode
(cua-mode t)
(setq cua-enable-cua-keys nil) ; 不都合なキーバインドを無効化

;; markdown
(add-hook 'markdown-mode-hook
  (lambda()
    (define-key markdown-mode-map (kbd "C-i") 'markdown-cycle)
    (hide-sublevels 2)))

;; coffee-mode
(autoload 'coffee-mode "coffee-mode" "Major mode for editing CoffeeScript." t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-hook 'coffee-mode-hook
  (lambda()
    (setq (make-local-variable 'tab-width) 2)
    (setq coffee-tab-width 2)
    (setq whitespace-action '(auto-cleanup)) ;; automatically clean up bad whitespace
    (setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab)) ;; only show bad whitespace
    ))

;; flymake
(set-face-foreground 'flymake-errline "tomato")
(set-face-background 'flymake-errline nil)
