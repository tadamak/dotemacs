(require 'prelude-programming)
(require 'prelude-ruby)
(prelude-ensure-module-deps '(ruby-tools inf-ruby yari))

(require 'rinari)
(require 'robe)
;; (require 'rhtml-mode)
;; (require 'ruby-end)
;; (require 'flymake)

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

;; (add-hook 'rhtml-mode-hook
;;           (lambda () (rinari-launch)))

;; (when (require 'feature-mode nil t)
;;   (add-hook 'feature-mode-hook
;;             (lambda () (orgtbl-mode -1))))

;; (when (require 'yaml-mode nil t)
;;   (add-to-list 'auto-mode-alist '("\.yml\\'" . yaml-mode)))

(define-key rinari-minor-mode-map (kbd "H-;") 'rinari-find-by-context)
(define-key rinari-minor-mode-map (kbd "H-m") 'rinari-find-model)
(define-key rinari-minor-mode-map (kbd "H-c") 'rinari-find-controller)
(define-key rinari-minor-mode-map (kbd "H-v") 'rinari-find-view)
(define-key rinari-minor-mode-map (kbd "H-h") 'rinari-find-helper)
(define-key rinari-minor-mode-map (kbd "H-l") 'rinari-find-lib)
(define-key rinari-minor-mode-map (kbd "H-t") 'rinari-find-test)
(define-key rinari-minor-mode-map (kbd "H-r") 'rinari-find-rspec)
(define-key rinari-minor-mode-map (kbd "H-F") 'rinari-find-feature)
(define-key rinari-minor-mode-map (kbd "H-S") 'rinari-find-steps)
;(define-key rinari-minor-mode-map (kbd "H-j") 'rinari-find-javascript)
;(define-key rinari-minor-mode-map (kbd "H-y") 'rinari-find-stylesheet)
;(define-key rinari-minor-mode-map (kbd "H-Y") 'rinari-find-sass)
;(define-key rinari-minor-mode-map (kbd "H-a") 'rinari-find-application)
;(define-key rinari-minor-mode-map (kbd "H-n") 'rinari-find-configuration)
(define-key rinari-minor-mode-map (kbd "H-o") 'rinari-find-log)
;(define-key rinari-minor-mode-map (kbd "H-C") 'rinari-find-cells)
;(define-key rinari-minor-mode-map (kbd "H-M") 'rinari-find-mailer)
;(define-key rinari-minor-mode-map (kbd "H-e") 'rinari-find-environment)
(define-key rinari-minor-mode-map (kbd "H-i") 'rinari-find-migration)
;(define-key rinari-minor-mode-map (kbd "H-p") 'rinari-find-public)
;(define-key rinari-minor-mode-map (kbd "H-u") 'rinari-find-plugin)
;(define-key rinari-minor-mode-map (kbd "H-w") 'rinari-find-worker)
;(define-key rinari-minor-mode-map (kbd "H-x") 'rinari-find-fixture)
(define-key rinari-minor-mode-map (kbd "H-z") 'rinari-find-rspec-fixture)

;; (defadvice ruby-indent-line (after unindent-closing-paren activate)
;;   (let ((column (current-column))
;;         indent offset)
;;     (save-excursion
;;       (back-to-indentation)
;;       (let ((state (syntax-ppss)))
;;         (setq offset (- column (current-column)))
;;         (when (and (eq (char-after) ?\))
;;                    (not (zerop (car state))))
;;           (goto-char (cadr state))
;;           (setq indent (current-indentation)))))
;;     (when indent
;;       (indent-line-to indent)
;;       (when (> offset 0) (forward-char offset)))))

;; (defun flymake-ruby-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-with-folder-structure))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "ruby" (list "-c" local-file))))
;; (push '(".+\\.rb\\" flymake-ruby-init) flymake-allowed-file-name-masks)
;; (push '("Rakefile\\" flymake-ruby-init) flymake-allowed-file-name-masks)
;; (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
;; ;; (add-hook 'ruby-mode-hook
;; ;;           (lambda () (if (not (null buffer-file-name)) (flymake-mode))
;; ;;             (define-key ruby-mode-map (kbd "H-f") 'credmp/flymake-display-err-minibuf)))

;; (defun credmp/flymake-display-err-minibuf ()
;;   (interactive)
;;   (let* ((line-no (flymake-current-line-no))
;;          (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;;          (count (length line-err-info-list)))
;;     (while (> count 0)
;;       (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
;;              (full-file (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;;              (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;;              (line (flymake-ler-line (nth (1- count) line-err-info-list))))
;;         (message "[%s] %s" line text))
;;       (setq count (1- count)))))

;; (setq rinari-tags-file-name "TAGS")

(provide '20-ruby)
