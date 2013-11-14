(setq user-full-name "Takehiro KAMADA"
      user-mail-address "tadamak@gmail.com")

;; UTF-8 please
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; PATH
(setq exec-path (cons "/usr/local/bin" exec-path))
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setq exec-path (cons "~/.rbenv/shims" exec-path))
(setenv "PATH" (concat "~/.rbenv/shims:" (getenv "PATH")))

;; Cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; Smooth scrolling
(when (require 'smooth-scrolling nil t)
  (setq smooth-scroll-margin 4))

;; Show active region
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)

;; Load machine local configuration
(let ((local-config (expand-file-name ".local.el" user-emacs-directory)))
  (when (file-exists-p local-config)
    (load local-config t)))

(when (load "server")
  (unless (server-running-p) (server-start))
  (remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function))
