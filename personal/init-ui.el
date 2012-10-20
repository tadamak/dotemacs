;; No menu bars
(menu-bar-mode -1)

;; Ditch them scrollbars
(scroll-bar-mode -1)

;; Disable hilight-current-line
(global-hl-line-mode -1)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" (:eval (if (buffer-file-name)
                      (abbreviate-file-name (buffer-file-name))
                    "%b"))))
