;; Allow pasting selection outside of Emacs
(setq x-select-enable-clipboard t)

(setq kill-whole-line t)

(setq prelude-auto-save t
      prelude-guru nil
      prelude-whitespace t
      prelude-flyspell nil
      flycheck-mode -1
      )

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
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
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
            (lambda()
              (define-key markdown-mode-map (kbd "C-i") 'markdown-cycle)
              (hide-sublevels 2)
              (setq tab-width 2)
              (define-key markdown-mode-map (kbd "C-c m") 'markdown-preview-file))
            ))

;; coffee-mode
(autoload 'coffee-mode "coffee-mode" "Major mode for editing CoffeeScript." t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-hook 'coffee-mode-hook
  (lambda()
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
            (lambda()
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
  (push '("*helm prelude*" :height 25) popwin:special-display-config)
  )

;; direx
(when (require 'direx nil t)
  ;; :dedicatedにtを指定することで、direxウィンドウ内でのバッファの切り替えが
  ;; ポップアップ前のウィンドウに移譲される
  (push '(direx:direx-mode :position left :width 50 :dedicated t)
        popwin:special-display-config)
  (global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)
  (setq direx:leaf-icon "  "
        direx:open-icon "▾ "
        direx:closed-icon "▸ ")
  )

;; guide-key
(when (require 'guide-key nil t)
  (setq guide-key/guide-key-sequence '(
    "C-x r" ;; rectongle
    "C-c r" ;; projectile-rails
  ))
  (guide-key-mode 1))

;; project-explorer
(when (require 'project-explorer nil t)
  (global-set-key (kbd "C-x C-d") 'project-explorer-helm)
  )

;; open-junk-file
(when (require 'open-junk-file nil t)
  (global-set-key (kbd "C-x j") 'open-junk-file)
  (setq open-junk-file-format
        (concat (file-name-as-directory (or (getenv "DROPBOX") "~/Dropbox"))
                "Logs/%Y/%Y-%m-%d-%H%M%S.")
        ))

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
(custom-set-variables
 '(git-gutter:modified-sign " ")
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:lighter " GG"))

(set-face-background 'git-gutter:modified "purple")
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

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

;; ;; neotree
;; (when (require 'neotree nil t)
;;   (global-set-key [f8] 'neotree-toggle)
;;   (setq projectile-switch-project-action 'neotree-projectile-action)
;;   (setq neo-theme 'nerd
;;         neo-smart-open t
;;         neo-show-hidden-files t
;;         neo-window-width 40
;;         neo-cwd-line-style 'button
;;         neo-auto-indent-point t)
;;   (when neo-persist-show
;;     (add-hook 'popwin:before-popup-hook
;;               (lambda () (setq neo-persist-show nil)))
;;     (add-hook 'popwin:after-popup-hook
;;               (lambda () (setq neo-persist-show t)))
;;     ))
