(setq evil-want-integration nil) ;; required by evil-collection

(require 'evil)

; (setq evil-search-module 'evil-search)
; (setq evil-ex-complete-emacs-commands nil)
; (setq evil-vsplit-window-right t) ;; like vim's 'splitright'
; (setq evil-split-window-below t) ;; like vim's 'splitbelow'
; (setq evil-shift-round nil)
; (setq evil-want-C-u-scroll t)

(setq evil-emacs-state-modes nil)
(setq evil-insert-state-modes nil)
(setq evil-motion-state-modes nil)

(evil-mode)

(require 'evil-collection)
(evil-collection-init)

