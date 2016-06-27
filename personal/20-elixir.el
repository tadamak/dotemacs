(defun elixir-mode-compile-on-save ()
  "Elixir mode compile files on save."
  (and (file-exists (buffer-file-name))
       (file-exists (elixir-mode-compiled-file-name))
       (elixir-cos-mode t)))

(when (require 'elixir-mode nil t)
  ;; (add-hook 'elixir-mode-hook 'elixir-mode-compile-on-save)
  ;; (add-to-list 'elixir-mode-hook
  ;;              (defun auto-activate-ruby-end-mode-for-elixir-mode ()
  ;;                (set (make-variable-buffer-local 'ruby-end-expand-keywords-before-re)
  ;;                     "\\(?:^\\|\\s-+\\)\\(?:do\\)")
  ;;                (set (make-variable-buffer-local 'ruby-end-check-statement-modifiers) nil)
  ;;                (ruby-end-mode +1)))
  )

(defun my-elixir-do-end-close-action (id action context)
  (when (eq action 'insert)
    (newline-and-indent)
    (previous-line)
    (indent-according-to-mode)))

(sp-with-modes '(elixir-mode)
  (sp-local-pair "do" "end"
                 :when '(("SPC" "RET"))
                 :post-handlers '(:add my-elixir-do-end-close-action)
                 :actions '(insert)))

(when (require 'alchemist nil t))
