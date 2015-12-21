(require 'prelude-programming)
(require 'prelude-ruby)
(prelude-ensure-module-deps '(ruby-tools inf-ruby yari))

(require 'robe)

(add-hook 'projectile-mode-hook 'projectile-rails-on)

(define-key 'help-command (kbd "R") 'yari)

(when (require 'web-mode)
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.hamlc\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.less\\'" . css-mode))
  (add-hook 'web-mode-hook
            (lambda ()
              (local-set-key (kbd "RET") 'newline-and-indent))
              (setq web-mode-code-indent-offset 2
                    web-mode-markup-indent-offset 2
                    web-mode-css-indent-offset 2
                    web-mode-disable-auto-indentation nil
                    )))

(defun ruby-mode-set-encoding () ())

(with-eval-after-load 'ruby-mode
  (add-hook 'ruby-mode-hook 'my/ruby-mode-hook)
  (define-key ruby-mode-map (kbd "C-c C-a") 'ruby-beginning-of-block)
  (define-key ruby-mode-map (kbd "C-c C-e") 'ruby-end-of-block)
  (define-key ruby-mode-map (kbd "C-c ?") 'robe-doc)
  (dolist (key '("(" ")" "{" "}" "[" "]" "\"" "'"))
    (define-key ruby-mode-map key nil)))

(defun my/ruby-mode-hook ()
  (setq flycheck-checker 'ruby-rubocop)
  (setq ruby-deep-indent-paren-style nil
        ruby-insert-encoding-magic-comment nil
        ruby-block-highlight-toggle t)
  (robe-mode +1)
  (add-to-list 'company-backends 'company-robe)
;;  (rinari-launch)
;;  (ruby-end-mode +1)
  )

(provide '20-ruby)
