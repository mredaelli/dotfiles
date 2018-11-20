(require 'mu4e)     

(global-set-key  [(control ?x) (control ?m)] 'mu4e)

(setq mail-user-agent 'mu4e-user-agent)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  IMAP Accounts

(setq mu4e-contexts
      `(
	,(make-mu4e-context
     :name "Main"
     :enter-func (lambda () (mu4e-message "Entering account1 context"))
     :leave-func (lambda () (mu4e-message "Leaving account1 context"))
     :match-func (lambda (msg) (when msg
       (string-prefix-p "/main" (mu4e-message-field msg :maildir))))
     :vars '(
       (mu4e-trash-folder . "/main/trash")
;       (mu4e-refile-folder . "/mredaelli/archive")
       (mu4e-drafts-folder . "/main/drafts")
       (mu4e-sent-folder . "/main/sent")
       (mu4e-sent-messages-behavior 'delete)
    (mu4e-maildir-shortcuts .
        ( ("/main/inbox"               . ?i)
           ("/main/sent"   . ?s)
           ("/main/trash"       . ?t)
           ("/main/drafts"      . ?d)
           ))
       ))
	,(make-mu4e-context
     :name "Fast"
     :enter-func (lambda () (mu4e-message "Entering Fast context"))
     :leave-func (lambda () (mu4e-message "Leaving Fast context"))
     :match-func (lambda (msg) (when msg
       (string-prefix-p "/fast" (mu4e-message-field msg :maildir))))
     :vars '(
       (mu4e-trash-folder . "/fast/trash")
;       (mu4e-refile-folder . "/mredaelli/archive")
       (mu4e-drafts-folder . "/fast/drafts")
       (mu4e-sent-folder . "/fast/sent")
    (mu4e-maildir-shortcuts .
        ( ("/fast/inbox"               . ?i)
           ("/fast/sent"   . ?s)
           ("/fast/trash"       . ?t)
           ("/fast/drafts"      . ?d)
           ))
       ))
	,(make-mu4e-context
     :name "Cesgraf"
     :match-func (lambda (msg) (when msg
       (string-prefix-p "/cesgraf" (mu4e-message-field msg :maildir))))
     :vars '(
       (mu4e-trash-folder . "/cesgraf/trash")
;       (mu4e-refile-folder . "/cesgraf/Archive")
       (mu4e-drafts-folder . "/cesgraf/drafts")
       (mu4e-sent-folder . "/cesgraf/sent")
       (mu4e-sent-messages-behavior 'delete)
       ))
	,(make-mu4e-context
     :name "Perizie"
     :match-func (lambda (msg) (when msg
       (string-prefix-p "/perizie" (mu4e-message-field msg :maildir))))
     :vars '(
       (mu4e-trash-folder . "/perizie/trash")
;       (mu4e-refile-folder . "/perizie/Archive")
       (mu4e-drafts-folder . "/perizie/drafts")
       (mu4e-sent-folder . "/perizie/sent")
       (mu4e-sent-messages-behavior 'delete)
       ))
      	,(make-mu4e-context
     :name "UAAR"
     :match-func (lambda (msg) (when msg
       (string-prefix-p "/uaar" (mu4e-message-field msg :maildir))))
     :vars '(
       (mu4e-trash-folder . "/uaar/trash")
;       (mu4e-refile-folder . "/uaar/[Gmail].Archive")
       (mu4e-drafts-folder . "/uaar/drafts")
       (mu4e-sent-folder . "/uaar/sent")
       (mu4e-sent-messages-behavior 'delete)
       ))
   ))


(setq
   user-mail-address "m.redaelli@gmail.com"
   user-full-name  "Massimo Redaelli"
   mu4e-compose-signature
    (concat
      "Massimo Redaelli"))



(setq mu4e-sent-folder "/main/sent"
      mu4e-drafts-folder "/main/drafts"
      mu4e-trash-folder "/main/trash"
      user-mail-address "m.redaelli@gmail.com"
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-local-domain "gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

(defvar my-mu4e-account-alist
  '(("Main"
     (mu4e-sent-folder "/main/sent")
     (user-mail-address "m.redaelli@gmail.com")
     (smtpmail-smtp-user "m.redaelli")
     (smtpmail-local-domain "gmail.com")
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-service 587)
     )
   ,("Cesgraf"
     (mu4e-sent-folder "/cesgraf/sent")
     (user-mail-address "cesgraf.nord@gmail.com")
     (smtpmail-smtp-user "cesgraf.nord")
     (smtpmail-local-domain "gmail.com")
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-service 587)
     )
    ))

(defun my-mu4e-set-account ()
  "Set the account for composing a message.
   This function is taken from: 
     https://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html"
  (let* ((account
    (if mu4e-compose-parent-message
        (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
    (string-match "/\\(.*?\\)/" maildir)
    (match-string 1 maildir))
      (completing-read (format "Compose with account: (%s) "
             (mapconcat #'(lambda (var) (car var))
            my-mu4e-account-alist "/"))
           (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
           nil t nil nil (caar my-mu4e-account-alist))))
   (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
  (mapc #'(lambda (var)
      (set (car var) (cadr var)))
        account-vars)
      (error "No email account found"))))
(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; HTML rendering

;; emacs-w3m
(defun mu4e-action-view-in-w3m (msg)
  "View the body of the message in emacs w3m."
  (w3m-browse-url (concat "file://"
              (mu4e~write-body-to-html msg))))
(setq w3m-default-display-inline-images t
      w3m-resize-images t
)


;(setq mu4e-html2text-command "w3m -dump -cols 10000 -s -T text/html")
(setq mu4e-html2text-command 'mu4e-action-view-in-w3m)

;(setq mu4e-view-show-images t
;       mu4e-show-images t
;       mu4e-view-image-max-width 800
;       mu4e-image-max-width 800)
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(setq mu4e-view-prefer-html nil)



(add-to-list 'mu4e-view-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t)
(add-to-list 'mu4e-view-actions '("w3m view" . mu4e-action-view-in-w3m) t)
(add-to-list 'mu4e-view-actions '("Eww view" . jcs-view-in-eww) t)
(defun jcs-view-in-eww (msg)
(eww-browse-url (concat "file://" (mu4e~write-body-to-html msg))))

; not working
  (evil-define-key 'normal 'w3m-mode
    "2" 'w3m-close-window
    )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Sending

;; compose with the current context if no context matches;
(setq mu4e-compose-context-policy nil)

(setq mu4e-compose-format-flowed t)

; (require 'smtpmail)
; (setq message-send-mail-function 'smtpmail-send-it
;    starttls-use-gnutls t
;    smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;    smtpmail-auth-credentials
;      '(("smtp.gmail.com" 587 "m.redaelli@gmail.com" nil))
;    smtpmail-default-smtp-server "smtp.gmail.com"
;    smtpmail-smtp-server "smtp.gmail.com"
;    smtpmail-smtp-service 587)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; other

(setq message-kill-buffer-on-exit t)
(setq mu4e-use-fancy-chars t)
(setq mu4e-context-policy 'pick-first)
(setq mu4e-attachment-dir "~/downloads")
(setq mu4e-split-view "vertical")
(setq mu4e-view-show-addresses t)
(setq mu4e-headers-skip-duplicates t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Mailboxes preview

(require 'mu4e-maildirs-extension)

(mu4e-maildirs-extension)

(setq mu4e-maildirs-extension-custom-list 
      (flatten (list 
           (prepend-to-all "main/" 
                           (append '("inbox" "sent" "Amazon" 
                                     "NoLabel" "JobHunting" 
                                     "Papers" "Shopping" "Social")
                                   (prepend-to-all "dev/" '("CircuiTikz" "zfs"))
                           )
           )
      ))
)

(setq mu4e-maildirs-extension-default-collapse-level 2)
;(setq mu4e-maildirs-extension-hide-empty-maildirs t)
;mu4e-maildirs-extension-toggle-maildir-key


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; utils


(setq mu4e-user-mail-address-list
    (delq nil
      (mapcar (lambda (context)
                (when (mu4e-context-vars context)
                  (cdr (assq 'user-mail-address (mu4e-context-vars context)))))
        mu4e-contexts)))




(setq mu4e-marks (remove-nth-element 5 mu4e-marks))
(add-to-list 'mu4e-marks
     '(trash
       :char ("d" . "▼")
       :prompt "dtrash"
       :dyn-target (lambda (target msg) (mu4e-get-trash-folder msg))
       :action (lambda (docid msg target) 
                 (mu4e~proc-move docid
                    (mu4e~mark-check-target target) "-N"))))

