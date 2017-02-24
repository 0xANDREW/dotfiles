;; keys
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-w"     'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key [f12] 'comment-region)
(global-set-key [(control f12)] 'uncomment-region)
(global-set-key "\C-x\C-z" 'recompile)
(global-set-key (kbd "C-x g") 'magit-status)
;;

;; python breakpoint
(defun insert-settrace ()
"Insert set_trace statement."
(interactive)
(insert "\nimport pdb; pdb.set_trace()\n"))
;;

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(el-get 'sync)
;;

;; misc prefs
(define-key key-translation-map [?\C-h] [?\C-?])
(defalias 'yes-or-no-p 'y-or-n-p)
(mouse-wheel-mode t)
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(menu-bar-mode 0)
(load-theme 'tango-dark t)
(setq indent-tabs-mode nil)
(setq scroll-preserve-screen-position t)
(server-start)
(setq-default indent-tabs-mode nil)
(global-linum-mode t)
(setq compilation-scroll-output "first-error")
(global-unset-key (kbd "C-z"))
(setq make-backup-files nil)
(setq case-fold-search t)
(tool-bar-mode -1)
(show-paren-mode t)
;; (rainbow-mode t)
;; (rainbow-delimiters-mode t)
(column-number-mode 1)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; ohole is an idiot
(add-hook 'c-mode-common-hook (lambda () (interactive) (column-marker-1 80)))
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 80)))
;;

;; file modes (use ~/bin/emacs-alist.generator.py)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.scons$" . python-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . sgml-mode))
(add-to-list 'auto-mode-alist '("\\.pt$" . sgml-mode))
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.xml$" . sgml-mode))
;;

;; jade mode
(add-to-list 'load-path "~/.emacs.d/vendor/jade-mode-master")
(require 'sws-mode)
(require 'jade-mode)    
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
;;
