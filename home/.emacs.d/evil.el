(setq evil-want-integration nil) ;; This is optional since it's already set to t by default.
(setq evil-want-keybinding nil)

;(setq evil-emacs-state-modes nil)
;(setq evil-insert-state-modes nil)
;(setq evil-motion-state-modes nil)


(require 'evil)
(evil-mode 1)
;(when (require 'evil-collection nil t)
(require 'evil-collection)
(evil-collection-init);)

; (setq evil-want-integration nil) ;; required by evil-collection

; (require 'evil)

; ; (setq evil-search-module 'evil-search)
; ; (setq evil-ex-complete-emacs-commands nil)
; ; (setq evil-vsplit-window-right t) ;; like vim's 'splitright'
; ; (setq evil-split-window-below t) ;; like vim's 'splitbelow'
; ; (setq evil-shift-round nil)
; ; (setq evil-want-C-u-scroll t)

; (evil-collection-init)

