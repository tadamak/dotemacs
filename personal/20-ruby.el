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

(eval-after-load 'ruby-mode
  '(progn
     (add-hook 'ruby-mode-hook
               (lambda ()
                 (robe-mode)
                 (ac-robe-setup)
                 (rinari-launch)
                 (setq ruby-deep-indent-paren-style nil
                       ruby-insert-encoding-magic-comment nil
                       ruby-block-highlight-toggle t)
                 ))))

(provide '20-ruby)
