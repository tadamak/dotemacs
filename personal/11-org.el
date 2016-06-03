;; open-junk-file
(defvar my/junk-files-dir (concat (file-name-as-directory (or (getenv "DROPBOX") "~/Dropbox")) "Logs"))
(defvar my/open-junk-file-format (concat my/junk-files-dir "/%Y/%Y-%m-%d-%H%M%S.md"))

(when (require 'open-junk-file nil t)
  (setq open-junk-file-format my/open-junk-file-format)
  (global-set-key (kbd "C-x j") 'open-junk-file))

(defun my/new-junk-file-path ()
  (let* ((file (format-time-string my/open-junk-file-format (current-time)))
         (dir (file-name-directory file)))
    (make-directory dir t)
    file))

;; org-mode
(global-set-key (kbd "C-c c") 'org-capture)
(custom-set-variables
 '(org-startup-truncated nil)
 '(org-completion-use-helm t)
 '(org-directory my/junk-files-dir)
 '(org-agenda-files (list my/junk-files-dir))
 '(org-agenda-file-regexp "\\`[^.].*\\.org\\'")
 '(org-return-follows-link t)
 '(org-use-speed-commands t)
 '(org-use-fast-todo-selection t)
 '(org-src-fontify-natively t)
 '(org-deadline-warning-days 5)
 '(org-agenda-span 'fortnight)
 ;; don't show tasks as scheduled if they are already shown as a deadline
 '(org-agenda-skip-scheduled-if-deadline-is-shown t)
 ;; don't give a warning color to tasks with impending deadlines if they are scheduled to be done
 '(org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
 ;; don't show tasks that are scheduled or have deadlines in the normal todo list
 '(org-agenda-todo-ignore-deadlines 'all)
 '(org-agenda-todo-ignore-scheduled 'all)
 '(org-agenda-sorting-strategy
   '((agenda deadline-up priority-down)
     (todo priority-down category-keep)
     (tags priority-down category-keep)
     (search category-keep)))
 '(org-capture-templates
   '(("t" "todo" entry (file (expand-file-name (concat my/junk-files-dir "/task.org")))
      "* TODO %?[]\n  SCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n  %a\n")
     ;; https://github.com/takaishi/.emacs.d/blob/master/conf.d/30_org-mode.org
;;      ("b" "bug" entry (file+headline (expand-file-name (concat my/junk-files-dir "/task.org"))
;;                                      (let ((milestone (plist-get (plist-get org-store-link-plist :query) :milestone)))
;;                                        (message (plist-get org-store-link-plist :query))
;;                                        (if (string= milestone "") "backlog" "sprint")))
;;       "* TODO %:description
;; :PROPERTIES:
;; :ID: %(plist-get (plist-get org-store-link-plist :query) :ticket-id)
;; :END:"
;;       :imeediate-finish t)
     ("m" "memo" plain (file (my/new-junk-file-path))
      "# %?\n%a\n")))
 '(org-todo-keywords
   '((sequence "TODO(t)" "DOING(d)" "WAITING(w)" "|" "DONE(x)" "CANCEL(c)")))
 '(org-todo-keyword-faces
   '(("TODO" . org-warning)
     ("DOING" . (:foreground "orange" :underline t :weight bold))
     ("WAITING" . "firebrick1")
     ("DONE" . "green")
     ("CANCEL" . "SteelBlue"))))
(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "q") 'quit-window)
  (define-key org-agenda-mode-map (kbd "M-n") 'org-agenda-do-date-later)
  (define-key org-agenda-mode-map (kbd "M-p") 'org-agenda-do-date-earlier))
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-M-<return>") 'org-insert-todo-heading)
  (define-key org-mode-map (kbd "C-c <tab>") 'show-all)
  (smartrep-define-key
      org-mode-map "C-c" '(("l" . 'org-shiftright)
                           ("h" . 'org-shiftleft)
                           ("n" . 'org-metadown)
                           ("p" . 'org-metaup)))
  (add-hook 'markdown-mode-hook
            (lambda ()
              (orgstruct++-mode)
              (setq orgstruct-heading-prefix-regexp "#\\+"))))
