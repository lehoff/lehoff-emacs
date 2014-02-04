;; EQC Emacs Mode -- Configuration Start
(add-to-list 'load-path "/Users/th/Library/Erlang/lib/eqc-1.29.1/emacs/")
(autoload 'eqc-erlang-mode-hook "eqc-ext" "EQC Mode" t)
(add-hook 'erlang-mode-hook 'eqc-erlang-mode-hook)
(setq eqc-max-menu-length 30)
(setq eqc-root-dir "/Users/th/Library/Erlang/lib/eqc-1.29.1")
;; EQC Emacs Mode -- Configuration End

;; (setq message-default-charset 'utf-8)
;; (set-language-environment 'utf-8)
;; (prefer-coding-system 'utf-8)
;; (set-charset-priority 'unicode)


;; (setq default-sendmail-coding-system 'utf-8)
;; (set-locale-environment "en_GB.UTF-8")
;; (setq default-process-coding-system '(utf-8 . utf-8))
;; (setq buffer-file-coding-system 'utf-8)
;; (set-language-environment 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (setq locale-coding-system 'utf-8)
;; (prefer-coding-system 'utf-8)
;; (set-default-coding-systems 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))
 
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; init.el --- Initialization file for my Emacs setup
;;; Commentary:
 ;; mac specific settings
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'none))	
;(setq mac-command-modifier 'meta
;      mac-option-modifier 'none
;      default-input-method "MacOSX")
;(setq mac-function-modifier 'meta)

(global-set-key [s-left] 'beginning-of-line)
(global-set-key [s-right] 'end-of-line)
(global-set-key [s-up] 'beginning-of-buffer)
(global-set-key [s-down] 'end-of-buffer)
(global-set-key [M-right] 'forward-word)
(global-set-key [M-left] 'backward-word)
;(global-set-key [f19] 'meta)
;(define-key function-key-map (kbd "f19") 'event-apply-meta-modifier)

(global-set-key [f4] 'mu4e-update-mail-and-index)
(global-set-key [C-f4] 'smtpmail-send-queued-mail)
(global-set-key [f5] 'mu4e)
;;(global-set-key [C-f5] (ido-switch-buffer (get-buffer "*mu4e-headers*")))
(global-visual-line-mode 1)
(delete-selection-mode 1)

; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: Tou must place this *before* any CEDET component (including
;; EIEIO) gets activated by another package (Gnus, auth-source, ...).
;;(load-file "~/.emacs.d/el-get/cedet/cedet-devel-load.el")




(setq ispell-auto-detect-encoding nil)
(setq-default ispell-program-name "aspell")
(setq ispell-dictionary "british-ise-w_accents"
  ispell-extra-args '() ;; TeX mode "-t"
  ispell-silently-savep t
  )

(setq flyspell-mode-map nil)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

(add-hook 'ispell-initialize-spellchecker-hook
      (lambda ()
    (setq ispell-base-dicts-override-alist
          '((nil ; default
         "[A-Za-z]" "[^A-Za-z]" "[']" t
         ("-d" "en_US" "-i" "utf-8") nil utf-8)
        ("american" ; Yankee English
         "[A-Za-z]" "[^A-Za-z]" "[']" t
         ("-d" "en_US" "-i" "utf-8") nil utf-8)
        ("british" ; British English
         "[A-Za-z]" "[^A-Za-z]" "[']" t
         ("-d" "en_GB" "-i" "utf-8") nil utf-8)))))

;; Get up and running, set custom to something else, and set up load paths
;; for the rest of the system. Then proceed to load each configuration file
;; for each module installed in emacs via load-cfg-files.
;;

(if (string-equal "darwin" (symbol-name system-type))
    (progn
      (push "/usr/local/bin" exec-path)
      (push "/usr/local/sbin" exec-path)
      (push "/usr/texbin" exec-path)
      (push "/usr/bin" exec-path)
      (push "/usr/sbin" exec-path)
      (push "~/.cabal/bin" exec-path)
      (setenv "PATH"
              (concat "/usr/local/bin:/usr/local/sbin:"
                      "~/.cabal/bin:"
                      "/usr/texbin:" (getenv "PATH")))
      (setenv "ERL_LIBS"
              (concat "/Users/th/Library/Erlang/lib/"))
      (set-fontset-font "fontset-default"
                        'unicode
                        '("Menlo" . "iso10646-1"))
      (set-frame-font "Menlo-11")
      (set-frame-size (selected-frame) 100 50)))

(add-hook 'before-make-frame-hook
      #'(lambda ()
          (add-to-list 'default-frame-alist '(left   . 0))
          (add-to-list 'default-frame-alist '(top    . 0))
          (add-to-list 'default-frame-alist '(height . 50))
          (add-to-list 'default-frame-alist '(width  . 120))))

;; from http://stackoverflow.com/questions/92971/how-do-i-set-the-size-of-emacs-window
(setq default-frame-alist
      '((top . 20) (left . 200)
        (width . 120) (height . 50)
        (font . "Menlo-11")))
        



(setq disabled-command-function nil)



;; Basic stuff we really need all the time
(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'ansi-color)

;;; needed for programming
(require 'thingatpt)

;;; package.el configuration
;; temp
;; (add-to-list 'load-path "/Users/th/.emacs.d")
;; (add-to-list 'load-path "/Users/th/.emacs.d/elpa/erlang-2.4.1")
(let ((default-directory "/Users/th/.emacs.d/elpa/"))
  (normal-top-level-add-subdirs-to-load-path))
;;; the manual dir contains packages that could not be installed using
;;; the Emacs package manager.  The manual/initialise.sh script clones
;;; the ones that are on public repos. Sholud there be other with more
;;; manual installation procedures they will be stated here.
;; (let ((default-directory "/Users/th/.emacs.d/manual/"))
;;   (normal-top-level-add-subdirs-to-load-path))
(require 'package)

(dolist (arch '(("org" . "http://orgmode.org/elpa/")
                ("gnu" . "http://elpa.gnu.org/packages/")
                ("melpa" . "http://melpa.milkbox.net/packages/")
                ("tromey" . "http://tromey.com/elpa/")
                ("marmalade" . "http://marmalade-repo.org/packages/")
                ))
  (add-to-list 'package-archives arch))
(package-initialize)




;;; customisations
(if (string-equal "darwin" (symbol-name system-type))
  (progn
    (set-frame-font "Menlo-11")))

(load-theme 'manoj-dark)


;; setting up the configs dir
(setq emacs-config-dir (file-name-directory
                        (or (buffer-file-name) load-file-name)))

(setq custom-file (concat emacs-config-dir "custom.el"))
(setq package-user-dir (concat emacs-config-dir "elpa"))
(setq abbrev-file-name (concat emacs-config-dir "abbrev_defs"))
(defconst *emacs-config-dir* (concat emacs-config-dir "/configs/" ""))

(add-to-list 'load-path (concat emacs-config-dir "/el-get"))


;;; el-get configuration
(add-to-list 'load-path (concat emacs-config-dir "/el-get/el-get"))
(let ((default-directory "/Users/th/.emacs.d/el-get"))
  (normal-top-level-add-subdirs-to-load-path))


(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (end-of-buffer)
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/el-get/recipes/")

(setq el-get-user-package-directory
      (concat user-emacs-directory "/configs"))




;; Now, set up some el-get-sources overrides for our programs
(setq el-get-sources
 '((:name el-get
    :type git
    :url "git://github.com/dimitri/el-get.git"
    :features el-get
    :compile "el-get.el")
   (:name erlang-emacs
	  :type git
	  :url "git@github.com:lehoff/erlang-emacs.git"
	  :features erlang-start)
;;   (:name elixir-mix
;;    :type elpa)
   ;; (:name elixir-yasnippets
			 ;;        :type elpa)
   (:name flymake-elixir
	  :type git
	  :url "git@github.com:syl20bnr/flymake-elixir.git")
   (:name ruby-end-mode
	  :type git
	  :url "git@github.com:rejeep/ruby-end.git")
   (:name magit
          :website "https://github.com/magit/magit#readme"
          :description "It's Magit! An Emacs mode for Git."
          :type github
          :pkgname "magit/magit"
          :depends (cl-lib git-modes)
          :info "."
          ;; let el-get care about autoloads so that it works with all OSes
          :build (if (version<= "24.3" emacs-version)
                     `(("make" ,(format "EMACS=%s" el-get-emacs) "all"))
                   `(("make" ,(format "EMACS=%s" el-get-emacs) "docs")))
          :build/berkeley-unix (("touch" "`find . -name Makefile`") ("gmake")))
;;  (:name egg
;;          :type git
;;	  :url "git@github.com:byplayer/egg.git")
   (:name exec-path-from-shell
	  :type elpa)
   (:name mac-grab-link
       :description
       "Download the mac-grab-link.el file."
       :type http
       :url "http://orgmode.org/w/?p=org-mode.git;a=blob_plain;f=contrib/lisp/org-mac-link.el"
       )
  
   (:name distel
	  :website "https://github.com/massemanet/distel"
	  :description "Distributed Emacs Lisp for Erlang."
	  :type github
	  :pkgname "massemanet/distel"
	  :info "doc"
	  :build `,(mapcar
		    (lambda (target)
		      (concat "make " target " EMACS=" el-get-emacs))
		    '("clean" "all"))
	  :load-path ("elisp")
       :features distel)
   ;; (:name magithub
   ;;        :after (progn
   ;;                 (global-set-key (kbd "C-c g") 'magit-status))
   ;; 	  )
   ))

;; Set up the packages that we are using
(setq my-packages
      (append
       '(
         auctex
         el-get
         idle-highlight-mode
         fuzzy
         popup
         auto-complete
;;         auto-complete-latex
;;         csv-mode
         dig
	 distel
         undo-tree
;;	 exec-path-from-shell
         expand-region
         erlang-emacs
	 elixir 
         elixir-mix
	 ruby-end-mode
         graphviz-dot-mode
         htmlize
         json js2-mode
         markdown-mode
         magit
;;         egg
         org-mode
;;         cedet
         ;;sml-mode
         ssh-config
         )
       (if (string-equal "darwin" (symbol-name system-type))
         '(growl)
         '())
       (mapcar 'el-get-source-name el-get-sources)))

;; Install all the packages
(el-get 'sync my-packages)
;; This is worth setting the first time you run, to wait on
;; the sync to complete
;; (el-get 'wait)

;; A function to load config files
(defun load-config-files (files)
  (dolist (f files)
    (load (expand-file-name
           (concat *emacs-config-dir* f)))
    (message "Loaded config file: %s" file)))


(load-config-files 
       '("defuns"
		     "global"
;;                     "init-tags"
;;                     "init-semantic"
                     "init-auto-complete"
		     "init-auctex"
		     "init-erlang"
		     "init-hippie-expand"
		     "init-org-mode"
		     "init-flymake"
		     "init-elixir"
                     "init-mu4e"
         "init-markdown"
		     ))

(when (eq system-type 'darwin)
  (exec-path-from-shell-initialize))

;; Get our custom configuration loaded
(load custom-file 'noerror)
;;; init.el ends here
(server-start)
