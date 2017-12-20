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

;; helm-gtags

(custom-set-variables
 '(helm-gtags-path-style 'relative)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-auto-update t)
 '(helm-gtags-prefix-key "\C-t")
 '(helm-gtags-suggested-key-mapping t))
(with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
  (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
  (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
  (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack))

(defun update-gtags (&optional prefix)
  (interactive "P")
  (when (eq major-mode 'ruby-mode)
    (let ((rootdir (gtags-get-rootpath))
          (args (if prefix "-v" "-iv")))
      (when rootdir
        (let* ((default-directory rootdir)
               (buffer (get-buffer-create "*update GTAGS*")))
          (save-excursion
            (set-buffer buffer)
            (erase-buffer)
            (let ((result (shell-command "/usr/local/bin/gtags --gtagslabel=pygments")))
              (if (= 0 result)
                  (message "GTAGS successfully updated.")
                (message "update GTAGS error with exit status %d" result)))))))))

(add-hook 'ruby-mode-hook
          (lambda ()
            (helm-gtags-mode)
            (add-hook 'after-save-hook 'update-gtags)
            ))
