;; Allow pasting selection outside of Emacs
(setq x-select-enable-clipboard t)

;; turn off flyspell-mode
(remove-hook 'message-mode-hook 'prelude-turn-on-flyspell)
(remove-hook 'text-mode-hook 'prelude-turn-on-flyspell)
