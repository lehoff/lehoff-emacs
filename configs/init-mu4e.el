

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")



;;; taken from http://www.djcbsoftware.nl/code/mu/mu4e/Longer-configuration.html#Longer-configuration
;; example configuration for mu4e
(require 'mu4e)
(require 'org-mu4e)

;; path to our Maildir directory
(setq mu4e-maildir "~/Maildir")

;; the next are relative to `mu4e-maildir'
;; instead of strings, they can be functions too, see
;; their docstring or the chapter 'Dynamic folders'
(setq mu4e-sent-folder   "/Sent"
      mu4e-drafts-folder "/Drafts"
      mu4e-trash-folder  "/Trash"
      mu4e-refile-folder "/Archives")

;; the maildirs you use frequently; access them with 'j' ('jump')
(setq   mu4e-maildir-shortcuts
        '(("/Archives"    . ?a)
          ("/Inbox"       . ?i)
          ("/Sent"        . ?s)
          ))

;; a  list of user's e-mail addresses
(setq mu4e-user-mail-address-list '("torben.hoffmann@erlang-solutions.com"
                                    "torben@erlang-solutions.com"))

;; how to get mail
(setq
 mu4e-get-mail-command "offlineimap"   ;; or fetchmail, or ...
 mu4e-update-interval 300)             ;; update every 5 minutes

;; when you want to use some external command for text->html
;; conversion, e.g. the 'html2text' program
;; (setq mu4e-html2text-command "html2text")

;; the headers to show in the headers list -- a pair of a field
;; and its width, with `nil' meaning 'unlimited'
;; (better only use that for the last field.
;; These are the defaults:
(setq mu4e-headers-fields
      '( (:date          .  18)
         (:flags         .   6)
         (:from          .  22)
         (:subject       .  nil)))

;; program to get mail; alternatives are 'fetchmail', 'getmail'
;; isync or your own shellscript. called when 'U' is pressed in
;; main view.

;; If you get your mail without an explicit command,
;; use "true" for the command (this is the default)
(setq mu4e-get-mail-command "offlineimap")

;; general emacs mail settings; used when composing e-mail
;; the non-mu4e-* stuff is inherited from emacs/message-mode
(setq mu4e-reply-to-address "torben.hoffmann@erlang-solutions.com"
      user-mail-address "torben.hoffmann@erlang-solutions.com"
      user-full-name  "Torben Hoffmann")
(setq mu4e-user-mail-address-regexp
      "torben@erlang-solutions\.com\\|torben.hoffmann@erlang-soultions\.com")
(setq mu4e-org-contacts-file  "~/org/contacts.org")
(add-to-list 'mu4e-headers-actions
             '("org-contact-add" . mu4e-action-add-org-contact) t)
(add-to-list 'mu4e-view-actions
             '("org-contact-add" . mu4e-action-add-org-contact) t)


;; include in message with C-c C-w
;; (setq message-signature
;;       (concat
;;        "Torben Hoffmann\n"
;;        "CTO\n"
;;        "Erlang Solutions Ltd.\n"
;;        "Tel: +45 25 14 05 38\n"
;;        "http://www.erlang-solutions.com\n"))
(setq message-signature-file "~/.signature")


(load "tls")
;; smtp mail setting
(require 'smtpmail)
(setq
 message-send-mail-function 'smtpmail-send-it
 ;; starttls-use-gnutls t
 ;; starttls-gnutls-program "/usr/local/bin/gnutls-bin"
 ;; starttls-extra-arguments "--insecure"      

 ;; smtpmail-gnutls-credentials
 ;; '(("mail.erlang-solutions.com" 587 nil nil))
 ;; smtpmail-starttls-credentials 
 ;; '(("mail.erlang-solutions.com" 587 nil nil))

 ;;  smtpmail-gnutls-credentials
 ;; '(("smtp.gmail.com" 587 nil nil))
 ;; smtpmail-starttls-credentials 
 ;; '(("smtp.gmail.com" 587 nil nil))

 
 ;; alternative from http://www.djcbsoftware.nl/code/mu/mu4e/Gmail-configuration.html
 ;; smtpmail-starttls-credentials 
 ;; '(("mail.erlang-solutions.com" 587 nil nil))
 ;; smtpmail-stream-type 'ssl;;'starttls ;;'ssl 

 ;; new one inspired by http://stackoverflow.com/questions/16763033/wanderlust-osx-emacs-smtp-certification-failed
 ;; starttls-use-gnutls t
 ;; starttls-gnutls-program "/usr/bin/openssl"
 ;; starttls-extra-arguments "s_client -ssl2 -connect %s:%p")
 ;; smtpmail-auth-credentials '(("mail.erlang-solutions.com" 587 "torben.hoffmann" "BC$23!de"))
 
 smtpmail-default-smtp-server "mail.erlang-solutions.com"
 smtpmail-smtp-server "mail.erlang-solutions.com"
 smtpmail-local-domain "erlang-solutions.com"

;; smtpmail-stream-type 'starttls
 ;; smtpmail-default-smtp-server "smtp.gmail.com"
 ;; smtpmail-smtp-server "smtp.gmail.com"

 smtpmail-smtp-service 25
 smtpmail-debug-info t
 ;; if you need offline mode, set these -- and create the queue dir
 ;; with 'mu mkdir', i.e.. mu mkdir /home/user/Maildir/queue
 smtpmail-queue-mail  t
 smtpmail-queue-dir  "/Users/th/Maildir/queue/cur")

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

(setq
;; mu4e-use-fancy-chars t
;; mu4e-view-prefer-html t
 org-mu4e-convert-to-html t
 mu4e-show-images t
 message-kill-buffer-on-exit t
 mu4e-headers-include-related nil
 mu4e-headers-skip-duplicates t)

;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(setq mu4e-headers-date-format "%Y-%m-%d %H.%M")

;; from https://github.com/fgallina/dotemacs/blob/master/init.el
(defun my:mu4e-toggle-headers-include-related ()
      "Toggle `mu4e-headers-include-related' and refresh."
      (interactive)
      (setq mu4e-headers-include-related
            (not mu4e-headers-include-related))
      (mu4e-headers-rerun-search))

(define-key 'mu4e-headers-mode-map "o"
  'my:mu4e-toggle-headers-include-related)



;; view in browser with aV
(add-to-list 'mu4e-view-actions
             '("ViewInBrowser" . mu4e-action-view-in-browser) t)

;; use imagemagick if available
(when (fboundp 'imagemagick-register-types)
        (imagemagick-register-types))

(setq mu4e-html2text-command "html2text -utf8 -nobs -width 100")


;; automatic refiling from http://www.djcbsoftware.nl/code/mu/mu4e/Refiling-message.html
;; (defvar my-mu4e-subject-alist '(("kolloqui\\(um\\|a\\)" . "/Kolloquium")
;;                                 ("Calls" . "/Calls")
;;                                 ("Lehr" . "/Lehre")
;;                                 ("webseite\\|homepage\\|website" . "/Webseite"))
;;   "List of subjects and their respective refile folders.")
;; (defvar my-mu4e-senders-alist '(("redmine@erlang-solutions.com" . "Redmine")
;;                                 (".*\.github.com" . "Github"))
;;   "List of all senders and their refile folders.")

;; (defun my-mu4e-refile-folder-function (msg)
;;   "Set the refile folder for MSG."
;;   (let ((from (mu4e-message-field msg :from))
;;         (folder (or (cdar (member* from my-mu4e-senders-alist
;;                                    :test #'(lambda (x y)
;;                                              (string-match (car y) x))))
;;                     "/Inbox")))
;;     folder))

;; bookmarks for easy access
;;(add-to-list 'mu4e-bookmarks
;;             '("NOT to:redmine@erlang-solutions.com"       "Not tasks"     ?m))
;; OVERRIDING the standard list of bookmarks
(setq mu4e-bookmarks
      '( ("flag:unread AND NOT flag:trashed"     "Unread messages"      ?u)
         ("maildir:/INBOX and date:today..now" "Today's messages"     ?t)
         ("maildir:/INBOX and date:7d..now"    "Last 7 days"          ?w)
         ("maildir:/INBOX and date:31d..now"    "Last month"          ?m)
         ("mime:image/*"                         "Messages with images" ?p)
         ("maildir:/INBOX and from:redmine@erlang-solutions.com"
          "Redmine"              ?r)
         ("maildir:/INBOX and from:github.com" "Github"               ?g)

         ))



;; printing via mutt
;; https://groups.google.com/forum/#!searchin/mu-discuss/print/mu-discuss/WQdwVSluj3w/84jzXGL4AP4J
(add-to-list 'mu4e-view-actions
  `("Muttprint" .
     ,(defun mu4e-action-muttprint (msg)
        "Print the message using muttprint."
        (mu4e-view-pipe "muttprint -p Virtual_PDF_Printer")))) 





























