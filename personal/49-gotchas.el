;; Allow pasting selection outside of Emacs
(setq x-select-enable-clipboard t)

(setq kill-whole-line t)

(setq prelude-auto-save t
      prelude-guru nil
      prelude-whitespace t
      prelude-flyspell nil
      flycheck-mode -1
      )

;; apib-mode
(autoload 'apib-mode "apib-mode" nil t)

;; dired
(with-eval-after-load 'dired
  (put 'dired-find-alternate-file 'disabled nil)
  (when (executable-find "gls")
    (setq insert-directory-program "gls"))
  (load-library "ls-lisp")
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
  (define-key dired-mode-map (kbd "K") 'dired-k)
  (define-key dired-mode-map (kbd "Q") 'quick-preview-at-point)
  (define-key dired-mode-map (kbd "C-l") 'dired-up-directory)
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode))

(custom-set-variables
 '(ls-lisp-dirs-first t)
 '(dired-dwim-target t)
 '(dired-auto-revert-buffer t)
 '(dired-recursive-copies 'always)
 '(dired-recursive-deletes 'always))

;; projectile
(add-to-list 'projectile-globally-ignored-directories "vendor")
(add-to-list 'projectile-globally-ignored-directories "cache")
(add-to-list 'projectile-globally-ignored-directories "tmp")
(add-to-list 'projectile-globally-ignored-directories ".git")
(add-to-list 'projectile-globally-ignored-directories ".hg")

;; for yasnippet
(setq require-final-newline nil)

;; company-mode
(global-set-key (kbd "C-l") 'company-complete)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(define-key company-active-map (kbd "TAB") 'company-complete-selection)
;;(define-key emacs-lisp-mode-map (kbd "C-l") 'company-complete)

;; cua-mode
(cua-mode t)
(setq cua-enable-cua-keys nil) ; 不都合なキーバインドを無効化

;; markdown
;; from http://support.markedapp.com/kb/how-to-tips-and-tricks/marked-bonus-pack-scripts-commands-and-bundles
(defun markdown-preview-file ()
  "run Marked on the current file and revert the buffer"
  (interactive)
  (shell-command (format "open -a /Applications/Marked.app %s" (shell-quote-argument (buffer-file-name)))))

(when (require 'markdown-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.md$" . gfm-mode))
  (add-hook 'markdown-mode-hook
            (lambda ()
              (define-key markdown-mode-map (kbd "C-i") 'markdown-cycle)
              (define-key markdown-mode-map (kbd "C-c m") 'markdown-preview-file))
              (hide-sublevels 2)
              (setq tab-width 2)))

;; coffee-mode
(autoload 'coffee-mode "coffee-mode" "Major mode for editing CoffeeScript." t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-hook 'coffee-mode-hook
  (lambda ()
    (setq coffee-tab-width 2)
    (setq coffee-args-compile '("-c" "--bare"))
    (setq whitespace-action '(auto-cleanup)) ;; automatically clean up bad whitespace
    (setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab)) ;; only show bad whitespace
    (define-key coffee-mode-map (kbd "C-c C-k") 'coffee-compile-file)
    (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)))


;; js2-mode
(when (require 'js2-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
  (add-hook 'js2-mode-hook
            (lambda ()
              (setq js2-basic-offset 2)
              (define-key js2-mode-map (kbd "C-j") 'js2-line-break)
              )))

;; yagist
(when (require 'yagist nil t)
  (setq yagist-encrypt-risky-config t)
  (setq yagist-authenticate-function 'yagist-oauth2-authentication)
  (define-key yagist-list-mode-map "g" nil)
  ;(setq revert-buffer-function 'revert-buffer) ;; 他modeのbufferであってもyagistのrevert-bufferに取られてしまう
  )

;; popwin
(when (require 'popwin nil t)
  (setq display-buffer-function 'popwin:display-buffer)
  (popwin-mode 1)
  (push '("*Help*" :stick t :noselect t) popwin:special-display-config)
  (push '("*helm prelude*" :height 25) popwin:special-display-config)
  ;(push '(inf-ruby-mode :stick t :height 20) popwin:special-display-config)
  (push '(direx:direx-mode :position left :width 40 :dedicated t) popwin:special-display-config)
  (push '("^\*go-direx:" :position left :width 0.3 :dedicated t :stick t :regexp t) popwin:special-display-config)
  (push '(flycheck-error-list-mode) popwin:special-display-config)
  )

;; neotree
(when (require 'neotree nil t)
  (global-set-key [f8] 'neotree-toggle)
  (setq neo-smart-open t)
  (setq neo-show-hidden-files t)
  (setq neo-create-file-auto-open t)
  (setq neo-persist-show t)
  (setq neo-keymap-style 'concise)
  (setq neo-vc-integration '(face char))
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (when neo-persist-show
    (add-hook 'popwin:before-popup-hook
              (lambda () (setq neo-persist-show nil)))
    (add-hook 'popwin:after-popup-hook
              (lambda () (setq neo-persist-show t))))
  )

;; ido-vertical-mode
(when (require 'ido-vertical-mode nil t)
  (ido-vertical-mode t)
  (add-hook 'ido-setup-hook
            (lambda ()
              ;; overwrite the key bindings for ido vertical mode only
              (define-key ido-completion-map (kbd "C-<return>") 'ido-select-text)
              ;; use M-RET in terminal
              (define-key ido-completion-map "\M-\r" 'ido-select-text)
              (define-key ido-completion-map (kbd "C-h") 'ido-delete-backward-updir)
              (define-key ido-completion-map (kbd "C-l") 'ido-exit-minibuffer)
              (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
              (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)
              (define-key ido-completion-map (kbd "M-h") 'ido-prev-match-dir)
              (define-key ido-completion-map (kbd "M-l") 'ido-next-match-dir)
              (define-key ido-completion-map (kbd "M-n") 'next-history-element)
              (define-key ido-completion-map (kbd "M-p") 'previous-history-element)
              ;; more natural navigation keys: up, down to change current item
              ;; left to go up dir
              ;; right to open the selected item
              (define-key ido-completion-map (kbd "<up>") 'ido-prev-match)
              (define-key ido-completion-map (kbd "<down>") 'ido-next-match)
              (define-key ido-completion-map (kbd "<left>") 'ido-delete-backward-updir)
              (define-key ido-completion-map (kbd "<right>") 'ido-exit-minibuffer)
              ))
  )

;; direx
;; (when (require 'direx nil t)
;;   ;; :dedicatedにtを指定することで、direxウィンドウ内でのバッファの切り替えが
;;   ;; ポップアップ前のウィンドウに移譲される
;;   (push '(direx:direx-mode :position left :width 50 :dedicated t)
;;         popwin:special-display-config)
;;   (global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)
;;   (setq direx:leaf-icon "  "
;;         direx:open-icon "▾ "
;;         direx:closed-icon "▸ ")
;;   )

;; project-explorer
(when (require 'project-explorer nil t)
  (global-set-key (kbd "C-x C-d") 'project-explorer-helm)
  )

;; js2-mode
(when (require 'js2-mode nil t)
  (setq coffee-js-mode 'js2-mode)
  (add-to-list 'auto-mode-alist '("\\.js$'" . js2-mode))
  )

(add-hook 'prelude-prog-mode-hook
          (lambda () (flycheck-mode -1)))

;; open-junk-file
(when (require 'open-junk-file nil t)
  (setq junk-file-dir
        (concat (file-name-as-directory (or (getenv "DROPBOX") "~/Dropbox"))
                "Logs"))
  (setq open-junk-file-format
        (concat junk-file-dir "/%Y/%Y-%m-%d-%H%M%S."))
  )

;; git-gutter
(global-git-gutter-mode +1)
(global-set-key (kbd "C-x v u") 'git-gutter)
(global-set-key (kbd "C-x v p") 'git-gutter:stage-hunk)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)
(custom-set-variables
 '(git-gutter:modified-sign " ")
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:lighter " GG"))
(add-hook 'focus-in-hook 'git-gutter:update-all-windows)

(set-face-background 'git-gutter:modified "purple")
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

(with-eval-after-load 'vc '(remove-hook 'find-file-hooks 'vc-find-file-hook))

(global-set-key (kbd "M-g M-g") 'magit-status)
(defun my/magit-status-around (orig-fn &rest args)
  (window-configuration-to-register :magit-fullscreen)
  (apply orig-fn args)
  (delete-other-windows))
(defun my/magit-quit-session ()
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen)
  (git-gutter:update-all-windows))
(defun my/git-commit-commit-after (_unused)
  (delete-window))
(defun my/git-commit-mode-hook ()
  (flyspell-mode +1))

(with-eval-after-load 'magit
  (global-git-commit-mode +1)
  (advice-add 'magit-status :around 'my/magit-status-around)
  (define-key magit-status-mode-map (kbd "q") 'my/magit-quit-session))
(with-eval-after-load 'git-commit
  (add-hook 'git-commit-mode-hook 'my/git-commit-mode-hook)
  (advice-add 'git-commit-commit :after 'my/git-commit-commit-after))

;; go-mode
(eval-after-load "go-mode"
  '(progn
     (require 'go-autocomplete)
     (add-hook 'go-mode-hook
               (lambda()
                 (setq tab-width 4)
                 (setq compile-command "go test -v")
                 (go-eldoc-setup)
                 (add-hook 'before-save-hook 'gofmt-before-save)))
     (define-key go-mode-map (kbd "M-.") 'godef-jump)
     (define-key go-mode-map (kbd "M-,") 'pop-tag-mark)))
(defvar my/helm-go-source
  '((name . "Helm Go")
    (candidates . (lambda ()
                    (cons "builtin" (go-packages))))
    (action . (("Show document" . godoc)
               ("Import package" . my/helm-go-import-add)))))
(defun my/helm-go-import-add (candidate)
  (dolist (package (helm-marked-candidates))
    (go-import-add current-prefix-arg package)))
(defun my/helm-go ()
  (interactive)
  (helm :sources '(my/helm-go-source) :buffer "*helm go*"))

;; which-key
(which-key-mode +1)
(which-key-setup-minibuffer)
(setq which-key-idle-delay 0.5)
