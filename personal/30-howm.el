(add-to-list 'load-path (concat (file-name-as-directory prelude-personal-dir) "howm"))

(setq howm-directory (concat (file-name-as-directory (getenv "DROPBOX")) "Logs")
      howm-menu-lang 'en
      howm-file-name-format "%Y/%Y-%m-%d-%H%M%S.md"
      howm-keyword-file (concat (file-name-as-directory howm-directory) ".howm-keys")
      howm-view-title-header "#"
      howm-keyword-case-fold-search t
      )

(when (require 'howm nil t)
  (define-key global-map [f5] 'howm-menu)
  (define-key global-map [(control f5)] 'howm-create)
  )
