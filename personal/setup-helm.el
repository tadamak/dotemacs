(global-set-key (kbd "M-h") 'helm-prelude)
(global-set-key (kbd "C-x C-c") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "C-M-s") 'helm-occur)
(global-set-key (kbd "C-M-z") 'helm-resume)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-.") 'helm-c-etags-select)

;; helm-c-yasnippet
(require 'helm-c-yasnippet)
(setq helm-c-yas-space-match-any-greedy t) ;[default: nil]
(global-set-key (kbd "M-=") 'helm-c-yas-complete)
