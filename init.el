(setq gc-cons-threshold (* 10 1024 1024))
(setq message-log-max 10000)
(setq load-prefer-newer t)


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(auto-save-mode 0)
(setq make-backup-files nil)
(setq create-lockfiles nil)

;; Boot strap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(when (package-installed-p 'use-package)
  (add-to-list 'package-selected-packages 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-dialog-box nil)
(setq inhibit-startup-message t)

(fset 'yes-or-no-p #'y-or-n-p)
(fset 'display-startup-echo-area-message #'ignore)

(show-paren-mode 1)

(dolist (mode
	 '(tool-bar-mode
	   scroll-bar-mode
	   blink-cursor-mode
	   menu-bar-mode))
  (funcall mode 0))

(load "server")
(unless (server-running-p) (server-start))

(electric-pair-mode 1)

(put 'set-goal-column 'disabled nil)

(put 'narrow-to-region 'disabled nil)

(column-number-mode t)
(line-number-mode t)
(size-indication-mode t)

(setq fill-column 78)

(setq split-height-threshold 100)

(use-package package-utils
  :ensure t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (define-key evil-normal-state-map (kbd "C-o") 'pop-global-mark)
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
  (define-key evil-normal-state-map (kbd "g f") 'imenu))

(use-package evil-collection
  :after evil
  :ensure t
  :custom (evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init))

(use-package evil-mc
  :ensure t
  :config
  (global-evil-mc-mode 1))

(use-package evil-escape
  :ensure t
  :config
  (setq-default evil-escape-key-sequence "fd")
  (setq-default evil-escape-delay 0.2)
  (evil-escape-mode))

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (use-package expand-region
    :ensure t)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "r" 'anzu-query-replace-regexp
    "k"  'kill-this-buffer
    "d" 'deadgrep
    "e" 'find-file
    "b" 'switch-to-buffer
    "<SPC>" 'er/expand-region))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-nerd-commenter
  :ensure t
  :config
  (evil-leader/set-key
    "ci" 'evilnc-comment-or-uncomment-lines
    "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
    ;;"ll" 'evilnc-quick-comment-or-uncomment-to-the-line
    "cc" 'evilnc-copy-and-comment-lines
    "cp" 'evilnc-comment-or-uncomment-paragraphs
    "cr" 'comment-or-uncomment-region))

(use-package evil-magit
  :ensure t
  :config
  (add-to-list 'evil-insert-state-modes 'magit-log-edit-mode)
  (evil-leader/set-key
    "s" 'magit-status))

(use-package evil-exchange
  :ensure t
  :config
  (evil-exchange-install))

(use-package evil-lion
  :ensure t
  :config
  (evil-lion-mode))

(add-to-list 'auto-mode-alist '("\\.cpp$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.tpp$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.psgi$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.t\\'"  . cperl-mode))
(add-to-list 'auto-mode-alist '("cpanfile" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tmpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.*tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.*tml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("/\\(views\\|html\\|templates\\)/.*\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.*tt\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.*tt2\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.nqp\\'" . perl6-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.puml\\'" . puml-mode))
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . puml-mode))
(add-to-list 'auto-mode-alist '("\\.launch\\'" . xml-mode))

(defvar emacs-autosave-directory
  (concat user-emacs-directory "autosaves/"))

(setq-default indent-tabs-mode nil)
(setq auto-revert-interval 1
      inhibit-startup-message t
      initial-scratch-message nil
      ring-bell-function 'ignore
      set-language-environment "UTF-8"
      abbrev-file-name "~/.emacs.d/.abbrev")

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome-stable")

(use-package atom-dark-theme
  :ensure t
  :config
  (load-theme 'atom-dark 'NO-CONFIRM))

(use-package frame
  :config (add-to-list 'initial-frame-alist '(fullscreen . maximized)))

(use-package counsel
  :ensure t
  :after ivy
  :bind (("C-c h" . counsel-descbinds)
	 ("M-x" . counsel-M-x)
	 ("M-y" . counsel-yank-pop)
	 ("M-p" . ag-project)
	 ("C-c l" . counsel-locate)
	 ("C-x C-f" . counsel-find-file))
  :config
  (evil-leader/set-key
    "l"  'counsel-locate))

(use-package counsel-projectile
  :ensure t
  :preface (setq projectile-keymap-prefix (kbd "C-c p"))
  :hook (after-init . counsel-projectile-mode))

(use-package projectile
  :ensure t
  :config

  (setq projectile-indexing-method 'native)
  (setq projectile-enable-caching t)

  (defun eqyiel/projectile-current-project-files ()
    "Return a list of files for the current project."
    (let ((files (and projectile-enable-caching
                      (gethash (projectile-project-root) projectile-projects-cache))))
      ;; nothing is cached
      (unless files
        (when projectile-enable-caching
          (message "Empty cache. Projectile is initializing cache..."))
        (setq files
              (split-string
               (shell-command-to-string
                (concat
                 "fd '' --hidden "
                 (directory-file-name (projectile-project-root))))))
        ;; cache the resulting list of files
        (when projectile-enable-caching
          (projectile-cache-project (projectile-project-root) files)))
      (projectile-sort-files files)))

  (advice-add
   'projectile-current-project-files
   :override
   'eqyiel/projectile-current-project-files)
  (projectile-mode 1)
  (evil-leader/set-key
    "pf" 'counsel-projectile-find-file
    "pp" 'counsel-projectile-switch-project
    "ps" 'ag-project
    "pc" 'counsel-projectile-compile-project
    "pt" 'counsel-projectile-test-project))

(use-package ivy
  :ensure t
  :diminish ""
  :init
  (ivy-mode)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-use-selectable-prompt t)
  (setq ivy-count-format "(%d/%d) "))

(use-package ivy-rich
  :ensure t
  :config
  (ivy-rich-mode 1))

(use-package swiper
  :ensure t
  :config
  :bind (("M-o" . swiper)))

(use-package smex
  :ensure t
  :config
  (smex-initialize)
  (setq smex-completion-method 'ivy))

(use-package yasnippet
  :ensure t
  ;; :commands (yas-expand yas-hippie-try-expand)
  :mode ("/\\.emacs\\.d/snippets/" . snippet-mode)
  ;; :hook ((text-mode prog-mode)  . yas-minor-mode)
  :init
  (yas-global-mode)
  :config
  ;; (setq yas-verbosity 1)
  ;; (setq yas-snippet-dirs (list (concat user-emacs-directory "snippets")))
  ;; (setq yas-prompt-functions '(yas-ido-prompt yas-complete-prompt))
  ;; (yas-reload-all))
  )

(use-package yasnippet-snippets
  :ensure t)

(use-package company-flx
  :ensure t
  :config
  (with-eval-after-load 'company
    (add-hook 'company-mode-hook (lambda ()
				   (add-to-list 'company-backends 'company-capf)))
    (company-flx-mode +1)))

(use-package company
  :ensure t
  :bind (("M-TAB" . company-complete))
  :config
  (push #'company-capf company-backends)
  (setq company-idle-delay 0
        company-echo-delay 0
        company-tooltip-limit 20
        company-dabbrev-downcase nil
        company-tooltip-align-annotations t
        company-minimum-prefix-length 1
        company-selection-wrap-around t
        company-transformers '(company-sort-by-occurrence
                               company-sort-by-backend-importance))

  (defun check-expansion ()
    (save-excursion
      (if (looking-at "\\_>") t
        (backward-char 1)
        (if (looking-at "\\.") t
          (backward-char 1)
          (if (looking-at "->") t nil)))))

  (defun do-yas-expand ()
    (let ((yas/fallback-behavior 'return-nil))
      (yas/expand)))

  (defun tab-indent-or-complete ()
    (interactive)
    (cond
     ((derived-mode-p 'magit-mode) (magit-section-toggle (magit-current-section))
      (minibufferp)
      (minibuffer-complete))
     (t
      (indent-for-tab-command)
      (if (or (not yas/minor-mode)
              (null (do-yas-expand)))
          (if (check-expansion)
              (progn
                (company-manual-begin)
                (if (null company-candidates)
                    (progn
                      (company-abort)
                      (indent-for-tab-command)))))))))

  (defun tab-complete-or-next-field ()
    (interactive)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if company-candidates
            (company-complete-selection)
          (if (check-expansion)
              (progn
                (company-manual-begin)
                (if (null company-candidates)
                    (progn
                      (company-abort)
                      (yas-next-field))))
            (yas-next-field)))))

  (defun expand-snippet-or-complete-selection ()
    (interactive)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand))
            (company-abort))
        (company-complete-selection)))

  (defun abort-company-or-yas ()
    (interactive)
    (if (null company-candidates)
        (yas-abort-snippet)
      (company-abort)))

  (global-set-key [tab] 'tab-indent-or-complete)
  (global-set-key (kbd "TAB") 'tab-indent-or-complete)
  (global-set-key [(control return)] 'company-complete-common)

  (define-key company-active-map [tab] 'expand-snippet-or-complete-selection)
  (define-key company-active-map (kbd "TAB") 'expand-snippet-or-complete-selection)

  (define-key yas-minor-mode-map [tab] nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)

  (define-key yas-keymap [tab] 'tab-complete-or-next-field)
  (define-key yas-keymap (kbd "TAB") 'tab-complete-or-next-field)
  (define-key yas-keymap (kbd "M-TAB") 'yas-next-field)
  (define-key yas-keymap (kbd "C-g") 'abort-company-or-yas)

  (global-company-mode))


(use-package ycmd
  :bind (("M-." . ycmd-goto))
  :ensure t
  :config
  (set-variable 'ycmd-global-config "/usr/share/vim/vimfiles/third_party/ycmd/ycmd/default_settings.json")
  (set-variable 'ycmd-server-command '("python2" "/usr/share/vim/vimfiles/third_party/ycmd/ycmd"))

  (evil-define-key 'normal python-mode-map (kbd "g d") 'ycmd-goto)
  (evil-define-key 'normal go-mode-map (kbd "g h") 'ycmd-show-documentation)
  (evil-define-key 'normal go-mode-map (kbd "g d") 'ycmd-goto)

  (evil-define-key 'normal js2-mode-map (kbd "g d") 'ycmd-goto)
  (evil-define-key 'normal js2-mode-map (kbd "g h") 'ycmd-show-documentation)
  (evil-leader/set-key-for-mode 'js2-mode "r" 'ycmd-refactor-rename)

  (use-package flycheck-ycmd
    :ensure t
    :config
    (flycheck-ycmd-setup))

  (use-package company-ycmd
    :ensure t
    :config
    (company-ycmd-setup)))

(require 'ycmd)
;; (add-hook 'after-init-hook #'global-ycmd-mode)

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

(use-package flyspell
  :ensure t
  :config
  (setq flyspell-issue-message-flag nil)) ; performance

(use-package langtool
  :ensure t
  :config
  (setq langtool-java-classpath
	"/usr/share/languagetool:/usr/share/java/languagetool/*"))

(defun my/kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer
	(delq (current-buffer) (buffer-list))))

(defun my/toggle-maximize-buffer ()
  "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_)
    (progn
      (set-register '_ (list (current-window-configuration)))
      (delete-other-windows))))

(defun my/random-sort-lines (beg end)
  "Sort lines from BEG til END randomly."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ;; To make `end-of-line' and etc. to ignore fields.
	  ((inhibit-field-text-motion t))
	(sort-subr nil 'forward-line 'end-of-line nil nil
		   (lambda (s1 s2) (eq (random 2) 0)))))))

(use-package js2-mode
  :ensure t
  :config
  (setq js2-mode-hook
	'(lambda () (progn
		      (set-variable 'indent-tabs-mode nil))))
  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode))

(use-package js2-refactor
  :ensure t
  :config
  (add-hook 'js2-mode-hook #'js2-refactor-mode))

(use-package company-tern
  :ensure t
  :bind (("M-." . tern-find-definition))
  :config
  (evil-define-key 'normal js2-mode-map (kbd "g d") 'tern-find-definition)
  (add-to-list 'company-backends 'company-tern)
  (add-hook 'js2-mode-hook (lambda () (tern-mode))))

(use-package indium
  :ensure t)

(use-package web-mode
  :ensure t
  :defer t
  :config
  (setq-default web-mode-enable-auto-pairing t
		web-mode-enable-auto-opening t
		web-mode-enable-auto-indentation t
		web-mode-enable-block-face t
		web-mode-enable-part-face t
		web-mode-enable-comment-keywords t
		web-mode-enable-css-colorization t
		web-mode-enable-current-element-highlight t
		web-mode-enable-heredoc-fontification t
		web-mode-enable-engine-detection t
		web-mode-markup-indent-offset 2
		web-mode-css-indent-offset 2
		web-mode-code-indent-offset 2
		web-mode-style-padding 2
		web-mode-script-padding 2
		web-mode-block-padding 0
		web-mode-comment-style 2)
  (custom-set-faces
   '(web-mode-html-tag-face
     ((t (:foreground "#729fcf"))))
   '(web-mode-html-tag-bracket-face
     ((t (:foreground "#FFE84B"))))
   '(web-mode-current-element-highlight-face
     ((t (:foreground "#FF8A4B"))))
   '(web-mode-current-element-highlight-face
     ((t (:background "#000000"
		      :foreground "#FF8A4B")))))
  (add-hook 'web-mode-hook
	    '(lambda ()
	       (local-set-key (kbd "RET") 'newline-and-indent)
	       (setq smartparens-mode nil)))
  (add-hook 'web-mode-before-auto-complete-hooks
	    '(lambda ()
	       (let ((web-mode-cur-language
		      (web-mode-language-at-pos)))
		 (if (string= web-mode-cur-language "php")
		     (yas-activate-extra-mode 'php-mode)
		   (yas-deactivate-extra-mode 'php-mode))
		 (if (string= web-mode-cur-language "css")
		     (setq emmet-use-css-transform t)
		   (setq emmet-use-css-transform nil))))))

(use-package company-web
  :ensure t
  :defer t
  :config
  (add-to-list 'company-backends '(company-web-html))
  (add-to-list 'company-backends '(company-web-jade)))

(use-package json-mode
  :ensure t)

(use-package php-mode
  :ensure t)

(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy-sweet -q" nil t)))

(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
		  (perltidy-region)))

(defalias 'perl-mode 'cperl-mode)
(use-package cperl-mode
  :ensure t
  :bind (("C-c p" . perltidy-region)
	 ("C-c f" . perltidy-defun))
  :config
  (custom-set-faces
   '(cperl-hash-face  ((t)))
   '(cperl-array-face ((t))))
  (setq cperl-close-paren-offset -4
	cperl-continued-statement-offset 4
	cperl-indent-level 4
	cperl-tab-always-indent t
	cperl-indent-parens-as-block t))

(flycheck-define-checker my-perl
  "A Perl syntax checker using the Perl interpreter."
  :command ("/usr/bin/perl" "-w" "-c"
	    (eval (let ((options '()))
		    (when (projectile-project-p)
		      (push (concat "-I" (projectile-project-root)) options)
		      (push (concat "-I" (projectile-expand-root "lib")) options)
		      (when (projectile-verify-file "cpanfile")
			(push (concat "-I" (projectile-expand-root "local/lib/perl5")) options))
		      options)))
	    source)
  :error-patterns ((error line-start (minimal-match (message)) " at " (file-name) " line " line (or "." (and ", " (zero-or-more not-newline))) line-end))
  :modes (perl-mode cperl-mode)
  :next-checkers (my-perl-perlcritic))

(flycheck-define-checker my-perl-perlcritic
  "A Perl syntax checker using Perl::Critic."
  :command ("perlcritic" "--no-color" "--verbose" "%f:%l:%c:%s:%m (%e)\n"
	    (option "--severity" flycheck-perlcritic-verbosity flycheck-option-int)
	    source-original)
  :error-patterns ((info    line-start (file-name) ":" line ":" column ":" (any "1")   ":" (message) line-end)
		   (warning line-start (file-name) ":" line ":" column ":" (any "234") ":" (message) line-end)
		   (error   line-start (file-name) ":" line ":" column ":" (any "5")   ":" (message) line-end))
  :modes (cperl-mode perl-mode))

(add-to-list 'flycheck-checkers 'my-perl)
(add-to-list 'flycheck-checkers 'my-perl-perlcritic)

(defun my-cperl-mode-hook ()
  "Hook function for `cperl-mode'."
  (helm-perldoc:carton-setup)
  (flycheck-select-checker 'my-perl))
(add-hook 'cperl-mode-hook 'my-cperl-mode-hook)

(use-package helm-perldoc
  :ensure t)

(use-package perl6-mode
  :ensure t)

(use-package ag
  :ensure t
  :bind (("M-s" . counsel-projectile-ag)))

(use-package ace-window
  :bind(("C-x o" . ace-window))
  :ensure t
  :config
  (evil-leader/set-key "TAB" 'ace-window))

(use-package company-auctex
  :ensure t
  :config
  (company-auctex-init))

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(setq c-basic-offset 4)

(use-package cmake-mode
  :defer t
  :ensure t)

(use-package disaster
  :ensure t
  :config
  (define-key c-mode-base-map (kbd "C-c d") 'disaster))

(use-package clang-format
  :ensure t
  :config)

(use-package go-mode
  :ensure t
  :config)

(use-package go-playground
  :ensure t
  :config)

(use-package gorepl-mode
  :ensure t
  :config
  (add-hook 'go-mode-hook #'gorepl-mode))

(use-package gotest
  :ensure t
  :config
  (evil-leader/set-key-for-mode 'go-mode "t" 'go-test-current-file))

(defun my-go-save-hook()
  "Hook run after saving go files."
  (when (eq major-mode 'go-mode)
    (gofmt)))
(add-hook 'after-save-hook 'my-go-save-hook)

(use-package go-gopath
  :ensure t)

(use-package go-eldoc
  :ensure t
  :diminish eldoc-mode
  :config (add-hook 'go-mode-hook 'go-eldoc-setup))

(use-package org
  :ensure t
  :bind (("C-c c" . org-capture)
	 ("C-c a" . org-agenda))
  :config
  (evil-leader/set-key-for-mode 'org-mode
    "s" 'org-schedule
    "r" 'org-toggle-latex-fragment
    "d" 'org-deadline
    "D" 'my/org-todo-with-date
    "$" 'org-archive-subtree
    "c" 'org-set-category-property
    "P" 'org-set-property
    "t" 'org-set-tags)

  (evil-leader/set-key
    "oa" 'org-agenda
    "oc" 'org-capture)

  (add-hook 'org-capture-mode-hook 'evil-insert-state)
  (setq org-modules (append org-modules '(org-habit)))
  (setq org-habit-show-habits-only-for-today t)
  (setq org-habit-graph-column 80)
  (setq org-todo-keywords
	(quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
		(sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))
  (setq org-todo-keyword-faces
	(quote (("TODO" :foreground "red" :weight bold)
		("NEXT" :foreground "blue" :weight bold)
		("DONE" :foreground "forest green" :weight bold)
		("WAITING" :foreground "orange" :weight bold)
		("HOLD" :foreground "magenta" :weight bold)
		("CANCELLED" :foreground "forest green" :weight bold)
		("MEETING" :foreground "forest green" :weight bold)
		("PHONE" :foreground "forest green" :weight bold))))
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-agenda-files '("~/Dropbox/org"))
  (setq org-default-notes-file (concat org-directory "~/Dropbox/org/notes.org"))
  (setq org-src-tab-acts-natively t)
  (setq org-agenda-custom-commands
	'(
	  ("h" "Daily habits"
	   ((agenda ""))
	   ((org-agenda-show-log t)
	    (org-agenda-ndays 7)
	    (org-agenda-log-mode-items '(state))
	    (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp ":DAILY:"))))
	  ("c" . "My Custom Agendas")
	  ("cu" "Unscheduled TODO"
	   ((todo ""
		  ((org-agenda-overriding-header "\nUnscheduled TODO")
		   (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp)))))
	   nil
	   nil)))
  (setq org-capture-templates
	'(("t" "Todo" entry (file "~/Dropbox/org/index.org" "")
	   "* TODO %?\n"))))

(defun my/org-todo-with-date (&optional arg)
  (interactive "P")
  (cl-letf* ((org-read-date-prefer-future nil)
	     (my-current-time (org-read-date t t nil "when:" nil nil nil))
	     ((symbol-function #'org-current-effective-time)
	      #'(lambda () my-current-time)))
    (org-todo arg)))

(use-package org-journal
  :ensure t)

(use-package org-bullets
  :ensure t
  :config
  (setq org-ellipsis " …")
  (setq org-bullets-bullet-list '("•"))
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-projectile
  :bind (("C-c n p" . org-projectile:project-todo-completing-read)
	 ("C-c c" . org-capture))
  :ensure t
  :config
  (org-projectile-per-project)
  (setq org-projectile-per-project-filepath "TODO.org")
  (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
  (global-set-key (kbd "C-c n p") 'org-projectile-project-todo-completing-read))

(defun my/org-inline-css-hook (exporter)
  "Insert custom inline css to automatically set the background of code to whatever theme I'm using's background."
  (when (eq exporter 'html)
    (let* ((my-pre-bg (face-background 'default))
	   (my-pre-fg (face-foreground 'default))))))

(add-hook 'my/org-export-before-processing-hook #'my/org-inline-css-hook)

(use-package evil-org
  :ensure t
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme))))

(use-package magit
  :ensure t
  :bind (([remap magit-fetch-popup] . magit-pull-and-fetch-popup)
         ([remap magit-pull-popup] . magit-pull-and-fetch-popup)
         ("<f7>" . magit-status))
  :config
  (setq magit-auto-revert-mode nil)
  (remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
  (setq magit-display-buffer-function #'magit-display-buffer-fullcolumn-most-v1)
  (setq magit-completing-read-function #'ivy-completing-read)
  (setq magit-branch-prefer-remote-upstream '("master"))
  (setq magit-refs-pad-commit-counts t)
  (add-hook 'magit-mode-hook 'magit-svn-mode)
  (add-to-list 'git-commit-known-pseudo-headers "Ticket")
  (evil-leader/set-key
    "ms" 'magit-status
    "mb" 'magit-log-buffer-file
    "ml" 'magit-log))

(use-package orgit
  :ensure t
  :defer t)

(use-package gitconfig-mode
  :ensure t
  :defer t)

(use-package gitignore-mode
  :ensure t
  :defer t)

(use-package gitattributes-mode
  :ensure t
  :defer t)

(use-package git-timemachine
  :ensure t
  :defer t)

(use-package git-link
  :ensure t
  :defer t)

(use-package ediff
  :defer t
  :config
  (setq ediff-split-window-function #'split-window-horizontally))

(use-package magithub
  :after magit
  :ensure t
  :config
  (magithub-feature-autoinject t)
  (setq magithub-clone-default-directory "~/workspace"))

(use-package magit-todos
  :after magit
  :ensure t
  :config
  (magit-todos-mode))

(use-package gist
  :ensure t)

(use-package git-gutter+
  :ensure t)

(global-set-key (kbd "C-c k") 'kill-this-buffer)

(use-package sbt-mode
  :ensure t)

(use-package scala-mode
  :ensure t
  :config
  (setq scala-indent:step 4))

(use-package ensime
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package rustic
  :ensure t
  :config
  (add-hook 'rustic-mode-hook #'racer-mode))

(use-package flycheck-rust
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package racer
  :ensure t
  :bind (("M-." . racer-find-definition))
  :config
  (evil-define-key 'normal rust-mode-map (kbd "g d") 'racer-find-definition)
  (setq racer-cmd "~/.cargo/bin/racer")
  (setq racer-rust-src-path "~/.rust/src/"))

(use-package cargo
  :ensure t
  :config
  (evil-leader/set-key-for-mode 'rust-mode "t" 'cargo-process-current-file-tests))
(add-hook 'rust-mode-hook 'cargo-minor-mode)

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package highlight-symbol
  :ensure t)

(setq tramp-default-method "ssh")
(setq shell-file-name "/bin/bash")

(use-package helm-tramp
  :ensure t)

(defun my/shell-set-hook ()
  (when (file-remote-p (buffer-file-name))
    (let ((vec (tramp-dissect-file-name (buffer-file-name))))
      ;; Please change "some-hostname" to your remote hostname
      (when (string-match-p "some-hostname" (tramp-file-name-host vec))
	(setq-local shell-file-name "/usr/local/bin/bash")))))

(add-hook 'find-file-hook #'my/shell-set-hook)

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.mdwn\\'" . markdown-mode)
         ("\\.markdown" . markdown-mode))
  :config
  (setq markdown-command "pandoc")
  (add-hook 'markdown-mode-hook #'imenu-add-menubar-index))

(use-package writegood-mode
  :ensure t
  :commands (writegood-mode))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-copy-env "GOPATH"))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))


(use-package dockerfile-mode
  :ensure t)

(global-set-key (kbd "C-SPC") nil)

(use-package fcitx
  :ensure t)

(use-package protobuf-mode
  :ensure t)

(use-package eglot
  :ensure t
  :bind(("M-." . xref-find-definitions))
  :config
  (evil-define-key 'normal go-mode-map (kbd "g d") 'xref-find-definitions)
  (evil-define-key 'normal go-mode-map (kbd "M-.") 'xref-find-definitions)

  (evil-define-key 'normal rust-mode-map (kbd "g d") 'xref-find-definitions)
  (evil-define-key 'normal rust-mode-map (kbd "M-.") 'xref-find-definitions)

  (add-to-list 'eglot-server-programs '(rust-mode . (eglot-rls "~/.cargo/bin/rls")))
  (add-to-list 'eglot-server-programs '(go-mode . ("~/go/bin/bingo")))
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) . (eglot-cquery "/bin/ccls"))))

(require 'eglot)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'go-mode-hook 'eglot-ensure)
(add-hook 'rust-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'eglot-ensure)

(use-package anzu
  :ensure t
  :config
  (global-anzu-mode +1)
  (set-face-attribute 'anzu-mode-line nil
                      :foreground "yellow" :weight 'bold)
  (custom-set-variables
   '(anzu-mode-lighter "")
   '(anzu-deactivate-region t)
   '(anzu-search-threshold 1000)
   '(anzu-replace-threshold 50)
   '(anzu-replace-to-string-separator " => "))
  (define-key isearch-mode-map [remap isearch-query-replace]  #'anzu-isearch-query-replace)
  (define-key isearch-mode-map [remap isearch-query-replace-regexp] #'anzu-isearch-query-replace-regexp))

(use-package vagrant
  :ensure t)

(use-package popwin
  :ensure t
  :config
  (popwin-mode)
  (push '("*Cargo Run*" :height 30) popwin:special-display-config)
  (push '("*Go Test*" :height 30) popwin:special-display-config))

(use-package deadgrep
  :ensure t
  :config
  (evil-define-key 'normal deadgrep-mode-map (kbd "o") 'deadgrep-visit-result-other-window))

(use-package whitespace
  :defer t
  :config
  (setq whitespace-style '(face trailing tabs)
        whitespace-line-column 80))

(use-package ibuffer
  :defer t
  :bind ("<f8>" . ibuffer)
  :init
  (defalias 'list-buffers 'ibuffer)
  :config
  (setq ibuffer-expert 1)
  (setq ibuffer-show-empty-filter-groups nil)

  (add-hook 'ibuffer-hook
            (lambda ()
              (ibuffer-vc-set-filter-groups-by-vc-root)
              (unless (eq ibuffer-sorting-mode 'alphabetic)
                (ibuffer-do-sort-by-alphabetic))))

    ;; Use human readable Size column instead of original one

  (define-ibuffer-column size-h
    (:name "Size" :inline t)
    (cond
     ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
     ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
     (t (format "%8d" (buffer-size)))))

    ;; Modify the default ibuffer-formats

  (setq ibuffer-formats
        '((mark modified read-only locked vc-status-mini " "
                (name 18 18 :left :elide)
                " "
                (size-h 9 -1 :right)
                " "
                (mode 16 16 :left :elide)
                " "
                ;(vc-status 16 16 :left)
                ;" "
                filename-and-process))))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs              (if (executable-find "python") 3 0)
          treemacs-deferred-git-apply-delay   0.5
          treemacs-display-in-side-window     t
          treemacs-file-event-delay           5000
          treemacs-file-follow-delay          0.2
          treemacs-follow-after-init          t
          treemacs-follow-recenter-distance   0.1
          treemacs-git-command-pipe           ""
          treemacs-goto-tag-strategy          'refetch-index
          treemacs-indentation                2
          treemacs-indentation-string         " "
          treemacs-is-never-other-window      nil
          treemacs-max-git-entries            5000
          treemacs-no-png-images              nil
          treemacs-no-delete-other-windows    t
          treemacs-project-follow-cleanup     nil
          treemacs-persist-file               (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-recenter-after-file-follow nil
          treemacs-recenter-after-tag-follow  nil
          treemacs-show-cursor                nil
          treemacs-show-hidden-files          t
          treemacs-silent-filewatch           nil
          treemacs-silent-refresh             nil
          treemacs-sorting                    'alphabetic-desc
          treemacs-space-between-root-nodes   t
          treemacs-tag-follow-cleanup         t
          treemacs-tag-follow-delay           1.5
          treemacs-width                      35)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package vhdl-tools
  :ensure t
  :config
  (setq vhdl-basic-offset 4))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
 '(evil-collection-setup-minibuffer t)
 '(gorepl-command "~/go/bin/gore")
 '(magit-log-section-arguments (quote ("--decorate" "-n256")))
 '(org-agenda-files
   (quote
    ("/home/ben/Dropbox/org/habbits.org" "/home/ben/Dropbox/org/index.org" "~/workspace/perl6/Projective/TODO.org" "~/workspace/elisp/telmacs/TODO.org" "~/workspace/perl5/EMP/TODO.org" "~/workspace/uni/inside_my_iphone/TODO.org")))
 '(package-selected-packages
   (quote
    (winum magic-latex-buffer vhdl-tools anzu projectile-ripgrep ripgrep persp-projectile perspective magit-svn eyebrowse go-playground doom-modeline gorepl-mode markdown-toc wttrin speed-type xkcd eglot treemacs-projectile treemacs-evil treemacs slime-volleyball dad-joke window-number digitalocean hacker-typer go-dlv snippet gotest company-statistics google-this deadgrep vue-mode lsp-vue js-format jsfmt lsp-go rustic travis yasnippet-snippets sql-indent format-sql clippy inf-mongo mongo import-popwin popwin lsp-java flymake-cursor flymake-rust anaphora a quelpa-use-package quelpa ein-subpackages ein-notebook ein-loaddefs ein borg vagrant ox-gfm org-journal wolfram wolfram-mode magit-todos cargo minesweeper mines sweetgreen counsel-tramp electric-pair-mode electric-pair electric-operator nyan-mode auto-yasnippet weechat lsp-ui lspi-ui lsp-rust markdown-preview-mode markdown-mode+ cquery meghanada realgud google-c-style autodisass-java-bytecode counsel-spotify visual-regexp-steroids go-eldoc go-gopath autotetris-mode lsp-mode evil-collection flycheck-gometalinter notmutch counsel-dash markdown-mode notmuch helm-tramp company-tern go-mode godoctor html-check-frag yaml-tomato fcitx nginx-mode dockerfile-mode flyparens highlight-parentheses exec-path-from-shell indium xref-js2 js2-refactor restclient nodejs-repl js-auto-beautify flymake-lua company-lua lua-mode calfw-ical calfw-org flycheck-ycmd company-ycmd ycmd www-synonyms paste-of-code gitter tree-mode julia-shell flycheck-julia magithub package-lint test-simple erlang swift-mode clojure-mode slack request evil-exchange langtool evil-mc ess company-quickhelp elpy comapny-jedi company-jedi evil-avy ivy-hydra hydra evil-org fireplace evil-lion ztree yaml-mode which-key web-mode use-package tide smex skewer-mode racer python-mode php-mode perl6-mode package-utils ox-reveal org-projectile org-evil org-bullets mu4e-alert latex-preview-pane json-mode ivy-rich highlight-symbol helm-perldoc google-translate git-messenger git-gutter+ ggtags flycheck-rust flycheck-rtags flycheck-perl6 expand-region evil-surround evil-snipe evil-smartparens evil-nerd-commenter evil-mu4e evil-magit evil-leader evil-escape evil-cleverparens ensime elfeed-org elfeed-goodies editorconfig dumb-jump disaster counsel-projectile company-web company-irony company-go company-flx company-auctex company-anaconda cmake-mode cmake-ide clang-format calfw atom-dark-theme ag ace-window)))
 '(safe-local-variable-values
   (quote
    ((cperl-indent-subs-specially)
     (cperl-close-paren-offset . -2)
     (eval set-fill-column 120))))
 '(warning-minimum-level :error))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cperl-array-face ((t)))
 '(cperl-hash-face ((t)))
 '(web-mode-current-element-highlight-face ((t (:foreground "#FF8A4B"))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "#FFE84B"))))
 '(web-mode-html-tag-face ((t (:foreground "#729fcf")))))

;; not in repo
(load-file "~/.emacs.d/private.el")
