;; Allow pasting selection outside of Emacs
(setq x-select-enable-clipboard t)

(setq kill-whole-line t)

(setq prelude-auto-save t
      prelude-guru nil
      prelude-whitespace t
      prelude-flyspell nil
      )

;; projectile
(add-to-list 'projectile-globally-ignored-directories "vendor")
(add-to-list 'projectile-globally-ignored-directories "cache")
(add-to-list 'projectile-globally-ignored-directories "tmp")
(add-to-list 'projectile-globally-ignored-directories ".git")
(add-to-list 'projectile-globally-ignored-directories ".hg")

;; for yasnippet
(setq require-final-newline nil)

;; cua-mode
(cua-mode t)
(setq cua-enable-cua-keys nil) ; 不都合なキーバインドを無効化

;; markdown
;; from http://support.markedapp.com/kb/how-to-tips-and-tricks/marked-bonus-pack-scripts-commands-and-bundles
(defun markdown-preview-file ()
  "run Marked on the current file and revert the buffer"
  (interactive)
  (shell-command (format "open -a /Applications/Marked.app %s" (shell-quote-argument (buffer-file-name)))))

(add-hook 'markdown-mode-hook
  (lambda()
    (define-key markdown-mode-map (kbd "C-i") 'markdown-cycle)
    (hide-sublevels 2)
    (define-key markdown-mode-map (kbd "C-c m") 'markdown-preview-file)))

;; coffee-mode
(autoload 'coffee-mode "coffee-mode" "Major mode for editing CoffeeScript." t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-hook 'coffee-mode-hook
  (lambda()
    (setq coffee-tab-width 2)
    (setq whitespace-action '(auto-cleanup)) ;; automatically clean up bad whitespace
    (setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab)) ;; only show bad whitespace
    ))

;; flymake
(set-face-foreground 'flymake-errline "tomato")
(set-face-background 'flymake-errline nil)

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
  (push '("*helm prelude*" :height 20) popwin:special-display-config)
  )

;; direx
(when (require 'direx nil t)
  ;; :dedicatedにtを指定することで、direxウィンドウ内でのバッファの切り替えが
  ;; ポップアップ前のウィンドウに移譲される
  (push '(direx:direx-mode :position left :width 25 :dedicated t)
        popwin:special-display-config)
  (global-set-key (kbd "C-x C-d") 'direx:jump-to-directory-other-window)
  (setq direx:leaf-icon "  "
        direx:open-icon "▾ "
        direx:closed-icon "▸ ")
  )
