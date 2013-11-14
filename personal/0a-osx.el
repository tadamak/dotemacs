(when (eq system-type 'darwin)
  ;; Emacs users obviously have little need for Command and Option keys,
  ;; but they do need Meta and Super
  (setq mac-command-modifier 'meta)
  (setq mac-right-command-modifier 'hyper)
  (setq mac-option-modifier 'super)

  ;; Keybinding to toggle full screen mode
  (global-set-key (quote [M-f10]) (quote ns-toggle-fullscreen))

  ;; Move to trash when deleting stuff
  (setq delete-by-moving-to-trash t
        trash-directory "~/.Trash/emacs")

  ;; Ignore .DS_Store files with ido mode
  (add-to-list 'ido-ignore-files "\\.DS_Store")

  ;; Don't open files from the workspace in a new frame
  (setq ns-pop-up-frames nil)

  ;; Use aspell for spell checking: brew install aspell --lang=en
  (setq ispell-program-name "/usr/local/bin/aspell")
)
