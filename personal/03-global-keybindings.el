(defun hungry-backspace ()
  (interactive)
  (let ((here (point)))
    (skip-chars-backward " \t\n\r\f\v")
    (if (/= (point) here)
        (delete-region (point) here)
      (call-interactively 'backward-delete-char-untabify))))

(defun hungry-delete ()
  (interactive)
  (let ((here (point)))
    (skip-chars-forward " \t\n\r\f\v")
    (if (/= (point) here)
        (delete-region (point) here)
      (call-interactively 'delete-char))))

(defun back-to-indentation-or-beginning ()
  (interactive)
  (if (= (point) (save-excursion (back-to-indentation) (point)))
      (beginning-of-line)
    (back-to-indentation)))

(global-set-key (kbd "C-h") 'hungry-backspace)
(global-set-key (kbd "C-d") 'hungry-delete)

(global-set-key (kbd "C-a") 'back-to-indentation-or-beginning)
(global-set-key (kbd "M-p") 'scroll-down)
(global-set-key (kbd "M-n") 'scroll-up)

(global-unset-key (kbd "C-x O"))
(global-set-key (kbd "C-o") (lambda ()
                              (interactive)
                              (other-window -1)))

;; Use shell-like backspace C-h, rebind help to F1
;(define-key key-translation-map [?\C-h] [?\C-?])
(global-set-key (kbd "<f1>") 'help-command)

(global-set-key (kbd "C-c C-r") 'comment-or-uncomment-region)

(global-set-key (kbd "C-S-y") 'yank-indented)
(global-set-key (kbd "M-s l") 'sort-lines)
(global-set-key (kbd "C-M-+") 'change-number-at-point)

(global-set-key (kbd "C-o") '(lambda () (interactive) (other-window 1)))

(defun toggle-linum-minor-mode ()
  (interactive)
  (linum-mode (if linum-mode -1 1)))

(global-set-key (quote [M-f2]) 'toggle-linum-minor-mode)
