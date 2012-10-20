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

;; Smooth scrolling
(require 'smooth-scrolling)
(setq smooth-scroll-margin 4)

;; Show active region
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)

;; Load machine local configuration
(let ((local-config (expand-file-name ".local.el" user-emacs-directory)))
  (when (file-exists-p local-config)
    (load local-config t)))

(add-hook 'text-mode-hook 'turn-off-flyspell)

;; (setq-default
;;  mode-line-format
;;  (list
;;   ""
;;   'mode-line-mule-info
;;   'mode-line-modified
;;   " " ;mode-line-frame-identification
;;   "%1b" ;->'mode-line-buffer-identification
;;   " "  'global-mode-string
;;   "%[<"
;;   'mode-name
;;   ">"
;;   'mode-line-process
;;   'minor-mode-alist
;;   " "
;;   "%]"
;;   '(which-func-mode ("" which-func-format ""))
;;   "["
;;   '(line-number-mode "%l:")
;;   '(column-number-mode "%c:")
;;   "%P"
;;   "] "
;;   'default-directory))
;; ("%e"
;;  (:eval (if (display-graphic-p)
;;             #(" " 0 1 (help-echo "mouse-1: Select (drag to resize)
;; mouse-2: Make current window occupy the whole frame
;; mouse-3: Remove current window from display"))
;;           #("-" 0 1 (help-echo "mouse-1: Select (drag to resize)
;; mouse-2: Make current window occupy the whole frame
;; mouse-3: Remove current window from display"))))
;;  mode-line-mule-info
;;  mode-line-client
;;  mode-line-modified
;;  mode-line-remote
;;  mode-line-frame-identification
;;  mode-line-buffer-identification
;;  #("   " 0 3 (help-echo "mouse-1: Select (drag to resize)
;; mouse-2: Make current window occupy the whole frame
;; mouse-3: Remove current window from display"))
;;  mode-line-position
;;  (vc-mode vc-mode)
;;  #("  " 0 2 (help-echo "mouse-1: Select (drag to resize)
;; mouse-2: Make current window occupy the whole frame
;; mouse-3: Remove current window from display"))
;;  mode-line-modes
;;  (which-func-mode ("" which-func-format #(" " 0 1 (help-echo "mouse-1: Select (drag to resize)
;; mouse-2: Make current window occupy the whole frame
;; mouse-3: Remove current window from display"))))
;;  (global-mode-string ("" global-mode-string #(" " 0 1 (help-echo "mouse-1: Select (drag to resize)
;; mouse-2: Make current window occupy the whole frame
;; mouse-3: Remove current window from display"))))
;;  (:eval (unless (display-graphic-p) #("-%-" 0 3 (help-echo "mouse-1: Select (drag to resize)
;; mouse-2: Make current window occupy the whole frame
;; mouse-3: Remove current window from display"))))
;; )

;; デフォルトのフレーム設定
;; ディスプレイサイズによって分離する試み 途中
(cond
 ;; 1920 * 1200 ディスプレイ
 ;; デュアルだったりトリプルだったりするので width の方は条件に入れてない
 ;; 設定は (frame-parameter (selected-frame) 'height) などで値を取得して設定する
 ((= (display-pixel-height) 1200)
  (setq default-frame-alist
        (append (list
                 '(width . 180)
                 '(height . 56)
                 '(top . 22)
                 '(left . 400)
                 )
                default-frame-alist)))
 ;; MacBook Air 11
 ((= (display-pixel-height) 768)
  (setq default-frame-alist
        (append (list
                 '(width . 162)
                 '(height . 42)
                 '(top . 22)
                 '(left . 20)
                 )
                default-frame-alist)))
 ;; とりあえずその他 完全に未確認で分岐できる事を確認するためのコード
 (t
  (setq default-frame-alist
        (append (list
                 '(width . 140)
                 '(height . 50)
                 '(top . 22)
                 '(left . 100)
                 )
                default-frame-alist))))

;; 垂直スクロール用のスクロールバーを付けない
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))

;; 背景の透過
;; (add-to-list 'default-frame-alist '(alpha . (85 20)))
(add-to-list 'default-frame-alist '(alpha . (92 70)))

;;; フォントの設定

(defun my-ja-font-setter (spec)
  (set-fontset-font nil 'japanese-jisx0208 spec)
  (set-fontset-font nil 'katakana-jisx0201 spec)
  (set-fontset-font nil 'japanese-jisx0212 spec)
  (set-fontset-font nil '(#x0080 . #x024F) spec)
  (set-fontset-font nil '(#x0370 . #x03FF) spec)
  (set-fontset-font nil 'mule-unicode-0100-24ff spec))

(defun my-ascii-font-setter (spec)
  (set-fontset-font nil 'ascii spec))      

(cond
 ;; CocoaEmacs
 ((eq window-system 'ns)
  (when (or (= emacs-major-version 23) (= emacs-major-version 24))
    (let
        ;; 1) Monaco, Hiragino/Migu 2M : font-size=12, -apple-hiragino=1.2
        ;; 2) Inconsolata, Migu 2M     : font-size=14, 
        ;; 3) Inconsolata, Hiragino    : font-size=14, -apple-hiragino=1.0
        ((font-size 14)
         ;;(ascii-font "Inconsolata")
         ;;(ascii-font "Monaco")
         (ascii-font "Source Code Pro")
         ;;(ja-font "Migu 2M")
         (ja-font "Hiragino Kaku Gothic ProN")
         )
      ;; (ja-font "Hiragino Maru Gothic Pro")) 
      (my-ascii-font-setter (font-spec :family ascii-font :size font-size))
      (my-ja-font-setter (font-spec :family ja-font :size font-size)))
    
    ;; Fix ratio provided by set-face-attribute for fonts display
    (setq face-font-rescale-alist
          '(("^-apple-hiragino.*" . 1.2)
            (".*Migu.*" . 1.2)
            ("^-apple-Source_Code_Pro.*" . 1.0)
            (".*Inconsolata.*" . 1.0)
            (".*osaka-bold.*" . 1.0) ; 1.2
            (".*osaka-medium.*" . 1.0) ; 1.0
            (".*courier-bold-.*-mac-roman" . 1.0) ; 0.9
            ;; (".*monaco cy-bold-.*-mac-cyrillic" . 1.0)
            ;; (".*monaco-bold-.*-mac-roman" . 1.0) ; 0.9
            ("-cdac$" . 1.0))) ; 1.3
    ;; Space between lines
    (set-default 'line-spacing 1)
    ;; Anti aliasing with Quartz 2D
    (setq mac-allow-anti-aliasing t)))
 
 ((eq window-system 'w32) ; windows7
  (let ((font-size 14)
        (font-height 100)
        (ascii-font "Inconsolata")
        ;; (ja-font "Meiryo UI"))
        (ja-font "メイリオ"))
    (my-ja-font-setter
     (font-spec :family ja-font :size font-size :height font-height))
    (my-ascii-font-setter (font-spec :family ascii-font :size font-size)))
  (setq face-font-rescale-alist '((".*Inconsolata.*" . 1.0))) ; 0.9
  (set-default 'line-spacing 1))
 
 (window-system
  (let ((font-size 14)
        (font-height 100)
        (ascii-font "Inconsolata")
        ;; (ja-font "MigMix 1M")
        (ja-font "Migu 1M"))
    (my-ja-font-setter
     (font-spec :family ja-font :size font-size :height font-height))
    (my-ascii-font-setter (font-spec :family ascii-font :size font-size)))
  (setq face-font-rescale-alist '((".*MigMix.*" . 2.0)
                                  (".*Inconsolata.*" . 1.0))) ; 0.9
  (set-default 'line-spacing 1)))

(when (load "server")
  (unless (server-running-p) (server-start))
  (remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function))
