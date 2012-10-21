;; Allow pasting selection outside of Emacs
(setq x-select-enable-clipboard t)

;; turn off flyspell-mode
(remove-hook 'message-mode-hook 'flyspell-mode)
(remove-hook 'text-mode-hook 'flyspell-mode)

;; projectile
(add-to-list 'projectile-globally-ignored-directories "bundle")
(add-to-list 'projectile-globally-ignored-directories "cache")
(add-to-list 'projectile-globally-ignored-directories "tmp")

;; for yasnippet
(setq require-final-newline nil)
