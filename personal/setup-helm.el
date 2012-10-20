
(global-set-key (kbd "M-h") 'helm-prelude)

;; helm-c-yasnippet
(require 'helm-c-yasnippet)
(setq helm-c-yas-space-match-any-greedy t) ;[default: nil]
(global-set-key (kbd "C-c y") 'helm-c-yas-complete)
