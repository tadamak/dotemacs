(global-set-key (kbd "M-h") 'helm-projectile-find-file)
(global-set-key (kbd "C-c f") 'helm-projectile-find-file)
(global-set-key (kbd "C-x f") 'helm-find-files)
(global-set-key (kbd "C-q") 'helm-mini)
(global-set-key (kbd "C-x C-c") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "C-M-s") 'helm-occur)
(global-set-key (kbd "C-M-z") 'helm-resume)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-.") 'helm-c-etags-select)

;; helm-c-yasnippet
(when (require 'helm-c-yasnippet nil t)
  (setq helm-c-yas-space-match-any-greedy t) ;[default: nil]
  (global-set-key (kbd "M-'") 'helm-c-yas-complete))

;; helm-ag
(when (require 'helm-ag nil t)
  (setq helm-ag-base-command "ag --nocolor --nogroup --ignore-case"
        helm-ag-command-option "-U"
        helm-ag-thing-at-point 'symbol
        ))

;; ido
;(setq ido-max-window-height 20)
;(ido-vertical-mode)
