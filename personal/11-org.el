;; open-junk-file
(defvar my/junk-files-dir (concat (file-name-as-directory (or (getenv "DROPBOX") "~/Dropbox")) "Logs"))
(when (require 'open-junk-file nil t)
  (global-set-key (kbd "C-x j") 'open-junk-file)
  (setq open-junk-file-format (concat my/junk-files-dir "%Y/%Y-%m-%d.md")))

;; org-mode
(global-set-key (kbd "C-c c") 'org-capture)
(custom-set-variables
 '(org-startup-truncated nil)
 '(org-directory my/junk-files-dir)
 '(org-agenda-files (list my/junk-files-dir))
 '(org-agenda-file-regexp "\\`[^.].*\\.org\\'")
 '(org-return-follows-link t)
 '(org-use-speed-commands t)
 '(org-use-fast-todo-selection t)
 '(org-src-fontify-natively t)
 '(org-capture-templates
   '(("p" "Project Task" entry (file (expand-file-name (concat my/junk-files-dir "/project.org")))
      "* TODO [] %? %t\n    %a\n")
     ("m" "memo" entry (file+datetree (expand-file-name (concat my/junk-files-dir "/memo.org")))
      "* %? %T\n  %a\n")))
 '(org-todo-keywords
   '((sequence "TODO(t)" "DOING(d)" "WAITING(w)" "|" "DONE(x)" "CANCEL(c)")))
 '(org-todo-keyword-faces
   '(("TODO" . org-warning)
     ("DOING" . (:forground "orange" :underline t :weight bold))
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
