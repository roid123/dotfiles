(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)

(setq-default tab-width 4)
(setq tab-width 4)
(setq tab-stop-list
                 '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
(add-hook 'c-mode-common-hook
            '(lambda ()
               (c-set-style "k&r")
             (c-set-offset 'case-label '+)
             (setq tab-width 4)
               (setq c-basic-offset 4)))
(add-hook 'java-mode-hook
          '(lambda ()
             (c-set-style "java")
             (c-set-offset 'case-label '+)))
(setq truncate-lines t)
(setq truncate-partial-width-windows t)
(set-scroll-bar-mode 'right)
(setq inhibit-startup-message t)
;====================================
;; 最近使ったファイル」を（メニューに）表示する
;; ;====================================
;; ; M-x recentf-open-files で履歴一覧バッファが表示される。
(require 'recentf)
;; ;;http://homepage.mac.com/zenitani/elisp-j.html#recentf
;; ;; /sudo:hogehoge などが履歴に残っていると、起動時に毎回パ
;; ;; スワードを聞いてくるのでその履歴だけを削除する。
;; ;;(setq recentf-exclude '("^/[^/:]+:")) ;;tramp対策。
(setq recentf-auto-cleanup 'never) ;;tramp対策。
(recentf-mode 1)

(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)
(set-locale-environment nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
'(auto-save-default nil)
'(make-backup-files nil)
'(show-paren-mode t)
'(truncate-lines t))

(put 'scroll-left 'disabled nil)

; 言語を日本語にする
(set-language-environment 'Japanese)
; 極力UTF-8とする
(prefer-coding-system 'utf-8)
