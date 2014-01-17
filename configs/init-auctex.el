;;(add-to-list 'load-path "/Users/th/tools/auctex/")
;;(add-to-list 'load-path "/Users/th/tools/auctex/preview")

(require 'tex-site)
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(add-hook 'text-mode-hook
            '(lambda ()
               (auto-fill-mode)))

(add-hook 'LaTeX-mode-hook
          'turn-on-auto-fill)
;;(add-hook 'LaTeX-mode-hook
;;	  'ac-l-setup)
(add-hook 'tex-mode-hook
          'turn-on-auto-fill)
(add-hook 'text-mode-hook
          (lambda () (abbrev-mode 1)))
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

; make PDF by default (can toggle with C-c C-t C-p
(add-hook 'TeX-mode-hook '(lambda () (TeX-PDF-mode 1)))

;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
;; taken from http://stackoverflow.com/questions/7899845/emacs-synctex-skim-how-to-correctly-set-up-syncronization-none-of-the-exi
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))


; these math abbrevs (` as prefix char) are also useful in TeX/ConTeXt files
;(require 'latex)                        ; defines LaTeX-math-mode
(add-hook 'TeX-mode-hook 'LaTeX-math-mode)
; Emacs help for \label, \ref, \cite.  Normally used only with
; LaTeX-mode but also useful with plain TeX + eplain and with ConTeXt, so:
(setq reftex-plug-into-AUCTeX t)
(add-hook 'TeX-mode-hook 'reftex-mode)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(setq TeX-source-correlate-method 'synctex)

;'(LaTeX-command "latex -synctex=1")

;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background  
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
(setq TeX-source-correlate-start-server t)

(defun lehoff/bind-latex-next-error ()
  "Bind <f5> to next error"
  (local-set-key (kbd "<f5>") 'TeX-next-error)
  (local-set-key (kbd "S-<f5>") 'TeX-previous-error))

(add-hook 'LaTeX-mode-hook 'lehoff/bind-latex-next-error)
















































