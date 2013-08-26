;; EQC Emacs Mode -- Configuration Start
(add-to-list 'load-path "/Users/th/Library/Erlang/lib/eqc-1.27.1/emacs/")
(autoload 'eqc-erlang-mode-hook "eqc-ext" "EQC Mode" t)
(add-hook 'erlang-mode-hook 'eqc-erlang-mode-hook)
(setq eqc-max-menu-length 30)
(setq eqc-root-dir "/Users/th/Library/Erlang/lib/eqc-1.27.1")
;; EQC Emacs Mode -- Configuration End

;; init.el --- Initialization file for my Emacs setup
;;; Commentary:
(when (eq system-type 'darwin) ;; mac specific settings
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

(global-visual-line-mode 1)
(delete-selection-mode 1)

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
          (add-to-list 'default-frame-alist '(width  . 100))))


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
(add-to-list 'load-path "/Users/th/.emacs.d")
(require 'package)
(package-initialize)

(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))



(if (string-equal "darwin" (symbol-name system-type))
  (progn
    (set-frame-font "Menlo-11")))

(load-theme 'manoj-dark)

(server-start)
