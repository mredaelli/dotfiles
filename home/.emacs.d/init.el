
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)
(require 'package)

;; optional. makes unpure packages archives unavailable
(setq package-archives nil)

(setq package-enable-at-startup nil)
(package-initialize)

(require 'ido)


(defun xah-get-fullpath (@file-relative-path)
  (concat (file-name-directory (or load-file-name buffer-file-name)) @file-relative-path)
)

;(add-to-list 'load-path "~/git/xah-fly-keys/")

(set-face-attribute 'default t :font "Hasklig Medium")
(set-face-attribute 'default (selected-frame) :height 160)


(load (xah-get-fullpath "utils.el"))
(load (xah-get-fullpath "email.el"))
(load (xah-get-fullpath "evil.el"))




