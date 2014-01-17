
(setq erl-top "/usr/lib/erlang")

(setq erlang-root-dir "/usr/lib/erlang")
;; (setq tools-ver "2.6.11")
;; (setq load-path (cons (concat erlang-root-dir "/lib/tools-" tools-ver "/emacs")
;;                       load-path))
(setq exec-path (cons (concat erlang-root-dir "/bin")
                      exec-path))


(require 'erlang-start)
;; (require 'distel)
;; (distel-setup)

;; Wrangler

;; install with brew!
;; (add-to-list 'load-path
;;              "/usr/local/Cellar/wrangler/0.9.3.1/share/wrangler/elisp")
(add-to-list 'load-path
             "~/tools/wrangler-git/elisp")
(require 'wrangler)

(add-hook 'erlang-mode-hook 'esk-prog-mode-hook)


;; Align (thanks @eproxus)
(add-hook 'align-load-hook
          (lambda ()
            (add-to-list 'align-rules-list
                         '(erlang-align
                           (regexp . ",\\(\\s-+\\)")
                           (repeat . t)
                           (modes quote (erlang-mode))))))

;; ;; edts for Erlang
;; (add-to-list 'load-path "~/git_repos/edts")
;; (require 'edts-start)

;; (setq edts-projects
;;       '(( ;; lotl
;;          (root       . "~/git_repos/lotl")
;;          (lib-dirs   . ("deps" "test")) 
;;          )))
        ;; ( ;; My awesome project.
        ;;  (name       . "awesome_stuff")
        ;;  (root       . "~/src/awesome_stuff")
        ;;  (node-sname . "awesome")
        ;;  (otp-path   . "~/otp/r15b02"
        ;;  (start-command . "./start-being-awesome.sh"))
        ;; ( ;; My other project.
        ;;  (name       . "other_stuff")
        ;;  (root       . "~/src/other_stuff")
        ;;  (node-sname . "not_as_awesome")
        ;;  (lib-dirs   . ("lib" "test")))))

(defun insert-erl-emacs-vars ()
  "Insert the right local variables."
  (interactive)
  (insert "%%% Local Variables:\n")
  (insert "%%% erlang-indent-level: 2\n")
  (insert "%%% End:"))
