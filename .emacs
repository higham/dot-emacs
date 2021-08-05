; -*- coding: utf-8 orgstruct-heading-prefix-regexp: ";;; "; -*-

;;; * Initialization

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(setq inhibit-splash-screen t)       ; Don't want splash screen.
(setq inhibit-startup-message t)     ; Don't want any startup message.
(scroll-bar-mode 0 )                 ; Turn off scrollbars.
(tool-bar-mode 0)                    ; Turn off toolbars.
(fringe-mode 0)                      ; Turn off left and right fringe cols.
(size-indication-mode)               ; Show file size in status line.
(put 'dired-find-alternate-file 'disabled nil)
(mouse-avoidance-mode 'exile)        ; Move mouse pointer out of way of cursor.
(setq visible-bell 1)                ; Turn off sound.

;; No menus, but can turn back on with keypress.
(menu-bar-mode 0)
(global-set-key (kbd "<C-M-f2>") 'menu-bar-mode)

(setq confirm-nonexistent-file-or-buffer nil)
(fset 'yes-or-no-p 'y-or-n-p)        ; Change yes/no questions to y/n type.
(setq default-input-method 'TeX)     ; For C-\.

;;; * Package initialization
(require 'package)
(setq package-archives
      '(
        ("orgmode" . "https://orgmode.org/elpa/")
        ("melpa" . "http://melpa.org/packages/")
;;        ("gnu" . "http://elpa.gnu.org/packages/");  Only for AucTeX.
        )
      )
;; (setq package-quickstart t)
(when (< emacs-major-version 27)
  (package-initialize))

;; Install automatically if not already present.
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(setq use-package-enable-imenu-support t)

(eval-when-compile
  (setq use-package-enable-imenu-support t)
  (require 'use-package))
(require 'diminish)
(require 'bind-key)
(setq use-package-verbose t)
;; -----------------------------------------------------------------
(bind-key* "C-z" 'scroll-up-keep-cursor)

;; Next line need for bufler.
;; https://github.com/alphapapa/bufler.el/issues/70
(use-package map)

(set-default-coding-systems 'utf-8)

(use-package which-key
  ;; :load-path "~/dropbox/elisp/which-key"
  :config
  ;; (setq guide-key/highlight-command-regexp "rectangle")
  (which-key-mode)
  ;; (which-key-setup-minibuffer)
  (which-key-setup-side-window-bottom)
)

;; http://endlessparentheses.com/debug-your-emacs-init-file-with-the-bug-hunter.html
;; M-x bug-hunter-file [gives error about auctex].
(use-package bug-hunter
  ;; :load-path "~/dropbox/elisp/elisp-bug-hunter"
)

;; ------------------------------------------------------------
;; https://github.com/daviwil/dotfiles/blob/master/Emacs.org#startup-performance
;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))
;; ------------------------------------------------------------

;;; * System identification
;; Name went from all caps in <= 24.4 to upper/lower case in 24.5.
;; In 24.5 the variable is superseded by a function.  Change later.
(defun system-is-mac ()
  (interactive)
  "Return true if system is darwin-based (Mac OS X)"
  (string-equal system-type "darwin"))

(defun system-is-windows ()
  (interactive)
  "Return true if system is windows-based"
  (string-equal system-type "windows-nt"))

(defun system-is-XPS ()
(interactive)
"Return true if the system we are running on Fran's Dell XPS 13"
(string-equal system-name "FRAN-XPS"))

(defun system-is-MBP15 ()
(interactive)
"Return true if the system we are running on MacBook Pro 15"
(string-equal system-name "MacBook-15-NJH.local"))

(defun system-is-MBP13R ()
(interactive)
"Return true if the system we are running on MacBook Pro 13 Retina"
; Not sure why name varies.
(or (string-equal system-name "MacBook-13R-NJH.local")
    (string-equal system-name "MacBook13-2013") ;; High Sierra update
    (string-equal system-name "macbook13-2013") ;; Emacs 24.5.1
    (string-equal system-name "MacBook13-2013.local")
    (string-equal system-name "Fran-MBP13.local")
    (string-equal system-name "Fran-MBP13")
    (string-equal system-name "NJH-MBP13")
    (string-equal system-name "macbook-13r-njh") ))

(defun system-is-Dell ()
(interactive)
"Return true if the system we are running on Dell Xeon"
(string-equal system-name "Dell-Nick"))

(defun system-is-Chill ()
(interactive)
"Return true if the system we are running on Chillblast"
;; (string-equal system-name "DESKTOP-II9K04F")) ; OC VII.
;; (string-equal system-name "Nick-Chill")) ; Fusion tranquility.
; (string-equal system-name "Chillblast-Nick")) ; OC VII.
(string-equal system-name "e-10aux4sq4480")) ; Lenovo 520c (2021)

(defun system-is-Lenovo ()
(interactive)
"Return true if the system we are running on Lenovo 520c"
;; (string-equal system-name "DESKTOP-II9K04F")) ;
;; (string-equal system-name "Nick-Chill")) ; Fusion tranquility.
(string-equal system-name "DESKTOP-5FDC726")) ; Lenovo 520c

(defun system-is-iMac ()
(interactive)
"Return true if the system we are running on iMac"
(string-equal system-name "Nick-iMac.local"))

(defun system-is-LenovoWork ()
(interactive)
"Return true if the system we are running on iMac"
(string-equal system-name "DESKTOP-FRS0UAE"))

;;; * Backups

;; http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq delete-old-versions t ; delete excess backup files silently
 delete-by-moving-to-trash t
 make-backup-files t    ; backup of a file the first time it is saved.
 backup-by-copying t    ; don't clobber symlinks
 version-control t      ; version numbers for backup files
 delete-old-versions t  ; delete excess backup files silently
 delete-auto-save-files nil  ; keep autosave when saving file
 kept-old-versions 0    ; oldest versions to keep when a new numbered backup is made (default: 2)
 kept-new-versions 10   ; newest versions to keep when a new numbered backup is made (default: 2)
 auto-save-default t    ; auto-save every buffer that visits a file
 auto-save-timeout 30   ; secs idle time before auto-save (default: 30)
 auto-save-interval 200 ; keystrokes between auto-saves (default: 300)
 vc-make-backup-files t ; backup versioned files, not done by default
)

;; Can simplify next block by setting and using one backup dir variable - TODO!
(if (system-is-windows)
(progn
(setq my-backup-dest "c:/emacs_backups/")
; Removed r: on [2018-07-01 Sun 17:55] as Emacs is writing to C: anyway!
; "ACL errors" on writing to C: in Windows 10, hence:
; (if (system-is-Chill) (setq my-backup-dest "r:/emacs_backups/") )
(if (not (file-exists-p my-backup-dest))
        (make-directory my-backup-dest t))
;; (make-directory my-backup-dest t)
(setq backup-directory-alist
          `((".*" . , my-backup-dest)))
(setq auto-save-file-name-transforms   ;; Needed, else goes in curr dir!
          `((".*" , my-backup-dest t)))
))
(if (system-is-mac)
(progn
(if (not (file-exists-p "~/emacs_backups/"))
        (make-directory "~/emacs_backups/" t))
;; (make-directory "~/emacs_backups/" t)
(setq backup-directory-alist
          `((".*" . , "~/emacs_backups/")))
(setq auto-save-file-name-transforms   ;; Needed, else goes in curr dir!
          `((".*" , "~/emacs_backups/" t)))
))

;;; * Other misc setup stuff

;; Trying omitting this for Mac to see if clipboard problem solved.
;; If not, move back to top of file.
(if (system-is-windows)
(setq save-interprogram-paste-before-kill 1) ; Save clipbrd string before kill.
)

;; ---------------------------------------------------------------
;; Force calls to use previous instance of Emacs.
(require 'server)
(server-start)
;; (unless (server-running-p)
;;   (server-start))

;; ---------------------------------------------------------------
;; For edit-with-emacs extension.
;; (when (require 'edit-server nil t)
;;     (setq edit-server-new-frame nil)
;;     (edit-server-start))

(use-package edit-server
  :ensure t
  :commands edit-server-start
  :init (if after-init-time
              (edit-server-start)
            (add-hook 'after-init-hook
                      #'(lambda() (edit-server-start))))
  :config (setq edit-server-new-frame-alist
                '((name . "Edit with Emacs FRAME")
                  (top . 200)
                  (left . 200)
                  (width . 80)
                  (height . 25)
                  (minibuffer . t)
                  (menu-bar-lines . t)
                  (window-system . x))))
;; ---------------------------------------------------------------

;; http://www.jmdeldin.com/posts/2016/sunrise-and-sunsets-in-emacs.html
(setq calendar-latitude 53.482449)
(setq calendar-longitude -2.340598)
(setq calendar-location-name "Eccles, UK")

;----------------------------------------------------------------------
;; (use-package anzu
;;   :defer
;;   ;; :load-path "~/Dropbox/elisp/anzu"
;;   :config
;;   (global-anzu-mode 1)
;;   (set-face-attribute 'anzu-mode-line nil
;;                       :foreground "yellow" :weight 'bold)
;;   (custom-set-variables
;;    '(anzu-mode-lighter "")
;;    '(anzu-deactivate-region t)
;;    '(anzu-search-threshold 1000)
;;    '(anzu-replace-threshold 50)
;;    '(anzu-replace-to-string-separator " => "))
;;   (define-key isearch-mode-map [remap isearch-query-replace]  #'anzu-isearch-query-replace)
;;   (define-key isearch-mode-map [remap isearch-query-replace-regexp] #'anzu-isearch-query-replace-regexp)
;; )

                                        ; ----------------------------------------------------------------------
;; For latest ORG mode downloaded by me.
;; But now I use Elpa.
; (add-to-list 'load-path "~/Dropbox/elisp/org/lisp")
;; Next line seems needed to make org functions available outside org,
;; before org has been invoked (C-c d above).
(require 'org-install)

(setq org-clock-sound "C:\\Windows\\Media\\Alarm01.wav")

;; Customize status line.
(require 'diminish)
(diminish 'abbrev-mode)
;; (eval-after-load "org" '(diminish 'orgstruct-mode "OrgS"))

(setq frame-title-format "%f - %p"); Titlebar contains buffer name (only).

;; -----------------------------------------------------------------

;; (add-to-list 'load-path "~/dropbox/elisp/org/contrib/lisp")
;; (require 'org-drill)

;; Smooth scrolling 1 line per time (default is 5).
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; ------------------------------------------------
(use-package helpful
  :init
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

;; (use-package smex
;;   ;; :load-path "~/dropbox/elisp/smex-master"
;;   :init (smex-initialize)
;;   :bind (("M-x" . smex)
;;          ("M-X" . smex-major-mode-commands)
;;          ;; Next is the old M-x.
;;          ("C-c C-c M-x" . execute-extended-command))
;;   :config
;;   (setq smex-save-file "~/dropbox/.smex-items")
;; )

(use-package shrink-whitespace
  ;; :load-path "~/dropbox/elisp/shrink-whitespace"
  :bind ("M-SPC". shrink-whitespace)
)

;; (use-package aggressive-indent-mode
;;   :load-path "~/dropbox/elisp/aggressive-indent-mode"
;;   :config
;;   (global-aggressive-indent-mode 1)
;; )

;; http://pragmaticemacs.com/emacs/instant-scratch-buffer-for-current-mode/
; (require 'scratch)

;; http://pragmaticemacs.com/emacs/instant-scratch-buffer-for-current-mode/
;; (require 'scratch)

;; https://protesilaos.com/dotemacs
(use-package scratch
  :ensure
  :config
  (defun prot/scratch-buffer-setup ()
    "Add contents to `scratch' buffer and name it accordingly."
    (let* ((mode (format "%s" major-mode))
           (string (concat "Scratch buffer for: " mode "\n\n")))
      (when scratch-buffer
        (save-excursion
          (insert string)
          (goto-char (point-min))
          (comment-region (point-at-bol) (point-at-eol)))
        (forward-line 2))
      (rename-buffer (concat "*Scratch for " mode "*") t)))
  :hook (scratch-create-buffer-hook . prot/scratch-buffer-setup)
  ;; bind ("C-c s" . scratch)
  )

; ----------------- Neatly load some packages -----------------------
;; Dash is needed by ace-jump-buffer and wrap-region.
; If :defer on next line then ace-jump-buffer doesn't work.
(use-package dash) ;;                    :load-path "~/dropbox/elisp/dash")
(use-package s ) ;;          :defer t    :load-path "~/Dropbox/elisp/s")

(use-package git-timemachine
  :defer
  )
;; :load-path  "~/Dropbox/elisp/git-timemachine")

(use-package fill-column-indicator)

;; Removed since slow to load and I don't use it.
;; (setq diredp-hide-details-initially-flag nil) ;; Full details in listing.
;; (use-package dired+  ;; Cannot defer.
;;      :load-path "~/dropbox/elisp/"
;; )

; For describe-unbound-keys
(use-package unbound
   :load-path "~/dropbox/elisp/"
)

(global-set-key [S-f4] 'copy-from-above-command)
;; (use-package misc ;; Provided with Emacs.
;;   :bind ("S-<f4>" . copy-from-above-command)
;;           ;; Copy ARG characters - default to end of line.
;; )

;; http://endlessparentheses.com/faster-pop-to-mark-command.html
;; When popping the mark, continue popping until the cursor
;; actually moves
(defadvice pop-to-mark-command (around ensure-new-position activate)
  (let ((p (point)))
    (dotimes (i 10)
      (when (= p (point)) ad-do-it))))
(setq set-mark-command-repeat-pop t)

;; http://endlessparentheses.com/improving-emacs-file-name-completion.html
;; Extensions to ignore in filename completion in minibuffer.
(mapc (lambda (x)
        (add-to-list 'completion-ignored-extensions x))
      '(".aux" ".blg" ".exe"
        ".meta" ".out" ".pdf"
        ".synctex.gz" ".tdo" ".toc"
        "-pkg.el" "-autoloads.el"
        "auto/"))

;; ----------------------------------
;; recentf

;; [2021-01-11 Mon 21:42] Odd that use-package doesn't work (confirmed).
;; [2020-11-01 Sun 20:22] This is now built into Emacs.
;; [2020-08-07 Fri 11:32] Problems with C-0 on startup.
;; Has going back to original code really solved it?
;; (use-package recentf
;;   :init
;;   ;; Must come before mode is loaded, else my recent file not loaded.
;;   ;; (setq recentf-save-file "~/.recentf")
;;   (setq recentf-save-file (concat (getenv "HOME") "/.recentf"))
;;   :bind ("M-0" . recentf-open-files)
;;   :config
;;   ;; http://www.xsteve.at/prg/emacs/power-user-tips.html
;;   (setq recentf-max-saved-items 500)
;;   (setq recentf-max-menu-items 60)
;;   (setq recentf-auto-cleanup 120) ; Must use custom?
;;   (recentf-mode 1)
;; )

;; http://www.xsteve.at/prg/emacs/power-user-tips.html
;; Next line must come before mode is turned on
(setq recentf-save-file "~/.recentf")
(recentf-mode 1)
(setq recentf-max-saved-items 500)
(setq recentf-max-menu-items 60)
(setq recentf-auto-cleanup 120) ; Must use custom?
(global-set-key (kbd "M-0") 'recentf-open-files)

(defun xsteve-ido-choose-from-recentf ()
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive)
  (let ((home (expand-file-name (getenv "HOME"))))
    (find-file
     (ido-completing-read "Recentf open: "
                          (mapcar (lambda (path)
                                    (replace-regexp-in-string home "~" path))
                                  recentf-list)
                          nil t))))

;; http://www.masteringemacs.org/articles/2011/01/27/find-files-faster-recent-files-package/
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;; For Mac, useful to replace home by tilde.
;; Was C-x C-r, but I prefer to keep that for find-file-read-only.
(if (system-is-mac)
    (global-set-key (kbd "C-0") 'xsteve-ido-choose-from-recentf))
(if (system-is-windows)
    (global-set-key (kbd "C-0") 'ido-recentf-open))

; ----------------------------------------------------------------
; Interactive macro expansion as used by Jwiegley.
; https://github.com/joddie/macrostep
(use-package macrostep
  ;; :load-path "~/dropbox/elisp/macrostep"
  :bind ("C-c e m" . macrostep-expand))

;; http://pages.sachachua.com/.emacs.d/Sacha.html
(use-package undo-tree
;; With defer, the undo-tree-mode doesn't get properly set!
;;  :defer t
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode t)
;;    (setq undo-tree-visualizer-timestamps t)  ;; Use t to toggle
;;    (setq undo-tree-visualizer-diff t)        ;; Use d to toggle
    ))

;; https://irreal.org/blog/?p=8614
;; C-u C-x u to undo changes in region.
(setq undo-tree-enable-undo-in-region t)

; (require 'undo-tree)
; (global-undo-tree-mode)
; ------------------------------------------------------------
;; http://pragmaticemacs.com/emacs/dont-kill-buffer-kill-this-buffer-instead/
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; (add-to-list 'load-path "~/dropbox/elisp/browse-kill-ring")
(use-package browse-kill-ring
   :config
   (browse-kill-ring-default-keybindings)
)

;; http://www.blogbyben.com/2013/08/a-tiny-eshell-add-on-jump-to-shell.html
;; (add-to-list 'load-path "~/dropbox/elisp/shell-pop")
(use-package shell-pop
  :defer t
  :bind ("S-<f3>" . shell-pop)
)
;; (global-set-key [S-f3] 'shell-pop) ;; Default is buffer's dir.

;; Reload .emacs.
(global-set-key (kbd "M-<f12>")
  '(lambda () (interactive) (load-file "~/.emacs")))

;; These not needed with Magit 2.1.0.
;; git-modes
;; (add-to-list 'load-path "~/dropbox/elisp/git-modes-master")
;; require 'git-commit-mode)
;; (require 'gitconfig-mode)
;; (require 'gitignore-mode)

;; Helm ------------------------------------------------
;; If I decide to convert to use-package, see
;; http://pages.sachachua.com/.emacs.d/Sacha.html#unnumbered-14
;; http://writequit.org/org/settings.html#sec-1-34

(require 'helm-config)

;; https://github.com/emacs-helm/helm
;; async doesn't seem to be needed.
;; [Facultative] Only if you have installed async.
;; (add-to-list 'load-path "~/dropbox/elisp/async")

;; (add-to-list 'load-path "~/dropbox/elisp/helm")
;; (add-to-list 'load-path "~/dropbox/elisp/helm-bibtex")
;; (add-to-list 'load-path "~/dropbox/elisp/f")
;; (add-to-list 'load-path "~/dropbox/elisp/s")
;; (add-to-list 'load-path "~/dropbox/elisp/parsebib")

;; Next line gives error on loading - why?
;; Works fine once loaded.
;; (helm-autoresize-mode t)
;; (setq helm-autoresize-max-height 80)

;; See if other completion packages take over. [2021-04-10 Sat 17:37]
;; Consider redefining Smex keys.
;; (global-set-key (kbd "M-x") 'helm-M-x)

;; -----------------------------------------------------------------
;; helm-bibtex
;; The requires are not needed now I'm installing helm-bibtex from Melpa.
;; Next two are required in helm-bibtex.
;; (require 'f)
;; (require 'parsebib)
;; Next line needed only so 'bibtex-completion-open-pdf is known for C-c p.
(require 'helm-bibtex)
;; (setq helm-bibtex-bibliography
(setq bibtex-completion-bibliography
      '("~/texmf/bibtex/bib/la.bib"
        "~/texmf/bibtex/bib/misc.bib"
        "~/texmf/bibtex/bib/njhigham.bib"
        "~/texmf/bibtex/bib/njhigham_extra.bib"
        ))

(setq bibtex-completion-library-path
      '("~/pdf_papers/" "~/pdf_papers/higham/" "~/pdf_books/"
        "~/pdf_books/computing" "~/pdf_books/writing"
        "~/pdf_books/writing" "~/pdf_papers/tex/"
        "~/pdf_other/pdf_thesis/" ))
;; ;; This obsolete, but try anyway.
;; (setq helm-bibtex-library-path '("~/pdf_papers" "~/pdf_papers/higham"
;;                                 "~/pdf_books"))

;; Shouldn't be necessary, but PDF files not being found on Windows.
;; (setq helm-bibtex-library-path nil)
;; (setq helm-bibtex-pdf-field nil)
;; (setq bibtex-completion-pdf-field nil)

(setq helm-bibtex-pdf-symbol "#")

(if (system-is-mac)
  (setq helm-bibtex-pdf-open-function
    (lambda (fpath)
    (call-process "open" nil 0 nil "-a" "/Applications/Skim.app" fpath))))
;;  'helm-open-file-with-default-tool))

;; Now gives "symbol's function definition is void."
;; Commented out for now (docvew will be used?).
;; (if (system-is-mac)
;; ;; (setq bibtex-completion-pdf-open-function
;; (setq bibtex-completion-open-pdf
;;   (lambda (fpath)
;;     (call-process "open" nil 0 nil "-a" "/Applications/Skim.app" fpath)))
;; )

;; Got this working by trial and error, helped by
;; http#://stackoverflow.com/questions/2284319/opening-files-with-default-windows-application-from-within-emacs
;; (if (system-is-windows)
;;  (setq helm-bibtex-pdf-open-function    ;; Open PDF in Sumatra
;;     (lambda (fpath) (shell-command
;;              (concat "start /pgm SumatraPDF.exe -reuse-instance " fpath )))))

(if (system-is-windows)
(setq bibtex-completion-pdf-open-function       ;; Open PDF in Sumatra
;; (setq bibtex-completion-open-pdf       ;; Open PDF in Sumatra
;;  (setq helm-bibtex-open-pdf       ;; Open PDF in Sumatra
    (lambda (fpath) (shell-command
             (concat "start /pgm SumatraPDF.exe -reuse-instance " fpath )))))
;; -----------------------------------------------------------------
(use-package bibtex-actions
  :bind (("C-c b" . bibtex-actions-insert-citation)
         :map minibuffer-local-map
         ("M-b" . bibtex-actions-insert-preset))
  :after embark
  :config
  ;; Make the 'bibtex-actions' bindings and targets available to `embark'.
  (add-to-list 'embark-target-finders 'bibtex-actions-citation-key-at-point)
  (add-to-list 'embark-keymap-alist '(bibtex . bibtex-actions-map))
  (add-to-list 'embark-keymap-alist '(citation-key . bibtex-actions-buffer-map))
  ;; Make sure to set this to ensure 'bibtex-actions-open-link' command works correctly.
  (bibtex-completion-additional-search-fields '(doi url))
  (bibtex-completion-bibliography '("~/bib/references.bib")))

;; use consult-completing-read for enhanced interface
(advice-add #'completing-read-multiple :override #'consult-completing-read-multiple)

;; -----------------------------------------------------------------

;; Can't get this to work.  Nothing specfically on this found via Google.
;; I want to use this in all modes.
; (global-unset-key (kbd "C-c &"))
(global-set-key (kbd "C-x &") nil) ;; Remove prefix command set by yasnippet.
(global-set-key (kbd "C-c &") 'reftex-view-crossref)
;; (define-key (current-global-map) "\C-c&" 'reftex-view-crossref)
; (define-key global-map "\C-c&" nil)

;; -----------------------------------------------------------------

(use-package yasnippet
;;  :load-path "~/dropbox/elisp/yasnippet"
;;  :init
;;    (setq yas-minor-mode-map ;This MUST before (require 'yasnippet)
;;    (let ((map (make-sparse-keymap)))
;;      (define-key map [(tab)]     'yas-expand)
;;      (define-key map (kbd "TAB") 'yas-expand)
;;      ))
;;  :defer t
;  :demand  ;; Found this needed for yas to be turned on when first needed.
  :diminish yas-minor-mode
; :commands (yas-expand yas-minor-mode)
  :config
  (setq yas-snippet-dirs '("~/dropbox/elisp/snippets"))
  (yas-global-mode 1)
  ;; This works, but leaves C-c & as a prefix command, so cannot assign a
  ;; command to it.
  (setq yas-wrap-around-region 'cua)
  (define-key yas-minor-mode-map "\C-c&\C-s"       nil)
  (define-key yas-minor-mode-map "\C-c&\C-n"       nil)
  (define-key yas-minor-mode-map "\C-c&\C-v"       nil)
  ;; http://stackoverflow.com/questions/14066526/unset-tab-binding-for-yasnippet
  ;; ;      Wiegley's key defs:
  ;; :bind (("C-c y TAB" . yas-expand)
  ;;        ("C-c y s"   . yas-insert-snippet)
  ;;        ("C-c y n"   . yas-new-snippet)
  ;;        ("C-c y v"   . yas-visit-snippet-file))
)
;; http://stackoverflow.com/questions/36847624/how-to-unbind-prefix-commands-in-emacs
;; (global-set-key (kbd "C-c &") nil)
;; (local-unset-key (kbd "C-x &-"))
;; (add-hook 'yas-minor-mode-hook
;; 	  '(lambda()
;;             (define-key yas-keymap (kbd "C-x &") 'undefined)
;; 	     ))

;; ;; yasnippet
;; (add-to-list 'load-path "~/dropbox/elisp/yasnippet-master")
;; (require 'yasnippet)
;; (setq yas-snippet-dirs '("~/dropbox/elisp/yasnippet-master/snippets"))
;; (yas-global-mode 1)
;; (setq yas-wrap-around-region 'cua)

;; (use-package helm-c-yasnippet
;;   :disabled t
;;   ;; https://github.com/emacs-helm/helm-c-yasnippet
;;   ;; :load-path "~/dropbox/elisp/helm-c-yasnippet"
;;   :config
;;   (setq helm-yas-space-match-any-greedy t) ;[default: nil]
;;   (yas-global-mode 1)
;;   (yas-load-directory "~/dropbox/elisp/yasnippet/snippets")
;;   (setq helm-yas-display-key-on-candidate t)
;; )

; -------------------------------------------------------------------
;; ;; Navigate use-package definitions in .emacs.
;; ;; http://irreal.org/blog/?p=3979
(use-package imenu-anywhere
   ;; :load-path "~/dropbox/elisp/imenu-anywhere"
   :init (global-set-key (kbd "C-c =") 'imenu-anywhere)
)
;; No longer needed, since use-package now does this itself.
;;   :config (defun jcs-use-package ()
;;             (add-to-list 'imenu-generic-expression
;;              '("Used Packages"
;;                "\\(^\\s-*(use-package +\\)\\(\\_<.+\\_>\\)" 2)))
;;   (add-hook 'emacs-lisp-mode-hook #'jcs-use-package))

;; ;; Cannot get it to work.
;; ;; Cursor keys and C-v don't work in minibuffer!
;; (use-package icomplete-vertical
;;   :ensure t
;;   :demand t
;;   :custom
;;   (completion-styles '(partial-completion substring))
;;   (completion-category-overrides '((file (styles basic substring))))
;;   (read-file-name-completion-ignore-case t)
;;   (read-buffer-completion-ignore-case t)
;;   (completion-ignore-case t)
;;   :config
;;   (icomplete-mode)
;;   (icomplete-vertical-mode)
;;   :bind (:map icomplete-minibuffer-map
;;               ("<down>" . icomplete-forward-completions)
;;               ("C-n" . icomplete-forward-completions)
;;               ("<up>" . icomplete-backward-completions)
;;               ("C-p" . icomplete-backward-completions)
;;               ("C-v" . icomplete-vertical-toggle)))

(use-package selectrum
  ;; :bind (("C-M-r" . selectrum-repeat)  ;; Clashes with ctrlf.
  ;;        :map selectrum-minibuffer-map
  ;;        ("C-r" . selectrum-select-from-history)
;;         :map minibuffer-local-map
;;         ("M-h" . backward-kill-word)
;;       )
  :custom
;;  (selectrum-fix-minibuffer-height t)
;;   (selectrum-num-candidates-displayed 7)
  (selectrum-refine-candidates-function #'orderless-filter)
  (selectrum-highlight-candidates-function #'orderless-highlight-matches)
  :custom-face
;; (selectrum-current-candidate ((t (:background "#3a3f5a"))))
;; (selectrum-current-candidate ((t (:background "#adab8b"))))
  (selectrum-current-candidate ((t (:background "#8f8d72"))))
  :init
  (selectrum-mode 1))

(use-package selectrum-prescient
  :ensure t
  :config
  (selectrum-prescient-mode 1)
  (prescient-persist-mode 1))

;; ----------------------------------------------------
(use-package orderless
  :init (icomplete-mode) ; optional but recommended!
  :custom (completion-styles '(orderless))
  ;; :custom (completion-styles '(orderless-initialism orderless-literal
  ;;                             orderless-regexp))
  ;; :custom (completion-styles '(orderless-strict-leading=initialism))
  )

;; (defun my/match-components-literally ()
;;   "Components match literally for the rest of the session."
;;   (interactive)
;;   ;; (setq-local orderless-matching-styles '(orderless-literal)
;;   (setq-local orderless-matching-styles '(orderless-flex)
;;               orderless-style-dispatchers nil))

;; (define-key minibuffer-local-completion-map (kbd "C-l")
;;   #'my/match-components-literally)
;; ----------------------------------------------------

;; -----------------------------------------------------------------
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (("C-x M-:" . consult-complex-command)
         ;; ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-x b" . consult-buffer)
         ;; ("C-x 4 b" . consult-buffer-other-window)
         ;; ("C-x 5 b" . consult-buffer-other-frame)
         ;; ("C-x r x" . consult-register)
         ;; ("C-x r b" . consult-bookmark)
         ("M-g l"   . consult-goto-line)
         ("M-g M-l" . consult-goto-line)
         ;; ("M-g M-g" . consult-goto-line)
         ("M-s a"   . consult-apropos)
         ("M-s M-a" . consult-apropos)
         ("M-s m"   . consult-imenu)
         ("M-s M-m" . consult-imenu)
         ("M-s o"   . consult-outline)
         ("M-s M-o" . consult-outline)
         ("M-s l"   . consult-line)
         ("M-s M-l" . consult-line)
         ("M-g m" . consult-mark)          ;; Choose marks in buffer.
         ("M-g n" . consult-global-mark)   ;; Choose marks in all buffers.
         ("M-s r" . consult-git-grep)      ;; or consult-grep, consult-ripgrep
         ;; ("M-s f" . consult-find)          ;; or consult-locate, my-fdfind
         ;; ("M-s i" . consult-project-imenu) ;; or consult-imenu
         ("M-s e" . consult-error)
         ("M-s m" . consult-multi-occur)
         ;; ("M-y" . consult-yank-pop)
         ("C-h a" . consult-apropos))
  :config
      (setq consult-project-root-function #'vc-root-dir)
  )

(use-package embark
  :bind
  ;; ("C-S-a" . embark-act)  ; pick some comfortable binding
  ("C-#" . embark-act)
   ;; When using the Embark package, you can bind `marginalia-cycle' as an Embark action!
   (:map embark-general-map
          ("A" . marginalia-cycle)
   )
  :config
    ;; From https://github.com/daviwil/dotfiles/blob/master/Emacs.org
    ;; Show Embark actions via which-key
(setq embark-action-indicator
      (lambda (map _target)
        (which-key--show-keymap "Embark" map nil nil 'no-paging)
        #'which-key--hide-popup-ignore-command)
      embark-become-indicator embark-action-indicator))
  ;; (setq embark-action-indicator
  ;;       (lambda (map)
  ;;         (which-key--show-keymap "Embark" map nil nil 'no-paging)
  ;;         #'which-key--hide-popup-ignore-command)
  ;;       embark-become-indicator embark-action-indicator)
  ;; )
(add-hook 'org-mode-hook '(lambda ()
          (local-set-key (kbd "C-#") ' embark-act)
          ))

;; Doesn't work for me - has no effect.
;; https://github.com/minad/marginalia
(use-package marginalia
  :bind (
;;      Doesn't work for me.
      :map minibuffer-local-map
          ("S-C-a" . marginalia-cycle)
     )
  ;; :config
  :init
   (setq marginalia-annotators
        '(marginalia-annotators-heavy
          marginalia-annotators-light))
  ;; (setq marginalia-annotators
  ;;       '(marginalia-annotators-heavy marginalia-annotators-light nil))
  (marginalia-mode))

;; ;; https://writequit.org/denver-emacs/presentations/2017-04-11-ivy.html
;; ;; Ivy and Swiper
;; ;; require 'ivy)
;; ;; (use-package swiper
;; (use-package ivy
;;   :config
;; ;;  (progn
;;     (ivy-mode 1)
;; ;;    (setq enable-recursive-minibuffers t)  ;; Dangerous?
;;     (setq ivy-use-virtual-buffers t
;;           ivy-count-format "%d/%d ")
;;     (global-set-key (kbd "C-M-s") 'isearch-forward) ;; Keep isearch option.
;;     (global-set-key (kbd "C-M-r") 'isearch-backward)
;;     (global-set-key (kbd "C-s") 'swiper)
;;     (global-set-key (kbd "C-S-s") 'swiper-isearch)
;;     (global-set-key (kbd "<f6>") 'ivy-resume)
;;     (global-set-key (kbd "C-9")   'ivy-switch-buffer)
;;     (global-set-key (kbd "C-S-f") 'counsel-find-file)
;;     (global-set-key (kbd "C-c g") 'counsel-git)
;;     ;; (setq ivy-re-builders-alist '((t . orderless-ivy-re-builder)))
;;     )
;; ;; )

;; (use-package ivy-rich
;;   :init
;;   (ivy-rich-mode 1)
;;   :config
;;   (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

;; ;; https://melpa.org/#/embark-consult
;; ;; (with-eval-after-load 'consult
;; ;; (with-eval-after-load 'embark
;; ;;   (require 'embark-consult)))
;; (use-package avy-embark-collect)

(use-package embark-consult
  :config
  (add-hook 'embark-collect-mode-hook #'embark-consult-preview-minor-mode)
  )

;; http://mbork.pl/2014-04-04_Fast_buffer_switching_and_friends
(defun switch-bury-or-kill-buffer (&optional aggr)
  "With no argument, switch (but unlike C-x b, without the need
to confirm).  With C-u, bury current buffer.  With double C-u,
kill it (unless it's modified)."
  (interactive "P")
  (cond
   ((eq aggr nil) (switch-to-buffer (other-buffer)))
   ((equal aggr '(4)) (bury-buffer))
   ((equal aggr '(16)) (kill-buffer-if-not-modified (current-buffer)))))
(global-set-key (kbd "C-x C-b") 'switch-bury-or-kill-buffer)

;; M-s s to change search style within a search.
(use-package ctrlf
    :config
    (ctrlf-mode)
    (setq ctrlf-alternate-search-style 'fuzzy) ;; Style for  C-M-s/r.
    ;; Redefine fuzzy to allow line breaks.
    ;; Idea from https://emacs.stackexchange.com/questions/10582/search-for-string-ignoring-new-lines
(defun ctrlf-translate-fuzzy-literal (input)
  "Build a fuzzy-matching regexp from literal INPUT.
See `ctrlf-split-fuzzy' for how INPUT is split into subinputs.
Each subinput is quoted and the results are joined with \".*\"."
  (string-join (mapcar #'regexp-quote (ctrlf-split-fuzzy input)) "[ \t\r\n]*"))
)

;; ----------------------------------------------------
                                        ;
;; http://oremacs.com/2015/05/22/define-word/
(use-package define-word
;;  :load-path "~/dropbox/elisp/define-word"
  :bind (("M-g d" . define-word-at-point)
         ("M-g M-d" . define-word-at-point)
         ("M-g D" . define-word)))

;; org2blog
(use-package org2blog
  :defer
  :config
  ;; Load construct that has Wordpress username and password.
  (load-file "~/Dropbox/.emacs-wordpress")
  (setq org2blog/wp-show-post-in-browser 'show)
  (setq org2blog/wp-use-sourcecode-shortcode nil)
  (setq org2blog/wp-image-upload t)
  (add-hook 'org-mode-hook #'org2blog-maybe-start)
)
;; (require 'org2blog)

(defun o2l()
  "Log into org2blog."
  (interactive)
  (org2blog-user-login))

; (add-to-list 'load-path "~/dropbox/elisp/org2blog-org-8-support")
;; (add-to-list 'load-path "~/dropbox/elisp/org2blog")
;; (add-to-list 'load-path "~/dropbox/elisp/metaweblog-master")
;; (require 'org2blog-autoloads)
                                       ; (require 'xml-rpc)

;; Next two lines cause <pre> tags to be converted to WP sourcecode blocks.
;; (require 'htmlize)
;; (setq org2blog/wp-use-sourcecode-shortcode t)

;; (require 'netrc) ;; or nothing if already in the load-path
;; (setq blog (netrc-machine (netrc-parse "~/.netrc") "myblog" t))
;; (setq org2blog/wp-blog-alist
;;       '(("my-blog"
;;          :url "http://nickhigham.wordpress.com/xmlrpc.php"
;;          :username (netrc-get blog "login")
;;          :password (netrc-get blog "password"))))

(winner-mode 1)

;; Yow has gone in 24.4.
;; (setq yow-file "~/dropbox/yow.lines" )

(add-hook 'matlab-mode-hook
	  '(lambda()
     	     (local-unset-key (kbd "M-j")) ; Prefer mine.
     	     (local-unset-key (kbd "M-s")) ; Prefer mine.
	     ))

;; Don't let the cursor go into minibuffer prompt
;; http://ergoemacs.org/emacs/emacs_stop_cursor_enter_prompt.html
(setq minibuffer-prompt-properties (quote (read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)))

;; -----------------------------------------------------------
;; Bookmarks

;; Save bookmarks after every change.
(setq bookmark-save-flag 1)

(global-set-key (kbd "C-x [") 'point-to-register)
(global-set-key (kbd "C-x ]") 'jump-to-register)

(global-set-key [M-f6] 'write-region)
;; -----------------------------------------------------------

;;; * My macros

;; Load my keyboard macros.
;; (load-file "~/Dropbox/mymacros.macs")
;; (global-set-key (kbd "C-c n") 'norm2); Fails due to assumed search term.

(fset 'myequation
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([kp-home 92 98 101 103 105 110 123 101 113 117 97 116 105 111 110 125 92 110 111 116 97 103 return return 92 101 110 100 123 101 113 117 97 116 105 111 110 125 kp-home kp-up] 0 "%d")) arg)))

;; Recorded again using regexp. For several norms on same line must
;; convert starting from end of line due to greedy .*!
;; Converts \|..\|_2 into \normt{..}.
(fset 'norm2
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([201326629 92 92 124 92 40 46 42 92 41 92 92 124 95 50 13 92 92 110 111 114 109 116 123 92 49 125 13 46] 0 "%d")) arg)))
(global-set-key (kbd "C-c n") 'norm2)

;; Macro to convert "From.." to "Dear..." in mail buffer.
;; (fset 'my-make-dear
;;    (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([C-kp-home 19 45 61 kp-home kp-down 67108896 C-kp-right C-kp-right C-kp-right 23 68 101 97 114 32 C-kp-right kp-left 44 11 return] 0 "%d")) arg)))
(fset 'my-make-dear2
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([C-kp-home 19 45 61 45 61 return kp-home kp-down f4 134217850 44 kp-delete 68 101 97 114 C-kp-right C-kp-right kp-left 44 11 kp-enter kp-down] 0 "%d")) arg)))
(add-hook 'mail-mode-hook
           (lambda () (define-key mail-mode-map (kbd "<f6>") 'my-make-dear2)))
(add-hook 'mail-mode 'flyspell-mode)

;; For making LaTeX file from what-is blog posts.

(fset 'whatistex
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([C-kp-prior 19 98 101 103 105 110 123 100 111 99 117 13 home end 13 92 109 97 107 101 116 105 116 108 101 home down deletechar M-up M-up right 116 105 116 108 101 deletechar deletechar deletechar deletechar deletechar deletechar deletechar end 13 40 105 110 115 101 114 116 45 102 105 108 101 45 99 111 110 116 101 110 116 115 34 126 47 103 105 116 104 117 98 47 119 104 97 116 45 105 115 47 105 110 102 111 46 116 101 120 34 41 13 19 100 97 116 101 13 right 134217848 105 110 115 101 114 116 32 108 111 110 103 32 100 97 13 24 19] 0 "%d")) arg)))
(put 'whatistex 'kmacro t)
;; (defun myinsertinfo ()
;;   (interactive)
;;   (insert-file-contents "~/github/what-is/info.tex")

(defun whatis()
  (interactive)
   (find-file "~/Dropbox/org/whatis.org"))

;; (add-hook 'mail-mode-hook
;; 	  '(lambda()
;;              (local-set-key (kbd "f6") 'my-make-dear)
;; 	     ))

;; Autoindent (return acts as C-j).
(define-key global-map (kbd "RET") 'newline-and-indent)

;; http://www.wisdomandwonder.com/article/9862/handling-4-kinds-of-return-in-org-mode
(defun gcr/smart-open-line ()
  "Insert a new line, indent it, and move the cursor there.
   The current line is left alone, a new line is inserted, indented,
   and the cursor is moved there."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))
(global-set-key (kbd "S-<return>") 'gcr/smart-open-line)
;; Next command avoids any special Org indentation.
(global-set-key (kbd "C-M-<return>") 'electric-indent-just-newline)

;;------------------------
;; (add-to-list 'load-path "~/dropbox/elisp/git-gutter-master")
;; (require 'git-gutter)
;; (global-set-key [S-f12] 'git-gutter-mode)
(use-package git-gutter
  :bind (("S-<f12>" . git-gutter-mode)
))

;;------------------------
;; Case changes
(require 'toggle-case); http://www.northbound-train.com/emacs.html
(global-set-key [f8]     'toggle-case)
;; (global-set-key [C-f8]   'downcase-word)
;; (global-set-key [S-f8]   'capitalize-word)
(global-set-key [M-f8]   'title-case-string-region-or-line)
;; (global-set-key [S-M-f8] 'upcase-word)

;; ;; https://github.com/mrkkrp/fix-word
;; ;; http://emacs.stackexchange.com/questions/13970/fixing-double-capitals-as-i-type/13975#13975
;; ;; These work backwards when point between words.
;; (use-package fix-word
;; ;;  :load-path "~/dropbox/elisp/fix-word"
;;   :bind (("S-M-<f8>" . fix-word-upcase)
;;          ("C-<f8>"   . fix-word-downcase)
;;          ("S-<f8>"   . fix-word-capitalize)
;;          ))

;; https://karthinks.com/software/batteries-included-with-emacs/#fnref:4
(global-set-key (kbd "S-M-<f8>") 'upcase-dwim)
(global-set-key (kbd "C-<f8>") 'downcase-dwim)
(global-set-key (kbd "s-<f8>") 'capitalize-dwim)

(use-package fireplace
;;  :load-path "~/dropbox/elisp/fireplace"
)

;; http://ergoemacs.org/emacs/modernization_upcase-word.html
(defun toggle-letter-case ()
  "Toggle the letter case of current word or text selection.
Toggles between: `all lower`, `Init Caps`, `ALL CAPS`."
 (interactive)
 (let (p1 p2 (deactivate-mark nil) (case-fold-search nil))
   (if (region-active-p)
       (setq p1 (region-beginning) p2 (region-end))
     (let ((bds (bounds-of-thing-at-point 'word) ) )
       (setq p1 (car bds) p2 (cdr bds)) ) )

   (when (not (eq last-command this-command))
     (save-excursion
       (goto-char p1)
       (cond
        ((looking-at "[[:lower:]][[:lower:]]") (put this-command 'state "all lower"))
        ((looking-at "[[:upper:]][[:upper:]]") (put this-command 'state "all caps") )
        ((looking-at "[[:upper:]][[:lower:]]") (put this-command 'state "init caps") )
        ((looking-at "[[:lower:]]") (put this-command 'state "all lower"))
        ((looking-at "[[:upper:]]") (put this-command 'state "all caps") )
        (t (put this-command 'state "all lower") ) ) ) )

   (cond
    ((string= "all lower" (get this-command 'state))
     (upcase-initials-region p1 p2) (put this-command 'state "init caps"))
    ((string= "init caps" (get this-command 'state))
     (upcase-region p1 p2) (put this-command 'state "all caps"))
    ((string= "all caps" (get this-command 'state))
     (downcase-region p1 p2) (put this-command 'state "all lower")) )
   ) )
(global-set-key [C-S-f8] 'toggle-letter-case)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
;; Now can make region lowercase with C-x C-l or uppercase with C-x C-u.
;;------------------------

(global-set-key [S-insert]    'indent-rigidly)
(global-set-key [S-kp-insert] 'indent-rigidly)
;; Mac has no insert key, so:
(if (system-is-mac)
    (global-set-key (kbd "s-i") 'indent-rigidly)) ;; s = cmd

; http://stackoverflow.com/questions/6156286/emacs-lisp-call-function-with-prefix-argument-programmatically
(defun my-shift-left ()
  (interactive)
  (let ((current-prefix-arg '(-1))) ; C-u -1
  (call-interactively 'indent-rigidly)))
(global-set-key [S-delete]    'my-shift-left)
(global-set-key [S-kp-delete] 'my-shift-left)

;; How to get sharp key on Macbook Pro!
(if (system-is-mac)
(global-set-key (kbd "M-9") '(lambda () (interactive) (insert "#"))))

;;----------------------------------------------
;; http://xahlee.org/emacs/effective_emacs.html
;; But why the constant "50"?  Seems arbitrary!

(defun next-user-buffer ()
  "Switch to the next user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-user-buffer ()
  "Switch to the previous user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

(defun next-emacs-buffer ()
  "Switch to the next emacs buffer.
Emacs buffers are those whose name starts with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (not (string-match "^*" (buffer-name))) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-emacs-buffer ()
  "Switch to the previous emacs buffer.
Emacs buffers are those whose name starts with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (not (string-match "^*" (buffer-name))) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

;; http://jcubic.wordpress.com/2012/01/26/switching-between-buffers-with-the-same-major-mode-in-emacs
(defun buffer-same-mode (change-buffer-fun)
  (let ((current-mode major-mode)
        (next-mode nil))
    (while (not (eq next-mode current-mode))
      (funcall change-buffer-fun)
      (setq next-mode major-mode))))

(defun previous-buffer-same-mode ()
  (interactive)
  (buffer-same-mode #'previous-buffer))

(defun next-buffer-same-mode ()
  (interactive)
  (buffer-same-mode #'next-buffer))

(global-set-key (kbd "M-p")   'previous-user-buffer)
(global-set-key (kbd "M-n")   'next-user-buffer)
(global-set-key (kbd "C-S-p") 'previous-emacs-buffer)
(global-set-key (kbd "C-S-n") 'next-emacs-buffer)

(global-set-key (kbd "C-M-n") 'previous-buffer-same-mode)
(global-set-key (kbd "C-M-p") 'next-buffer-same-mode)

;; --------------------------------------
;; http://pragmaticemacs.com/emacs/make-quick-notes-with-deft/
(use-package deft)
(setq deft-directory "~/memo")
(setq deft-extensions '("org"))
(setq deft-default-extension "org")
(setq deft-text-mode 'org-mode)
(setq deft-use-filename-as-title t)
(setq deft-use-filter-string-for-filename t)
(setq deft-auto-save-interval 0)
;;key to launch deft
;; (global-set-key (kbd "C-c d") 'deft)

;; -------------------------------------------------
;; Elfeed
;; From http://cestlaz.github.io/posts/using-emacs-29%20elfeed/#.WLd6QxxBSRd
(setq elfeed-db-directory "~/Dropbox/elfeeddb")

(use-package elfeed
 :bind (:map elfeed-search-mode-map
	      ("q" . bjm/elfeed-save-db-and-bury)
	      ("Q" . bjm/elfeed-save-db-and-bury)
	      ("m" . elfeed-toggle-star)
	      ("M" . elfeed-toggle-star)
	)
)

(defun elfeed-mark-all-as-read ()
      (interactive)
      (mark-whole-buffer)
      (elfeed-search-untag-all-unread))

;;functions to support syncing .elfeed between machines
;;makes sure elfeed reads index from disk before launching
(defun bjm/elfeed-load-db-and-open ()
  "Wrapper to load the elfeed db from disk before opening"
  (interactive)
  (elfeed-db-load)
  (elfeed)
  (elfeed-search-update--force))

;;write to disk when quiting
(defun bjm/elfeed-save-db-and-bury ()
  "Wrapper to save the elfeed db to disk before burying buffer"
  (interactive)
  (elfeed-db-save)
  (quit-window))

;; [2017-03-05 Sun 14:16]
;; Why is the next def causing error about missing elfeed-expose?
;; It was working the other day!
;; http://pragmaticemacs.com/category/elfeed/
; (defalias 'elfeed-toggle-star
;  (elfeed-expose #'elfeed-search-toggle-all 'star))

;; Removed as this pkg is taking 1.845s to load!
;; (use-package elfeed-goodies
;;   :ensure t
;;   :config
;;   (elfeed-goodies/setup))

(setq elfeed-feeds
      '(
        ("http://xkcd.com/rss.xml" comics XKCD)
        ("http://irreal.org/blog/?feed=rss2" blog emacs)
        ("http://pragmaticemacs.com/feed/" blog Emacs)
        ("https://nibandmuck.com/" Nib and Muck)
        ("http://sachachua.com/blog/category/emacs-news/feed" blog Emacs)
))

;; Seems to need older version of Org to install!
;; (use-package elfeed-org
;;   :ensure t
;;   :config
;;   (elfeed-org)
;;   (setq rmh-elfeed-org-files (list "~/Dropbox/org/elfeed.org")))

;; -------------------------------------------------
;; Hydra

;; (add-to-list 'load-path "~/dropbox/elisp/hydra")
(use-package hydra
  :config
  (global-set-key (kbd "C-x m") 'hydra-major/body)
  (global-set-key (kbd "<f3>")   'hydra-bib-etc/body)
  (global-set-key (kbd "C-<f3>") 'hydra-dired/body)
)

(defhydra hydra-major (:color blue :columns 4)
  "major-mode"
  ("b" bibtex-mode "bibtex")
  ("l" latex-mode "latex")
  ("o" org-mode "org")
  ("s" lisp-mode "lisp")
  ("t" text-mode "text")
  ("c" 'toggle-truncate-lines "tog-trunc-lines")
  ("f" auto-fill-mode "auto-fill")
  ("h" html-mode "html")
  ("m" message-mode "msg")
  ("n" narrow-or-widen-dwim "narw-wide")
  ("r" read-only-mode "read-only")
  ("u" linum-mode "lin-num")
  ("q" nil "cancel")
)
(defhydra hydra-bib-etc (:color blue :columns 4)
  "bib"
  ("<f3>" helm-bibtex "helm-bibtex")
  ("<f4>" helm-resume "helm-resume")
  ;; ("b" (lambda () (interactive) (dired "~/bib")) "bib")
  ("b"  (dired "~/bib") "bib")
  ("d" (dired "~/texmf/bibtex/bib") "texmf/bib")
  ("c" (find-file "~/texmf/bibtex/bib/cut.bib") "cut")
  ("l" (find-file "~/texmf/bibtex/bib/la.bib") "la")
  ("h" (find-file "~/texmf/bibtex/bib/njhigham.bib") "higham")
  ("m" (find-file "~/texmf/bibtex/bib/misc.bib") "misc")
  ("e" (find-file "~/texmf/bibtex/bib/ode.bib") "ode")
  ("o" (switch-to-buffer "*org*") "org*")
;;    (find-file "~/texmf/bibtex/bib/ode.bib"))
;;   "ode")
   ("s" (find-file "~/texmf/bibtex/bib/strings.bib") "strings")
   ("x" (switch-to-buffer "*scratch*") "scratch*")
   ("t" (switch-to-buffer "*text*") "text*")
;; ("z" scratch "scratch-make")
   ("z" scratch)
)

(defhydra hydra-dired (:color blue)
   "dired"
;;  ("m"  (lambda () (interactive) (dired "~/memo"))
  ("m"  (dired "~/memo")   "memo")
  ("t"   (dired "~/tex") "tex")
  ("b"   (dired "~/matlab") "matlab")
  ("d"   (dired "~/dropbox") "dropbox")
  ("h"   (dired "~/") "home")
)

(global-set-key (kbd "M-<f5>")   'hydra-zoom/body)
(defhydra hydra-zoom (:color red)
    "zoom"
    ("g" text-scale-increase "in")
    ("l" text-scale-decrease "out")
    ("r" (text-scale-adjust 0) "reset")
    ;; ("r" (lambda () (interactive) (text-scale-adjust 0)) "reset")
    ("q" nil "quit"))

;; http://ericjmritz.name/2015/10/14/some-personal-hydras-for-gnu-emacs/
(defhydra hydra-move-org (:color red :columns 3)
  "Org movements"
  ("n" outline-next-visible-heading "next heading")
  ("p" outline-previous-visible-heading "prev heading")
  ("N" org-forward-heading-same-level "next heading at same level")
  ("P" org-backward-heading-same-level "prev heading at same level")
  ("u" outline-up-heading "up heading")
  ("g" org-goto "goto" :exit t))
(global-set-key (kbd "M-<f9>") 'hydra-move-org/body)

;; -------------------------------------------------
;; --------------------------------------------------------
;; http://endlessparentheses.com/emacs-narrow-or-widen-dwim.html
;; http://irreal.org/blog/?p=4771

(defun narrow-or-widen-dwim (p)
  "Widen if buffer is narrowed, narrow-dwim otherwise.
Dwim means: region, org-src-block, org-subtree, or defun,
whichever applies first. Narrowing to org-src-block actually
calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer is
already narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode)
         ;; `org-edit-src-code' is not a real narrowing
         ;; command. Remove this first conditional if you
         ;; don't want it.
         (cond ((ignore-errors (org-edit-src-code))
                (delete-other-windows))
               ((ignore-errors (org-narrow-to-block) t))
               (t (org-narrow-to-subtree))))
        ((derived-mode-p 'latex-mode)
         (LaTeX-narrow-to-environment))
        (t (narrow-to-defun))))

;; Next line gives an error for me.
;; (define-key endless/toggle-map "n" #'narrow-or-widen-dwim)

;; This line actually replaces Emacs' entire narrowing
;; keymap, that's how much I like this command. Only copy it
;; if that's what you want.
(define-key ctl-x-map "n" #'narrow-or-widen-dwim)
(add-hook 'LaTeX-mode-hook
          (lambda () (define-key LaTeX-mode-map "\C-xn" nil)))

;; Could use http://mbork.pl/2014-11-15_LaTeX-narrow-to-environment
;; instead for LaTeX only - seems more reliable.
;; But same function doesn't widen.
;; Invoke this with M-x.
(defun LaTeX-narrow-to-environment (&optional count)
  "Narrow buffer to current LaTeX environment (or COUNT
environments around point)"
  (interactive "p")
  (LaTeX-mark-environment count)
  (narrow-to-region (save-excursion
		      (goto-char (region-beginning))
		      (beginning-of-line)
		      (point))
		    (region-end))
  (deactivate-mark))

;;----------------------------------------------
;; From Emacs Starter Kit. See
(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))
;; (global-set-key (kbd "C-M-e") 'eval-and-replace)
;; Clashes with latex-extra command.

(defun lorem ()
  "Insert a lorem ipsum."
  (interactive)
  (insert
   "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do "
    "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim"
    "ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
    "aliquip ex ea commodo consequat. Duis aute irure dolor in "
    "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla "
    "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in "
    "culpa qui officia deserunt mollit anim id est laborum."))

;; https://github.com/bbatsov/crux
(use-package crux)

;;----------------------------------------------
;; Modified by NJH from
;; https://plus.google.com/113859563190964307534/posts/SK1vqiG9jv5
;; Doesn't work within expand-region, unfortunately.
(defun select-text-in-dollars()
(interactive)
(let (b1 b2)
(skip-chars-backward "^$")
(setq b1 (point))
(skip-chars-forward "^$")
(setq b2 (point))
(set-mark b1)
))
(add-hook 'LaTeX-mode-hook
          '(lambda ()
              (local-set-key (kbd "C-$") 'select-text-in-dollars)
;;              (local-unset-key (kbd "C-c C-d")) ; Prefer date.
;;              (define-key LaTeX-mode-map (kbd "<S-C-f12>") 'TeX-next-error)
	      ))
;; Not sure why this doesn't work within the add-hook.
(eval-after-load 'latex
;;     '(define-key LaTeX-mode-map (kbd "<S-C-f12>") 'TeX-next-error))
   '(progn
    (define-key LaTeX-mode-map (kbd "<S-C-f12>") 'TeX-next-error)
    (local-unset-key "\C-c\C-d") ; Prefer date.
    ))

;; [2019-01-02 Wed 19:45] removed next block as I'm now getting
;; "File mode specification error: (void-variable latex-extra-mode-map)"
;; and this is stopping other hooks running, notably AucTeX master file
;; is not working.
;; [2019-01-03 Thu 18:17] Could check if this was related to Org problems.
;;
;; (add-hook 'LaTeX-mode-hook #'latex-extra-mode) ; Activate latex-extra
;; ;; Disable C-c C-u from latex-extra (prefer LaTeX-star-environment below).
;; ;; Next line seemed to wipe out latex-extra and reftex key bindings:
;; ;; (add-hook 'LaTeX-mode-hook '(lambda () (define-key latex-extra-mode-map "" nil)))
;; ;; So replaced by this:
;; (add-hook 'LaTeX-mode-hook '(lambda () (define-key latex-extra-mode-map (kbd "C-c C-u") nil)))

;; (add-hook 'LaTeX-mode-hook
;; 	  '(lambda()
;;      	     (local-unset-key (kbd "C-c C-d")) ; Prefer date.
;; 	     ))

;; ----------------------------------------------------------
;; https://cestlaz.github.io/posts/using-emacs-33-projectile-jump/
(use-package dumb-jump
:bind (("M-g o" . dumb-jump-go-other-window)
("M-g j" . dumb-jump-go)
("M-g x" . dumb-jump-go-prefer-external)
("M-g z" . dumb-jump-go-prefer-external-other-window))
:config
;; (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
:init
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
(dumb-jump-mode)
(define-key dumb-jump-mode-map (kbd "C-M-p") nil)
(define-key dumb-jump-mode-map (kbd "C-M-g") nil)
(define-key dumb-jump-mode-map (kbd "C-M-q") nil)
)
;; ----------------------------------------------------------

;; http://irreal.org/blog/?p=5591
(use-package ace-link
  :init (ace-link-setup-default)
;;  :config (define-key org-mode-map (kbd "M-o") 'ace-link-org)
;; Why does the define-key line fail on loading?
)

;; ;; (add-to-list 'load-path "~/Dropbox/elisp/ace-jump-mode-master")
;; (use-package ace-jump-mode)
;; (define-key global-map (kbd "C-x SPC") 'ace-jump-mode)
;; ;; Default C-c SPC clashes with ORG mode.
;; (global-set-key (kbd "M-a") 'ace-jump-word-mode)
;; (global-set-key (kbd "M-c") 'ace-jump-char-mode)
;; (global-set-key (kbd "M-l") 'ace-jump-line-mode)

;; (add-to-list 'load-path "~/Dropbox/elisp/ace-jump-zap-master")
(use-package ace-jump-zap)
; dwim variants give standard zap or ace-jump-zap with C-u prefix.
; http://sachachua.com/blog/series/emacs-kaizen/
(global-set-key (kbd "M-z") 'ace-jump-zap-up-to-char-dwim)
(global-set-key (kbd "M-Z") 'ace-jump-zap-to-char-dwim)
;; Replacing:
;; (global-set-key (kbd "M-z") 'zap-up-to-char)
;; (global-set-key (kbd "M-Z") 'zap-to-char)  ;; default is M-z

;; ;; (add-to-list 'load-path "~/Dropbox/elisp/ace-jump-buffer")
;; (use-package ace-jump-buffer)
;; (global-set-key (kbd "M-b") 'ace-jump-buffer)
;; (global-set-key (kbd "M-B") 'ace-jump-same-mode-buffers)

;; --------------------------------------
;; https://protesilaos.com/dotemacs
(defun prot/buffers-major-mode (&optional arg)
    "Select buffers that match the current buffer's major mode.
With \\[universal-argument] produce an `ibuffer' filtered
accordingly.  Else use standard completion."
    (interactive "P")
    (let* ((major major-mode)
           (prompt "Buffers for ")
           (mode-string (format "%s" major))
           (mode-string-pretty (propertize mode-string 'face 'success)))
      (if arg
          (ibuffer t (concat "*" prompt mode-string "*")
                   (list (cons 'used-mode major)))
        (switch-to-buffer
         (read-buffer
          (concat prompt mode-string-pretty ": ") nil t
          (lambda (pair) ; pair is (name-string . buffer-object)
            (with-current-buffer (cdr pair) (derived-mode-p major))))))))
(global-set-key (kbd "M-b") 'prot/buffers-major-mode)

(defun prot-ibuffer-buffers-vc-root (&optional arg)
  "Select buffers that belong to the version controlled directory.
With optional prefix ARG (\\[universal-argument]) produce an
`ibuffer' filtered accordingly.  Else use standard completion."
  (interactive "P")
  (let* ((root (or (vc-root-dir)
                   (locate-dominating-file "." ".git")))
         (prompt "Buffers for VC"))
    (if root
        (if arg
            (ibuffer t (format "*%s %s*" prompt root)
                     (list (cons 'filename (expand-file-name root))))
          (switch-to-buffer
           (read-buffer
            (format "%s %s:" prompt root) nil t
            (lambda (pair) ; pair is (name-string . buffer-object)
              (with-current-buffer (cdr pair) (string= (vc-root-dir) root))))))
      (user-error "Not in a version-controlled directory"))))
(global-set-key (kbd "M-B") 'prot-ibuffer-buffers-vc-root)
;; --------------------------------------

;; http://whattheemacsd.com/init.el-03.html
;; Save point position between sessions
;; (require 'saveplace)
;; (if (version< emacs-version "25.0")
;;     (progn (setq-default save-place t))  ;; Emacs < 25.0)
;;     (progn (save-place-mode t)))
;; (setq-default save-place t)  ; Now seems needed in 25?
;; Emacs >= 25.0
(save-place-mode 1)
(setq save-place-file "~/dropbox/.places")

;; Needed now orgstruct has gone.  Setup incomplete - docs not helpful!
(use-package outshine)
(add-hook 'outline-minor-mode-hook 'outshine-mode)
(defvar outline-minor-mode-prefix "\M-#")
;; ----------------------------------------------------------
;; From http://lumiere.ens.fr/~guerry/u/emacs.el
;; (add-hook 'emacs-lisp-mode-hook 'turn-on-orgstruct++)
(add-hook 'emacs-lisp-mode-hook 'outshine-mode)
(add-hook 'mail-mode-hook 'outshine-mode)
;; (add-hook 'mail-mode-hook 'turn-on-orgstruct++)

;; http://pragmaticemacs.com/emacs/use-org-mode-tables-and-structures-in-emails-and-elsewhere/
;; (add-hook 'mail-mode-hook 'turn-on-orgtbl)
;; Commented out as orgtbl-hijacker overwrites various keys!
;; Invoke orgtbl-mode as needed.

;;----------------------------------------------

(use-package multiple-cursors
  :load-path "~/Dropbox/elisp/multiple-cursors-master"
  :bind (("C-S-m"       . mc/edit-lines)
         ("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-*"         . mc/mark-all-like-this)
         ("C-M-m"       . mc/mark-more-like-this)  ; MATLAB overrides this in Windows!
         ("C-c C-<"     . mc/mark-all-like-this))
)

(use-package wrap-region
;  :load-path "~/Dropbox/elisp/wrap-region"
  ; Deferred loading caused by next line stops package working
  ; until mode turned off then on again!
  ; :commands wrap-region-mode
  :diminish wrap-region-mode
  :config
  (wrap-region-add-wrappers
   '(("*" "*" nil org-mode)
     ("~" "~" nil org-mode)
     ("/" "/" nil org-mode)
     ("=" "=" "+" org-mode)
     ("_" "_" nil org-mode)
     ("$" "$" nil (org-mode latex-mode))
     ("[" "]")
     ("(" ")")
     ("`" "'")
    ))
    (wrap-region-global-mode t)
    (wrap-region-mode t)
    ;; (wrap-region-add-wrapper "$" "$" nil 'latex-mode)
    ;; (wrap-region-add-wrapper "[" "]")
    ;; (wrap-region-add-wrapper "(" ")")
    ;; (wrap-region-add-wrapper "`" "'")
)

(use-package expand-region
;  :load-path "~/Dropbox/elisp/expand-region.el-master"
;  :commands wrap-region-mode
  :bind (("C-@"  . er/expand-region)
         ("C-~" .  er/contract-region))
  :init
  ;; Trying :init because with :config this is done after LaTeX mode loaded.
  (defun er/add-latex-mode-expansions ()
  (make-variable-buffer-local 'er/try-expand-list)
  (setq er/try-expand-list (append
                            er/try-expand-list
                            '(LaTeX-mark-environment
                              ))))
  (add-hook 'LaTeX-mode-hook 'er/add-latex-mode-expansions)

  (defun er/add-text-mode-expansions ()
    (make-variable-buffer-local 'er/try-expand-list)
    (setq er/try-expand-list (append
                              er/try-expand-list
                              '(mark-paragraph
                                mark-page))))

  (add-hook 'text-mode-hook 'er/add-text-mode-expansions)
)

;;----------------------------------------------
;; popup tips
;; (add-to-list 'load-path "~/Dropbox/elisp/clippy-el-master")
(use-package clippy
  :config
  (global-set-key [M-f3] 'clippy-describe-function)
)

;;----------------------------------------------

(require 'sl)       ; Train!
(require 'zone)     ; Zone out!  M-x zone, M-x zone-leave-me-alone.

(when (system-is-windows)
;; This works fine on Windows but gives jerky repeating cursor on Mac.
;; Need a different approach for Mac - TODO!
;; Change cursor type for insert and overwrite modes.
;; http://www.emacswiki.org/emacs/ChangingCursorDynamically
(require 'cursor-chg)  ; Load the library
;; (toggle-cursor-type-when-idle 1) ; Turn on cursor change when Emacs is idle
(change-cursor-mode 1) ; Turn on change for overwrite, read-only, and input mode
;; Actual cursor type is set in custom below.
)

;;------------------------------------------------------------
;; http://xahlee.org/emacs/emacs_dired_open_file_in_ext_apps.html
(defun open-in-external-app ()
  "Open the current file or dired marked files in external app.
Works in Microsoft Windows, Mac OS X, Linux."
  (interactive)

  (let ( doIt
         (myFileList
          (cond
           ((string-equal major-mode "dired-mode") (dired-get-marked-files))
           (t (list (buffer-file-name))) ) ) )

    (setq doIt (if (<= (length myFileList) 5)
                   t
                 (y-or-n-p "Open more than 5 files?") ) )

    (when doIt
      (cond
       ((string-equal system-type "windows-nt")
        (mapc (lambda (fPath) (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t)) ) myFileList)
        )
       ((string-equal system-type "darwin")
        (mapc (lambda (fPath) (shell-command (format "open \"%s\"" fPath)) )  myFileList) )
       ((string-equal system-type "gnu/linux")
        (mapc (lambda (fPath) (shell-command (format "xdg-open \"%s\"" fPath)) ) myFileList) ) ) ) ) )
(global-set-key (kbd "<M-S-f9>") 'open-in-external-app)

;; http://whattheemacsd.com/setup-dired.el-02.html
;; Avoid uninteresting lines at top and bottom.
(defun dired-back-to-top ()
  (interactive)
  (beginning-of-buffer)
  (dired-next-line 4))

;; (define-key dired-mode-map
;;  (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)

(defun dired-jump-to-bottom ()
  (interactive)
  (end-of-buffer)
  (dired-next-line -1))

;; (define-key dired-mode-map
;;   (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom)

;;------------------------------------------------------------
(when (system-is-windows)
(use-package dired-quick-sort
  :config
    (setq ls-lisp-use-insert-directory-program t)      ;; use external ls
    (setq insert-directory-program "e:/cygwin/bin/ls") ;; ls program name
  ;; (when (system-is-mac)
  ;;   (setq ls-lisp-use-insert-directory-program t)      ;; use external ls
  ;;   (setq insert-directory-program "ls")          ;; ls program name
  ;; )
  (dired-quick-sort-setup)  ;; S for sorting hydra.
))

;; -----------------------------------------
;; (add-to-list 'load-path "~/Dropbox/elisp/mhayashi1120-Emacs-wgrep-f701229")
(use-package wgrep)


;; -----------------------------------------
;; From https://protesilaos.com/codelog/2021-07-24-emacs-misc-custom-commands/

;; Only need to type search string.  Does non-recursive search in curr dir.
(defvar prot-search--grep-hist '()
  "Input history of grep searches.")

;;;###autoload
(defun prot-search-grep (regexp &optional recursive)
  "Run grep for REGEXP.

Search in the current directory using `lgrep'.  With optional
prefix argument (\\[universal-argument]) for RECURSIVE, run a
search starting from the current directory with `rgrep'."
  (interactive
   (list
    (read-from-minibuffer (concat (if current-prefix-arg
                                      (propertize "Recursive" 'face 'warning)
                                    "Local")
                                  " grep for PATTERN: ")
                          nil nil nil 'prot-search--grep-hist)
    current-prefix-arg))
  (unless grep-command
    (grep-compute-defaults))
  (if recursive
      (rgrep regexp "*" default-directory)
    (lgrep regexp "*" default-directory)
    (add-to-history 'prot-search--grep-hist regexp)))

(defun prot-diff-buffer-dwim (&optional arg)
  "Diff buffer with its file's last saved state, or run `vc-diff'.
With optional prefix ARG (\\[universal-argument]) enable
highlighting of word-wise changes (local to the current buffer)."
  (interactive "P")
  (let ((buf))
    (if (buffer-modified-p)
        (progn
          (diff-buffer-with-file (current-buffer))
          (setq buf "*Diff*"))
      (vc-diff)
      (setq buf "*vc-diff*"))
    (when arg
      (with-current-buffer (get-buffer buf)
        (unless diff-refine
          (setq-local diff-refine 'font-lock))))))
(global-set-key [f6] 'prot-diff-buffer-dwim)

;; -----------------------------------------

;; -----  Screen.

;; Try these further [2015-11-01 Sun 21:53]:
;; (use-package frame-fns
;;   :load-path "~/dropbox/elisp/frame-fns.el"
;; )
;; Commented out [2020-10-30 Fri 20:53]:
;; (use-package frame-cmds
;;   :load-path "~/dropbox/elisp/frame-cmds.el"
;; )

;; Initial frame size.
;; Seems this must come after the above, else window is shorter!
(if (system-is-windows)
(setq default-frame-alist
;;      '((top . 10) (left . 650)      ; pixel offsets 100 and 900.
      '((top . 10) (left . 40)      ; For small screen.
;;        (width . 80) (height . 48)   ; width and height in pixels.
        (width . 80) (height . 30)   ; For small screen.
        )))

(if (system-is-MBP15)
(setq default-frame-alist
      '((top . 35) (left . 550)      ; Little effect with smaller values!
        (width . 80) (height . 35)
        )))

(if (system-is-MBP13R)
(setq default-frame-alist
      '((top . 35) (left . 390)
        (width . 80) (height . 30)
        )))

;; Smaller screen for Dell XPS.
(if (system-is-XPS)
(setq default-frame-alist
      '((top . 10) (left . 495)
        (width . 80) (height . 30)
        )))

;; 27" screen for Chillblast.
;; (if (or (system-is-Chill) (system-is-iMac) (system-is-Dell))
(if (or (system-is-Chill) (system-is-iMac) (system-is-Lenovo))
(setq default-frame-alist
      '((top . 35) (left . 1600)
        (width . 81) (height . 55)
        )))

;; Fran's Lenovo 27" screen.
(if (or (system-is-LenovoWork))
(setq default-frame-alist
      '((top . 45) (left . 2300)
        (width . 81) (height . 55)
        )))

;; 24" screen for Dell.
(if (system-is-Dell)
(setq default-frame-alist
      ;; '((top . 10) (left . 1025)
      '((top . 10) (left . 1010)
        (width . 81) (height . 48)
        )))

;; https://www.emacswiki.org/emacs/FrameParameters
(add-to-list 'default-frame-alist '(foreground-color . "white"))
(add-to-list 'default-frame-alist '(background-color . "black"))
(add-to-list 'default-frame-alist '(cursor-color . "yellow"))
;; Are last two lines needed - seemed to have no effect.
;; Black b/g was set by line -4 of emacs-custom_windows.
(set-foreground-color "white")
(set-background-color "black")
;; (set-face-background 'region "gray") ; Set region background color
;; seashell4  at http://www.raebear.net/computers/emacs-colors/
(set-face-background 'region "#8b8682")
(set-cursor-color "yellow")

;; https://emacs.stackexchange.com/questions/16313/new-frame-does-not-respect-default-font
(if (system-is-windows)
  (set-frame-font "Consolas-12:bold" nil t)
  (add-to-list 'default-frame-alist '(font . "Consolas-12:bold" )))

;; (add-to-list 'custom-theme-load-path "~/Dropbox/elisp/emacs-color-theme-solarized-master")
;; (load-theme 'solarized-dark t)

(setq cursor-type 'bar)
(show-paren-mode 1)

;; ----- Enable Line and Column Numbering
;; Show line-number in the mode line
(line-number-mode 1)
;; Show column-number in the mode line
(column-number-mode 1)

;; Use spaces instead of tabs.
(setq-default indent-tabs-mode nil)

;; Keep point at the same screen position when scrolling.
(setq scroll-preserve-screen-position 1)

;; Turn on font-lock mode to color text in certain modes.
(global-font-lock-mode t)

(if (system-is-mac)
    (progn
    ;; Ensure aspell is used on Mac; not necessary on Windows..
    (setq ispell-program-name "/opt/local/bin/aspell")
    ;; Necessary for Auctex to be found with my Emacs 24 setup on Mac.
    (add-to-list 'load-path "/usr/share/emacs/site-lisp")
    ;; Next setting seems to be enough to get Mac Emacs to not open new
    ;; window when called from command line.
    ;; http://stackoverflow.com/questions/945709/emacs-23-os-x-multi-tty-and-emacsclient
    (setq ns-pop-up-frames nil)
))

;; http://xahlee.org/emacs/emacs_copy_cut_current_line.html
;; Allows C-w, M-w to work on line if no region marked.
;; This requires transient-mark-mode to be on.
(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy the current line."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (progn
       (message "Current line is copied.")
       (list (line-beginning-position) (line-beginning-position 2)) ) ) ))

(defadvice kill-region (before slick-copy activate compile)
  "When called interactively with no active region, cut the current line."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (progn
       (list (line-beginning-position) (line-beginning-position 2)) ) ) ))

;; Commands from windmove.el.
;; Don't use C-S-*, as that is an Org mode key sequence.
(global-set-key [C-M-left]  'windmove-left)      ; move to left window
(global-set-key [C-M-right] 'windmove-right)     ; move to right window
(global-set-key [C-M-up]    'windmove-up)        ; move to upper window
(global-set-key [C-M-down]  'windmove-down)      ; move to downer window

;; http://www.reddit.com/r/emacs/comments/gjqki/is_there_any_way_to_tell_emacs_to_not/c1o26uk
(defun toggle-sticky-buffer-window ()
  "Toggle whether this window is dedicated to this buffer."
  (interactive)
  (set-window-dedicated-p
   (selected-window)
   (not (window-dedicated-p (selected-window))))
  (if (window-dedicated-p (selected-window))
      (message "Window is now dedicated.")
    (message "Window is no longer dedicated.")))
(global-set-key [M-f2] 'toggle-sticky-buffer-window)

;; -----------------------------------------------------------
;; https://protesilaos.com/codelog/2020-08-03-emacs-custom-functions-galore/
;; `prot/window-single-toggle' is based on `windower' by Pierre
;; Neidhardt (ambrevar on GitLab)
;; This is a dummy package but doesn't work with auto updating.
;; (use-package emacs
;;   :config
  (defvar prot/window-configuration nil
    "Current window configuration.
     Intended for use by `prot/window-monocle'.")

  (define-minor-mode prot/window-single-toggle
    "Toggle between multiple windows and single window.
     This is the equivalent of maximising a window.  Tiling window
     managers such as DWM, BSPWM refer to this state as 'monocle'."
    :lighter " [M]"
    :global nil
    (if (one-window-p)
        (when prot/window-configuration
          (set-window-configuration prot/window-configuration))
      (setq prot/window-configuration (current-window-configuration))
      (delete-other-windows)))

  ;; :bind (("M-<f4>" . prot/window-single-toggle)))
(global-set-key [M-f4] 'prot/window-single-toggle)
;; -----------------------------------------------------------

;; Let minibuffer grow for ido
;; http://stackoverflow.com/questions/1775898/emacs-disable-line-truncation-in-minibuffer-only
(setq resize-mini-windows t)    ; grow and shrink as necessary
(setq max-mini-window-height 3) ; grow up to max of 3 lines
;; Next line needed for the above to work, since I set truncate-lines to
;; t below.
(add-hook 'minibuffer-setup-hook
      (lambda () (setq truncate-lines nil)))

;; ibuffer-vc
;; (add-to-list 'load-path "~/Dropbox/elisp/ibuffer-vc-master")
(use-package ibuffer-vc)

;;  Doesn't work.
;; (defun old-find-file()
;;   "Call old find-file that is hidden by ido."
;;   (interactive "p")
;;   (ido mode 0)
;;   (find-file)
;;   (ido mode 1)
;;   )
;; (global-set-key (kbd "C-S-f") 'old-find-file)

;; Ido mode.
;; http://www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode/
(ido-mode 1)
(setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)  ;; Makes no difference!
(setq ido-create-new-buffer 'always)
(setq ido-enable-tramp-completion nil)
(setq ido-max-directory-size 1000000)

(setq ido-use-filename-at-point 'guess)  ;; Great on URL!
(setq ido-use-url-at-point t)
(setq ido-use-virtual-buffers t)         ;; Uses old buffers from recentf.

;; This doesn't seem to have any effect.  Time order is better, anyway?
(setq ido-file-extensions-order '(".tex" ".m" ".bib" ".txt" ".emacs"))

;; For Mac: ignore .DS_Store files with ido mode
(add-to-list 'ido-ignore-files "\\.DS_Store")

;; http://whattheemacsd.com/
;; Just press ~ to go home when in ido-find-file.
(add-hook 'ido-setup-hook
 (lambda ()
   ;; Go straight home
   (define-key ido-file-completion-map
     (kbd "~")
     (lambda ()
       (interactive)
       (if (looking-back "/")
           (insert "~/")
         (call-interactively 'self-insert-command))))))

;; isearch
;; http://www.masteringemacs.org/articles/2011/07/20/searching-buffers-occur-mode/
;; To enter Occur from an isearch (instead of default M-s o).
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

;; Search backwards and forwards after an initial isearch.
(global-set-key (kbd "<kp-subtract>") 'isearch-repeat-backward)
(global-set-key (kbd "<kp-add>")      'isearch-repeat-forward)

;; Ctrl-return exits isearch at start of string (return: end of string).
;; http://www.emacswiki.org/emacs/ZapToISearch
(defun isearch-exit-other-end (rbeg rend)
  "Exit isearch, but at the other end of the search string.
This is useful when followed by an immediate kill."
  (interactive "r")
  (isearch-exit)
  (goto-char isearch-other-end))

(define-key isearch-mode-map [(control return)] 'isearch-exit-other-end)

;; http://irreal.org/blog/?p=2731,
;; http://demonastery.org/2013/04/emacs-narrow-to-region-indirect/
(defun narrow-to-region-indirect-buffer (start end)
  (interactive "r")
  (with-current-buffer (clone-indirect-buffer
                        (generate-new-buffer-name
                         (concat (buffer-name) "-indirect-"
                                 (number-to-string start) "-"
                                 (number-to-string end)))
                        'display)
    (narrow-to-region start end)
    (deactivate-mark)
    (goto-char (point-min))))
;; (define-key global-map (kbd "C-x n b") 'narrow-to-region-indirect-buffer)

(defun prelude-google ()
  "Googles a region, if any, or prompts for a Google search string."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (if mark-active
        (buffer-substring (region-beginning) (region-end))
      (read-string "Google: ")))))
; (global-set-key (kbd "C-x C-g") 'prelude-google)
(global-set-key (kbd "M-g M-g") 'prelude-google)
(global-set-key (kbd "M-g g")   'prelude-google)

(defun duckduckgo ()
  "Googles a region, if any, or prompts for a Google search string."
  (interactive)
  (browse-url
   (concat
    "https://duckduckgo.com/"
    (if mark-active
        (buffer-substring (region-beginning) (region-end))
      (read-string "DuckDuckGo: ")))))
(global-set-key (kbd "M-g M-k") 'duckduckgo)
(global-set-key (kbd "M-g k")   'duckduckgo)

(defun google-scholar ()
  "Googles a region, if any, or prompts for a Google search string."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/scholar?ie=utf-8&oe=utf-8&q="
    (if mark-active
        (buffer-substring (region-beginning) (region-end))
      (read-string "Google Scholar: ")))))

(global-set-key (kbd "M-g M-s") 'google-scholar)
(global-set-key (kbd "M-g s")   'google-scholar)

;; (global-set-key (kbd "M-g M-l") 'goto-line)
;; (global-set-key (kbd "M-g l")   'goto-line)

;; -----------------------------------------------------------------
(defun xah-select-text-in-quote ()
  "Select text between the nearest left and right delimiters.
Delimiters here includes the following chars: \"<>(){}[]“”‘’‹›«»「」『』【】〖〗《》〈〉〔〕（）
This command does not properly deal with nested brackets.
URL `http://ergoemacs.org/emacs/modernization_mark-word.html'
Version 2015-05-16"
  (interactive)
  (let (-p1
        -p2
        (-skipChars "^\"<>(){}[]“”‘’‹›«»「」『』【】〖〗《》〈〉〔〕（）"))
    (skip-chars-backward -skipChars)
    (setq -p1 (point))
    (skip-chars-forward -skipChars)
    (setq -p2 (point))
    (set-mark -p1)))

(defun mydoi ()
  "With point inside a DOI field of a bib entry goes object with that DOI."
  (interactive)
  (xah-select-text-in-quote)
  (browse-url
   (concat
    "https://doi.org/" (buffer-substring (region-beginning) (region-end))
  )))
;; -----------------------------------------------------------------

;; http://xahlee.blogspot.com/2011/11/emacs-lisp-example-title-case-string.html
;; For title-case-string-region-or-line
(require 'xfrp_find_replace_pairs)
(require 'xeu_elisp_util)

;; http://emacs.wordpress.com/2007/01/16/quick-and-dirty-code-folding
(defun jao-selective-display ()
"Activate selective display based on the column at point"
(interactive)
(set-selective-display
(if selective-display
nil
(+ 1 (current-column)))))
(global-set-key [M-f7] 'jao-selective-display)

;; https://twitter.com/danjacka/status/356728771430199296/photo/1
(defun bigtext-mode ()
     (interactive)
     (setq cursor-type nil)
     (text-scale-increase 8))

(global-set-key (kbd "<C-S-f6>") 'repeat-complex-command)

(require 'bubble-buffer)
(global-set-key [f9] 'bubble-buffer-next)
(global-set-key [(shift f9)] 'bubble-buffer-previous)
(setq bubble-buffer-omit-regexp "\\(^ .+$\\|\\*Messages\\*\\|*compilation\\*\\|\\*.+output\\*$\\|\\*TeX Help\\*$\\|\\*vc-diff\\*\\|\\*Occur\\*\\|\\*grep\\*\\|\\*cvs-diff\\*\\)")

; ------------------------------------------------
; http://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/
(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key (kbd "C-a") 'smarter-move-beginning-of-line)

; ------------------------------------------------

;; http://camdez.com/blog/2013/11/14/emacs-show-buffer-file-name/
;; Shows buffer filename and copies it to kill ring.
(defun show-buffer-file-name ()
  "Show the full path to the current file in the minibuffer."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
        (progn
          (message file-name)
          (kill-new file-name))
      (error "Buffer not visiting a file"))))

;; http://whattheemacsd.com/
(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))
(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)

;; Modified by NJH from rename-current-buffer-file.
(defun rename-current-buffer ()
  "Renames current buffer and associates it to a file."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
;;        (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
;;        (set-buffer-modified-p nil)
          (message "Buffer '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))
(global-set-key (kbd "C-x C-n") 'rename-current-buffer)

;; From https://github.com/jwiegley/dot-emacs/blob/master/init.el
(defun kill-to-end-of-buffer ()
  (interactive)
  (kill-region (point) (point-max)))

;; http://irreal.org/blog/?p=4926
(use-package char-menu
  ;; bind ("H-s" . char-menu)
  :config (setq char-menu '("—" "‘’" "“”" "…" "«»" "–"
                            ("Typography" "•" "©" "†" "‡" "°" "·" "§" "№" "★")
                            ("Math"       "≈" "≡" "≠" "∞" "×" "±" "∓" "÷" "√")
                            ("Arrows"     "←" "→" "↑" "↓" "⇐" "⇒" "⇑" "⇓"))))

;; ----------------------------------
;; ibuffer

(setq ibuffer-shrink-to-minimum-size t)
(setq ibuffer-always-show-last-buffer nil)
(setq ibuffer-sorting-mode 'recency)
(setq ibuffer-use-header-line t)
(global-set-key [C-f9] 'ibuffer)

;; http://martinowen.net/blog/2010/02/tips-for-emacs-ibuffer.html
;; Can't get wildcards on name containing emacs to work.
(setq ibuffer-saved-filter-groups
          (quote (("default"
; Can't get name with wildcards to work!
;                   ("emacs-config" (name . "^\\*.emacs\\*$"))
;                   ("Emacs Lisp" (mode . emacs-lisp-mode))
                   ("Emacs Lisp" (or (mode . emacs-lisp-mode)
;                                     (name . "emacs.org")
                                     (name . "^.\\*emacs.\\*$")
;                                     (name . "^\\*emacs\\*$")
;                                      (name . "\*emacs\*")
                   ))
                   ("LaTeX" (or (mode . latex-mode)
                      (mode . LaTeX-mode)
                      (mode . bibtex-mode)
                      (mode . reftex-mode)))
;                   ("TeX" (mode . latex-mode))
                   ("MATLAB" (mode . matlab-mode))
                   ("Org" (mode . org-mode))
                   ("Text" (mode . text-mode))
                   ("Web" (mode . html-mode))
                   ("dired" (or (mode . dired-mode)))
                   ("Emacs*" (or
                             (name . "^\\*Apropos\\*$")
                             (name . "^\\*Buffer List\\*$")
                             (name . "^\\*Compile-Log\\*$")
                             (name . "^\\*Help\\*$")
                             (name . "^\\*info\\*$")
                             (name . "^\\*Occur\\*$")
                             (name . "^\\*scratch\\*$")
                             (name . "^\\*Messages\\*$")))
))))
(setq ibuffer-show-empty-filter-groups nil)
(add-hook 'ibuffer-mode-hook
	  '(lambda ()
	     (ibuffer-auto-mode 1)
	     (ibuffer-switch-to-saved-filter-groups "default")))
(setq ibuffer-expert t)

;; http://www.emacswiki.org/emacs/IbufferMode
;; Switching to ibuffer puts the cursor on the most recent buffer
(defadvice ibuffer (around ibuffer-point-to-most-recent) ()
  "Open ibuffer with cursor pointed to most recent buffer name"
  (let ((recent-buffer-name (buffer-name)))
    ad-do-it
    (ibuffer-jump-to-buffer recent-buffer-name)))
(ad-activate 'ibuffer)

;; ----------------------------------

;; Next function is crude, but works on Scan!
;; http://xahlee.org/emacs/emacs_dired_open_file_in_ext_apps.html
(defun open-document-somehow ()
  (interactive)
  (shell-command (concat "\"" (car (dired-get-marked-files)) "\"") ) )
(global-set-key (kbd "C-S-o") 'open-document-somehow)

;; This enables Ctrl-x < and Ctrl-x > - scroll left and right.
(put 'scroll-left 'disabled nil)

;; Adapted from http://geosoft.no/development/emacs.html
;; Cf. \cite[p.~22]{glic97}.
(defun scroll-down-keep-cursor ()
   ;; Scroll the text one line down while keeping the cursor
   (interactive)
   (next-line)
   (scroll-down 1))
(defun scroll-up-keep-cursor ()
   ;; Scroll the text one line up while keeping the cursor
   (interactive)
   (previous-line)
   (scroll-up 1))
(global-set-key [\C-up]      'scroll-down-keep-cursor)
(global-set-key (kbd "C-q")  'scroll-down-keep-cursor)
(global-set-key [\C-down]    'scroll-up-keep-cursor)
(global-set-key (kbd "C-z")  'scroll-up-keep-cursor)

;; CUA mode
;; http://trey-jackson.blogspot.com/2008/10/emacs-tip-26-cua-mode-specifically.html
;; (setq cua-enable-cua-keys nil) ; Keep Emacs keys (C-c, C-v, C-x).
(setq cua-enable-cua-keys t)    ; Use new C-c, C-v, C-x.
(setq cua-remap-control-z nil)  ; Don't remap C-z.
;; (setq cua-remap-control-x nil)  ; Don't remap C-x.  ;; No such option!
;; (setq cua-highlight-region-shift-only t) ;; no transient mark mode
;; (setq cua-toggle-set-mark nil) ;; original set-mark behavior, i.e. no transient-mark-mode
(setq cua-prefix-override-inhibit-delay 0.35) ; default 0.2
(cua-mode)

;; Next function is kill-word from simple.el modified to use viper-forward-word
(defun njh-kill-word1 (arg)
  "Kill characters forward until encountering the end of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (kill-region (point) (progn (viper-forward-word arg) (point))))

;; (defun njh-kill-word (arg)
;;    ;; Modification of kill word to leave only one space between words.
;;    (interactive "p")
;;    (kill-word arg)
;;    (just-one-space))

(defun njh-kill-word2 (arg)
   ;; Modification of kill word to behave like DelRightWord() in TSE-Pro.
   (interactive "p")
   (cond
         ((bolp)  ;; True if point is at start of line
               (njh-kill-word1 arg)  (delete-horizontal-space) )
         ((eolp)  ;; True if point is at end of line
               (delete-forward-char 1) )
         (t (njh-kill-word1 arg) (just-one-space) )
   )
)
(global-set-key (kbd "M-d") 'njh-kill-word2)
(global-set-key (kbd "C-f") 'njh-kill-word2)

(global-set-key (kbd "M-f") 'mark-word)  ; default M-@

;; Never used this.
;; (require 'iy-go-to-char)
;; (global-set-key (kbd "M-m") 'iy-go-to-char)
;; Removed [2020-03-08 Sun 20:06] since not used.  Try original M-m.
;; (global-set-key (kbd "M-m") `make)

;; ----------------------------------------------
;; From \cite[p.~217]{pete15}:
(global-set-key [remap dabbrev-expand] 'hippie-expand)

;; Hippie expand.
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
       try-expand-dabbrev-all-buffers
       pcomplete
       try-expand-dabbrev-from-kill
       try-complete-file-name-partially
       try-complete-file-name
       try-expand-all-abbrevs
       try-expand-list
       try-expand-line
       try-complete-lisp-symbol-partially
       try-complete-lisp-symbol))

;; http://stackoverflow.com/questions/2149899/code-completion-key-bindings-in-emacs
;; Function to implement a smarter TAB (EmacsWiki)
(defun smart-tab ()
  "This smart tab is minibuffer compliant: it acts as usual in
    the minibuffer. Else, if mark is active, indents region. Else if
    point is at the end of a symbol, expands it. Else indents the
    current line."
  (interactive)
  (if (minibufferp)
      (unless (minibuffer-complete)
        (hippie-expand nil))
    (if mark-active
        (indent-region (region-beginning)
                       (region-end))
      ;; NJH mod - completion except when on spaces at start of line.
      (if (looking-at "^ *")
         (indent-for-tab-command)
         (hippie-expand nil)
          ))))
;;      (if (looking-at "\\_>") ; Matches empty string at and of symbol.
;;         (hippie-expand nil)
;;        (indent-for-tab-command)))))
(global-set-key (kbd "TAB") 'smart-tab)


;; ---------------------------------------------------
;; I've added the fullscreen, which works better, but it
;; restores window to less than full height.
;; weather from wttr.in
(use-package wttrin
  :commands (wttrin)
  :init
  (setq wttrin-default-cities '("Manchester")))

;;advise wttrin to save frame arrangement
;;requires frame-cmds package
(defun bjm/wttrin-save-frame ()
  "Save frame and window configuration and then expand frame for wttrin."
  ;;save window arrangement to a register
  (window-configuration-to-register :pre-wttrin)
  (delete-other-windows)
  ;;save frame setup and resize
  (save-frame-config)
  (toggle-frame-fullscreen)
  ;; (set-frame-width (selected-frame) 130)
  ;; (set-frame-height (selected-frame) 48)
  )
(advice-add 'wttrin :before #'bjm/wttrin-save-frame)

(defun bjm/wttrin-restore-frame ()
  "Restore frame and window configuration saved prior to launching wttrin."
  (interactive)
  (jump-to-frame-config-register)
  (jump-to-register :pre-wttrin)
  )
(advice-add 'wttrin-exit :after #'bjm/wttrin-restore-frame)
;; ---------------------------------------------------


;; ---------------------------------------------------
;; http://ergoemacs.org/emacs/emacs_using_register.html
(defun copy-to-register-1 ()
  "Copy current line or text selection to register 1.
See also: 'paste-from-register-1', 'copy-to-register'."
  (interactive)
  (let* (
         (bds (get-selection-or-unit 'line ))
         (inputStr (elt bds 0) )
         (p1 (elt bds 1) )
         (p2 (elt bds 2) )
         )
    (copy-to-register ?1 p1 p2)
    (message "copied to register 1: %s." inputStr)
))

(defun paste-from-register-1 ()
  "Paste text from register 1.
See also: 'copy-to-register-1', 'insert-register'."
  (interactive)
  (insert-register ?1))

(global-set-key [C-f6]       'copy-to-register-1)   ; A la TSEPro.
(global-set-key [S-f6]       'paste-from-register-1)

;;----------------------------------------------------
;; http://ergoemacs.org/emacs/elisp_compact_empty_lines.html
;; Suspect not most elegant coding, but not trivial to do this other ways!
(defun xah-clean-whitespace ()
  "Delete trailing whitespace, and replace sequence of newlines into just 2.
Work on whole buffer, or text selection."
  (interactive)
  (let* (
         (bds (get-selection-or-unit 'buffer))
         (p1 (elt bds 1))
         (p2 (elt bds 2))
         )
    (save-excursion
      (save-restriction
        (narrow-to-region p1 p2)
        (progn
          (goto-char (point-min))
          (while (search-forward-regexp " +\n" nil "noerror")
            (replace-match "\n") ))
        (progn
          (goto-char (point-min))
          (while (search-forward-regexp "\n\n\n+" nil "noerror")
            (replace-match "\n\n") )) )) ))
(global-set-key [C-f11] 'xah-clean-whitespace)
;;----------------------------------------------------

;; Column line where text should be wrapped
(setq-default fill-column 75)
(defun toggle-fill-column ()
    "Toggle setting fill column between 72 and 75"
    (interactive)
    (setq fill-column (if (= fill-column 75) 72 75)))
(global-set-key [S-f2]     'toggle-fill-column)
(global-set-key [S-C-f2]   'fci-mode)

;; Next line not a good idea as it affects all searches, incl. RefTeX.
;; (setq-default case-fold-search nil) ; Make searches case sensitive.
(global-set-key (kbd "C-c t") 'toggle-case-fold-search)

;; http://ergoemacs.org/emacs/elisp_datetime.html
(defun insert-long-date ()
  "Insert a nicely formatted date string."
  (interactive)
  (insert (format-time-string "%A %B %-e, %Y")))
(global-set-key (kbd "C-c C-d") 'insert-long-date)

(defun insert-short-date ()
  "Insert a nicely formatted date string."
  (interactive)
   (insert (format-time-string "%d-%m-%y")))
;; (global-set-key (kbd "C-c C-d") 'insert-short-date)

;; My own macro to join current line with next.
;; join-line is an alias for `delete-indentation' in `simple.el'.
(defun my-join-lines () (interactive)
       (save-excursion (next-line) (join-line)) )
(global-set-key (kbd "M-j") 'my-join-lines)

(defun backward-kill-line (arg)
  "Kill chars backward until encountering the end of a line."
  (interactive "p") (kill-line 0) )
(global-set-key (kbd "C-M-k") 'backward-kill-line)
;; Note that C-M-backspace couldn't be assigned to.

;; ------------------------------------------------------------
;; To make end of sentences work as I want: single or double space OK.

(defun my-kill-sentence (&optional arg)
  "Kill from point to end of sentence.
With arg, repeat; negative arg -N means kill back to Nth start of sentence."
  (interactive "p")
  (progn
    (setq sentence-end-double-space nil)
;;    (kill-sentence arg)  ;; Next line is letter with backward-char added.
    (kill-region (point) (progn (forward-sentence arg) (backward-char) (point))))
    (setq sentence-end-double-space t)
)
(global-set-key (kbd "M-k") 'my-kill-sentence)
;; Next function works OK as is.
(global-set-key (kbd "C-S-k") 'backward-kill-sentence)

(defun my-fill-paragraph ()
  (interactive)
  (progn
    (setq sentence-end-double-space t)
    (fill-paragraph)
    (setq sentence-end-double-space nil)
))
(global-set-key (kbd "M-q") 'my-fill-paragraph)

;; ------------------------------------------------------------
;; http://endlessparentheses.com/better-backspace-during-isearch.html?source=rss
(defun mydelete ()
  "Delete the failed portion of the search string, or the last char if successful."
  (interactive)
  (with-isearch-suspended
      (setq isearch-new-string
            (substring
             isearch-string 0 (or (isearch-fail-pos) (1- (length isearch-string))))
            isearch-new-message
            (mapconcat 'isearch-text-char-description isearch-new-string ""))))
(define-key isearch-mode-map (kbd "<backspace>") 'mydelete)

;;------------------------
;; (add-to-list 'load-path "~/dropbox/elisp/switch-window-master")
(use-package switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

;; (add-to-list 'load-path "~/dropbox/elisp/ace-window-master")
(use-package ace-window)
(global-set-key [f2]          'ace-window)

;; Quicker window splitting
(global-set-key (kbd "C-M-0") 'delete-window) ; was digit-argument
(global-set-key (kbd "M-1")   'delete-other-windows) ; was digit-argument
; (global-set-key (kbd "M-u")   'delete-other-windows) ; u for "unique"
(global-set-key (kbd "M-2")   'split-window-vertically) ; was digit-argument
(global-set-key (kbd "M-3")   'split-window-horizontally) ; was digit-argument
; (global-set-key [f2]          'other-window)

(global-set-key (kbd "C-x ,") 'shrink-window)
(global-set-key (kbd "C-x .") 'enlarge-window) ; was set-fill-prefix

(use-package bufler
  ;; (global-set-key [C-f10]      'bufler)
  :bind (([C-f10] .  bufler))
)

;; Different from C-M-0 when more than 2 windows.
(global-set-key [C-f2]
  '(lambda () (interactive) (other-window 1) (delete-other-windows)))

(global-set-key [C-f12]      'list-matching-lines)
(global-set-key [M-C-f12]    'toggle-frame-fullscreen)

;; Use M-f5 Hydra instead now
;; (global-set-key [S-C-f12]    'text-scale-adjust)

;;; * Flyspell: spell-checking.

(global-set-key [f10]        'query-replace)
;; (global-set-key [S-f10]      'ispell-buffer)
;; (global-set-key [C-f10]      'flyspell-region)  ;; Default paragraph?
(global-set-key [C-S-f10]    'flyspell-buffer)
(global-set-key [S-f10]      'flyspell-auto-correct-word)
;; There is no "previous error" command!
(global-set-key [M-f10]      'flyspell-goto-next-error)

(setq ispell-dictionary "american")   ; Set the default dictionary.

;; To give Mac same mouse button behavior as Windows:
;; https://joelkuiper.eu/spellcheck_emacs
(if (system-is-mac)
(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
     (define-key flyspell-mouse-map [mouse-3] #'undefined))))

;; Not sure why local-unset-key trick doesn't work.  This does the job:
;; http://stackoverflow.com/questions/16084022/emacs-flyspell-deactivate-c-key-binding
(eval-after-load "flyspell"
  ;; '(define-key flyspell-mode-map (kbd "C-c $") nil)) ;; Prefer Org-mode's key.
  '(progn
      (define-key flyspell-mode-map (kbd "C-c $") nil) ;; Prefer Org-mode's key.
      (define-key flyspell-mode-map (kbd "C-,") nil) ;; Prefer Embark key.
   ))

;; http://stackoverflow.com/questions/6860750/how-to-enable-flyspell-mode-in-emacs-for-all-files-and-all-major-modes
;; Turn flyspell on in all modes.
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'emacs-lisp-mode-hook 'flyspell-mode)  ;; For *scratch* mainly. OK?
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'mail-mode-hook 'flyspell-mode)

;; ;; Enable flyspell in various modes.
;; BibTeX sets flyspell-mode in later hook.
;; (add-hook 'text-mode-hook 'flyspell-mode)
;; (add-hook 'org-mode-hook 'flyspell-mode)
;; ;; Enable for tex-mode.
;; (add-hook 'latex-mode-hook 'flyspell-mode)
;; ;; Or if you use AUCTeX for latex.
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'Lisp-mode-hook 'flyspell-mode)
;; (add-hook 'lisp-mode-hook 'flyspell-mode)
;; (add-hook 'matlab-mode-hook 'flyspell-mode)

;; http://pragmaticemacs.com/emacs/jump-back-to-previous-typo/
;; Move point to previous spelling error.
;; Based on code by hatschipuh at http://emacs.stackexchange.com/a/14912/2017
(defun flyspell-goto-previous-error (arg)
  "Go to arg previous spelling error."
  (interactive "p")
  (while (not (= 0 arg))
    (let ((pos (point))
          (min (point-min)))
      (if (and (eq (current-buffer) flyspell-old-buffer-error)
               (eq pos flyspell-old-pos-error))
          (progn
            (if (= flyspell-old-pos-error min)
                ;; goto beginning of buffer
                (progn
                  (message "Restarting from end of buffer")
                  (goto-char (point-max)))
              (backward-word 1))
            (setq pos (point))))
      ;; seek the next error
      (while (and (> pos min)
                  (let ((ovs (overlays-at pos))
                        (r '()))
                    (while (and (not r) (consp ovs))
                      (if (flyspell-overlay-p (car ovs))
                          (setq r t)
                        (setq ovs (cdr ovs))))
                    (not r)))
        (backward-word 1)
        (setq pos (point)))
      ;; save the current location for next invocation
      (setq arg (1- arg))
      (setq flyspell-old-pos-error pos)
      (setq flyspell-old-buffer-error (current-buffer))
      (goto-char pos)
      (if (= pos min)
          (progn
            (message "No more miss-spelled word!")
            (setq arg 0))
        (forward-word)))))
;; global-set-key [M-S-f10]    'flyspell-correct-word-before-point)
(global-set-key [M-S-f10]    'flyspell-goto-previous-error)

;; ---------------------------------------
;; (define-key ctl-x-map "\C-i" #'endless/ispell-word-then-abbrev)
(global-set-key (kbd "C-:") 'endless/ispell-word-then-abbrev)

;; http://endlessparentheses.com/ispell-and-abbrev-the-perfect-auto-correct.html
(defun endless/ispell-word-then-abbrev (p)
  "Call `ispell-word', then create an abbrev for it.
With prefix P, create local abbrev. Otherwise it will
be global.
If there's nothing wrong with the word at point, keep
looking for a typo until the beginning of buffer. You can
skip typos you don't want to fix with `SPC', and you can
abort completely with `C-g'."
  (interactive "P")
  (let (bef aft)
    (save-excursion
      (while (if (setq bef (thing-at-point 'word))
                 ;; Word was corrected or used quit.
                 (if (ispell-word nil 'quiet)
                     nil ; End the loop.
                   ;; Also end if we reach `bob'.
                   (not (bobp)))
               ;; If there's no word at point, keep looking
               ;; until `bob'.
               (not (bobp)))
        (backward-word))
      (setq aft (thing-at-point 'word)))
    (if (and aft bef (not (equal aft bef)))
        (let ((aft (downcase aft))
              (bef (downcase bef)))
          (define-abbrev
            (if p local-abbrev-table global-abbrev-table)
            bef aft)
          (message "\"%s\" now expands to \"%s\" %sally"
                   bef aft (if p "loc" "glob")))
      (user-error "No typo at or before point"))))

(setq save-abbrevs 'silently)
(setq-default abbrev-mode t)
;; ------------------------------------

;;  C-u 0 M-p shows a description of the change you made at each point.
(use-package goto-chg
  :bind (("M-," . goto-last-change)
         ("M-." . goto-last-change-reverse)))

;;; * Other

;; http://pragmaticemacs.com/emacs/aligning-text/
(defun bjm/align-whitespace (start end)
  "Align columns by whitespace"
  (interactive "r")
  (align-regexp start end
                "\\(\\s-*\\)\\s-" 1 0 t))
;; -----------------------------------------

;; Next command seems to have same effect as align-current.
;; Useful for some other symbol?
(defun bjm/align-& (start end)
  "Align columns by ampersand"
  (interactive "r")
  (align-regexp start end
                "\\(\\s-*\\)&" 1 1 t))

;; Font size - no effect with fixed-sys font in Windows.
(define-key global-map (kbd "C-M-+") 'text-scale-increase)
(define-key global-map (kbd "C-M--") 'text-scale-decrease)

(define-key global-map (kbd "M-[") 'backward-sentence)
(define-key global-map (kbd "M-]") 'forward-sentence)

;; http://www.emacswiki.org/emacs/LineCopyChar
(defun line-copy-char (&optional b)
 "Copy a character exactly below/above the point
  to the current point of the cursor (default is above)."
  (interactive "p")
    (let (p col s)
      (setq p (point))
      (setq col (current-column))
      (forward-line (if b -1 1))
      (move-to-column col)
      (setq s (buffer-substring (point) (+ (point) 1)))
      (goto-char p)
      (insert s)))
(define-key global-map [C-f4] 'line-copy-char)

; global-set-key (kbd "M-5") 'comment-or-uncomment-region)

; http://endlessparentheses.com/implementing-comment-line.html
(defun endless/comment-line-or-region (n)
  "Comment or uncomment current line and leave point after it.
With positive prefix, apply to N lines including current one.
With negative prefix, apply to -N lines above.
If region is active, apply to active region instead."
  (interactive "p")
  (if (use-region-p)
      (comment-or-uncomment-region
       (region-beginning) (region-end))
    (let ((range
           (list (line-beginning-position)
                 (goto-char (line-end-position n)))))
      (comment-or-uncomment-region
       (apply #'min range)
       (apply #'max range)))
    (forward-line 1)
    (back-to-indentation)))
(global-set-key (kbd "M-5") 'endless/comment-line-or-region)

;; ---------------------------------------------------
;; http://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-emacs
;; (defun duplicate-line (&optional arg)
;;   "Duplicate it. With prefix ARG, duplicate ARG times."
;;   (interactive "p")
;;   (next-line
;;    (save-excursion
;;      (let ((beg (line-beginning-position))
;;            (end (line-end-position)))
;;        (copy-region-as-kill beg end)
;;        (dotimes (num arg arg)
;;          (end-of-line) (newline)
;;          (yank))))))

;; Try this one instead - doesn't use kill buffer: better?
;; https://github.com/jwiegley/dot-emacs/blob/master/init.el
(defun duplicate-line ()
  "Duplicate the line containing point."
  (interactive)
  (save-excursion
    (let (line-text)
      (goto-char (line-beginning-position))
      (let ((beg (point)))
        (goto-char (line-end-position))
        (setq line-text (buffer-substring beg (point))))
      (if (eobp)
          (insert ?\n)
        (forward-line))
      (open-line 1)
      (insert line-text))))

(global-set-key [f4] `duplicate-line)
;; ---------------------------------------------------

(defun transpose-chars-forward ()
   (interactive)
   (forward-char)
   (transpose-chars 1)
   (backward-char))
(defun transpose-chars-backward ()
   (interactive)
   (transpose-chars 1)
   (backward-char 2))
(global-set-key [f11] 'transpose-chars-forward)
(global-set-key [f12] 'transpose-chars-backward)
;; Note that f12 is different from C-t, which moves point forwards.

;; NB: find-file used. load-file is only for .el files.
(global-set-key [C-f1]
  '(lambda () (interactive) (find-file "~/Dropbox/org/emacs.org")))
(global-set-key [M-f1]
  '(lambda () (interactive) (find-file "~/Dropbox/org/todo.org")))
(global-set-key [S-f1]
  '(lambda () (interactive) (find-file "~/Dropbox/.emacs")))
(global-set-key [f1]  'delete-other-windows)
(global-set-key [C-S-f1]
  '(lambda () (interactive) (find-file "~/Dropbox/org/tex.org")))
(global-set-key [S-M-f1]
  '(lambda () (interactive) (find-file "~/Dropbox/org/blog.org")))
(global-set-key [C-M-f1]
  '(lambda () (interactive) (find-file "~/Dropbox/org/org.org")))

; ----------------------------------------------------------
;; Disable prompt asking you if you want to kill a
;; buffer with a live process attached to it.
;; http://stackoverflow.com/questions/268088/how-to-remove-the-prompt-for-killing-emacsclient-buffers
;; (remove-hook 'kill-buffer-query-functions
;'server-kill-buffer-query-function)

;; For quitting file edited from server (e.g., Thunderbird).
;; (global-set-key (kbd "C-x t") 'server-edit)

; Trying this instead, from comment at
; https://nickhigham.wordpress.com/2015/06/18/my-dot-emacs.

(defun server-edit-or-close ()
"Saves and calls `server-edit’, if opened by server, or kills buffer."
(interactive)
(save-buffer)
(if server-buffer-clients
(server-edit)
(kill-this-buffer)))
(global-set-key (kbd "C-x t") 'server-edit-or-close)

; ----------------------------------------------------------

;; More convenient ways to get to beginning and end of file.
(global-set-key [\C-kp-prior]   'beginning-of-buffer)  ; numpad Pgup
(global-set-key [\C-kp-next]    'end-of-buffer)        ; numpad PgDn

(global-set-key [\C-\M-kp-prior] 'beginning-of-buffer-other-window)
(global-set-key [\C-\M-kp-next]  'end-of-buffer-other-window)

(global-set-key [\C-\S-kp-prior]  'scroll-other-window-down)
(global-set-key [\C-\S-kp-next]   'scroll-other-window)

(if (system-is-mac)
    (progn
    (global-set-key (kbd "s-<up>")    'scroll-other-window-down)
    (global-set-key (kbd "s-<down>")  'scroll-other-window)
    ;; s = Cmd.  Want to set M-s-h but that doesn't work.
    (global-set-key (kbd "s-h")       'ns-do-hide-others)
))

;; Move to top left and bottom left of window.
(global-set-key [C-kp-home]
   '(lambda () (interactive) (move-to-window-line 0)))
(global-set-key [C-kp-end]
   '(lambda () (interactive) (move-to-window-line -1)))

;; For Macbook Pro, which has no insert key.
;; http://lists.gnu.org/archive/html/help-gnu-emacs/2006-07/msg00220.html
(global-set-key (kbd "C-c i") (function overwrite-mode))

;; (global-set-key [M-f11] 'quoted-insert) ; I use C-q for scrolling.

;; This handles cursor keys in cluster, but not numerical keypad.
;(global-set-key "\M-[1;5C"    'forward-to-word) ; Ctrl+right => forward word
;(global-set-key "\M-[1;5D"    'backward-word)   ; Ctrl+left  => back
;; (global-set-key [\C-kp-right] 'forward-to-word) ; keypad cursor key
;; (global-set-key [\C-kp-left]  'backward-word)   ; keypad cursor key

;; -------------------------------------------------
;; Commented out to see if cures yasnippet bug
;; Prefer not to skip over special chars:
;; http://stackoverflow.com/questions/3931837/modifying-emacs-forward-word-backward-ward-behavior-to-be-like-in-vi-vim
(setq viper-mode nil)
(require 'viper)
;; (global-set-key [\C-kp-right] 'viper-forward-word)
;; (global-set-key [\C-kp-left]  'viper-backward-word)
;; Trying "delimited by white characters" versions.
(global-set-key [\C-kp-right] 'viper-forward-Word)
(global-set-key [\C-kp-left]  'viper-backward-Word)

;; Needed for Mac.  On Windows this is for middle cluster.
(global-set-key [C-right] 'viper-forward-Word)  ; keypad cursor key
(global-set-key [C-left]  'viper-backward-Word) ; keypad cursor key
;; -------------------------------------------------

(defun my-transpose-word ()
  (interactive)
; (viper-forward-Word) (viper-backward-Word)  ; Not sure if need Viper.
  (forward-word) (backward-word)
  (forward-char) (transpose-words 1) (backward-word) )
(global-set-key (kbd "M-t") 'my-transpose-word)

;; -------------------------
;; Bubble lines up and down: http://www.emacswiki.org/emacs/MoveLine
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<up>")   'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)
;; -------------------------

;; Jump to matching parenthesis.  http://www.crsr.net/Notes/Emacs.html
;; http://emacs-fu.blogspot.co.uk/2009/01/balancing-your-parentheses.html
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert
the character typed."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
    ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;;    (t                    (self-insert-command (or arg 1))) ))
    (t                    ( )) ))
(global-set-key (kbd "M-=") `goto-match-paren)
;; NJH modified to do nothing if not on paren.

;; http://www.masteringemacs.org/articles/2011/08/04/full-text-searching-info-mode-apropos/#comments
;; Custom 'apropos' key bindings
(global-set-key (kbd "C-h C-a") 'Apropos-Prefix)
(define-prefix-command 'Apropos-Prefix nil "Apropos (a,d,f,i,l,v,C-v)")
(define-key Apropos-Prefix (kbd "a")   'apropos)
(define-key Apropos-Prefix (kbd "C-a") 'apropos)
(define-key Apropos-Prefix (kbd "d")   'apropos-documentation)
(define-key Apropos-Prefix (kbd "f")   'apropos-command)
(define-key Apropos-Prefix (kbd "c")   'apropos-command)
(define-key Apropos-Prefix (kbd "i")   'info-apropos)
(define-key Apropos-Prefix (kbd "l")   'apropos-library)
(define-key Apropos-Prefix (kbd "v")   'apropos-variable)
(define-key Apropos-Prefix (kbd "C-v") 'apropos-value)

;; ----- Modes
;; Make text mode the default.
(setq default-major-mode 'text-mode)

;; Turn on auto-fill mode for all text and org buffers.
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'turn-on-auto-fill)

;; Undo change in Org 9.4 (from release notes)
(add-hook 'org-mode-hook (lambda () (electric-indent-local-mode -1)))

;; Thunderbird email buffers.
(add-to-list 'auto-mode-alist '("\\.eml$" . mail-mode))

(use-package magit
  :defer t
;; :diminish magit-auto-revert-mode

  :bind ("C-M-g" . magit-status)
  :preface

  :init
  (add-hook 'magit-mode-hook 'hl-line-mode)  ; Hilite current line.

  :config
  (setq magit-commit-all-when-nothing-staged t)

  ;; full screen magit-status
  ;; http://whattheemacsd.com/setup-magit.el-01.html
  (defadvice magit-status (around magit-fullscreen activate)
    (window-configuration-to-register :magit-fullscreen)
    ad-do-it
    (delete-other-windows))
  (defun magit-quit-session ()
    "Restores the previous window configuration and kills the magit buffer"
    (interactive)
    (kill-buffer)
    (jump-to-register :magit-fullscreen))

    (bind-key "q" 'magit-quit-session magit-status-mode-map)
    ; (define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

)

;; (add-to-list 'load-path "~/Dropbox/elisp/magit-master")
;; (autoload 'magit-status "magit" nil t)
;; (require 'magit)
;; (global-set-key (kbd "C-M-g") 'magit-status)
;; (setq magit-commit-all-when-nothing-staged t)

;; ;; full screen magit-status
;; ;; http://whattheemacsd.com/setup-magit.el-01.html
;; (defadvice magit-status (around magit-fullscreen activate)
;;   (window-configuration-to-register :magit-fullscreen)
;;   ad-do-it
;;   (delete-other-windows))
;; (defun magit-quit-session ()
;;   "Restores the previous window configuration and kills the magit buffer"
;;   (interactive)
;;   (kill-buffer)
;;   (jump-to-register :magit-fullscreen))
;; (define-key magit-status-mode-map (kbd "q") 'magit-quit-session)
; -----------------------------------------------------------------------


;; --------------------------------------------------------
;; MATLAB mode (http://www.emacswiki.org/emacs/MatlabMode)
;; [2020-01-05 Sun 15:34] Try Elpa one again in future:
;; help command is affected currently.

;; (use-package matlab-load
(use-package matlab-mode
;;  :load-path "~/Dropbox/elisp/matlab-emacs"
  :mode ("\\.m\\'" . matlab-mode)
  ; Prev line replaces: (add-to-list 'auto-mode-alist '("\\.m$" . matlab-mode))
  :init (autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
  :commands (matlab-load)
  :config
    (matlab-load)
    (setq matlab-indent-function t)
)

;; (add-to-list 'load-path "~/Dropbox/elisp/matlab-emacs")
;; (require 'matlab-load)
;; ; (load-library "matlab-load")
;; ;; (autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)

;; (add-to-list
;;  'auto-mode-alist
;;  '("\\.m$" . matlab-mode))
;; (setq matlab-indent-function t)
;; ;; (setq matlab-shell-command "matlab")
;; ;; --------------------------------------------------------

;; Abbreviations
(setq abbrev-file-name "~/Dropbox/emacs_abbrev_defs")
(setq save-abbrevs t)              ;; save abbrevs when files are saved
(setq-default abbrev-mode t)

;; -----------------------------
;; Tidy (clean) up non-ASCII characters

;; I used the first and second of these:
;; http://ergoemacs.org/emacs/elisp_replace_string_region.html
;; http://www.emacswiki.org/emacs/ReplaceGarbageChars
;; http://blog.gleitzman.com/post/35416335505/hunting-for-unicode-in-emacs
;; http://tonyballantyne.com/tech/category/emacs/emacs-lisp/

(defun tidy (begin end)
  "Replace non-ASCII characters in region, or buffer if no region."
  (interactive "r")
  (save-excursion
    (save-restriction
    (narrow-to-region begin end)

    ;; Adapted from narrow-or-widen-dwim, so as to use buffer if no region.
    ;; (cond ( (region-active-p)
    ;;         (narrow-to-region (region-beginning) (region-end)) ))

   ;;  (goto-char (point-min))
   ;;  (while (search-forward "“" nil t) (replace-match "\"" nil t))

   ;;  (goto-char (point-min))
   ;;  (while (search-forward "”" nil t) (replace-match "\"" nil t))

   ;; (goto-char (point-min))
   ;;  (while (search-forward "’" nil t) (replace-match "'" nil t))

   ;; (goto-char (point-min))
   ;;  (while (search-forward "‘" nil t) (replace-match "'" nil t))

   ;; (goto-char (point-min))
   ;;  (while (search-forward "…" nil t) (replace-match "..." nil t))

   ;; (goto-char (point-min))
   ;;  (while (search-forward "–" nil t) (replace-match "-" nil t))

   ;; (goto-char (point-min))
   ;;  (while (search-forward "—" nil t) (replace-match "-" nil t))

   ;; (goto-char (point-min))
   ;; (while (search-forward "−" nil t) (replace-match "-" nil t))

    ;; (goto-char (point-min))
    ;; (while (search-forward "" nil t) (replace-match "fi" nil t))

   (replace-string "“" "\""  nil (point-min) (point-max))
   (replace-string "”" "\""  nil (point-min) (point-max))
   (replace-string "’" "'"   nil (point-min) (point-max))
   (replace-string "‘" "'"   nil (point-min) (point-max))
   (replace-string "…" "..." nil (point-min) (point-max))
   (replace-string "–" "-"   nil (point-min) (point-max))
   (replace-string "—" "-"   nil (point-min) (point-max))
   (replace-string "−" "-"   nil (point-min) (point-max))
   (replace-string "—" "-"   nil (point-min) (point-max))

   (replace-string "" "`" nil (point-min) (point-max))  ; opening single quote
   (replace-string "" "'" nil (point-min) (point-max))  ; closing single quote
   (replace-string "" "\"" nil (point-min) (point-max))
   (replace-string "" "\"" nil (point-min) (point-max))
   (replace-string "" "-" nil (point-min) (point-max))
   (replace-string "
" "" nil (point-min) (point-max))
;; Next line deleted as it puts everything on one line when applied to
;; whole file!
;;    (replace-string "
;; " "" nil (point-min) (point-max))
)))

;; http://stackoverflow.com/questions/730751/hiding-m-in-emacs
;; Get rid of "^M" displayed in file (Emacs will have set Unix mode).

(defun dos2unix ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
    (goto-char (point-min))
      (while (search-forward (string ?\C-m) nil t) (replace-match "")))

;; For making comma-separated list of keywords from list of words.
(defun make-keywords (begin end)
  "Replace non-ASCII characters in region, or buffer if no region."
    ;; Adapted from tidy.
  (interactive "r")
  (save-restriction

    (cond ( (region-active-p)
            (narrow-to-region (region-beginning) (region-end)) ))

    (goto-char (point-min))
    (while (search-forward ", " nil t) (replace-match " " nil t))
    (goto-char (point-min))
    (while (search-forward ". " nil t) (replace-match " " nil t))
    (goto-char (point-min))
    (while (search-forward " " nil t) (replace-match ", " nil t))
))

;;; * LaTeX

;; To fix problem with parsing error messages from Emacs 24.x onwards:
;; http://tex.stackexchange.com/questions/124246/uninformative-error-message-when-using-auctex
;; (setq LaTeX-command-style '(("" "%(PDF)%(latex) -file-line-error %S%(PDFout)")))

;; From https://github.com/tmalsburg/helm-bibtex/issues/121#issuecomment-237981605
(defun bibtex-completion-open-pdf-of-entry-at-point ()
  (interactive)
  (save-excursion
    (bibtex-beginning-of-entry)
    (when (looking-at bibtex-entry-maybe-empty-head)
;      (bibtex-completion-open-pdf (bibtex-key-in-head)))))
       (bibtex-completion-open-pdf (list (bibtex-key-in-head))))))
;; Change suggested by https://github.com/tmalsburg/helm-bibtex/issues/169#issuecomment-269950953

;; Bib file notes: one file per entry.
(setq bibtex-completion-notes-path "~/texmf/bibtex/bib/notes")
;; Trivial modification of the previous function to edit note for bib entry.
(defun bibtex-completion-njh-edit-note ()
  (interactive)
  (save-excursion
    (bibtex-beginning-of-entry)
    (when (looking-at bibtex-entry-maybe-empty-head)
;;      (bibtex-completion-edit-notes (bibtex-key-in-head)))))
      (bibtex-completion-edit-notes (list( bibtex-key-in-head))))))

(defun my-bibtex-mode-hook ()
   (flyspell-mode)
   (defun bibtex-flyspell-entry ()
     "Check BibTeX entry for spelling errors."
     (interactive)
     (flyspell-region (save-excursion (bibtex-beginning-of-entry))
                    (save-excursion (bibtex-end-of-entry))))
   (local-set-key [C-S-f10]    'bibtex-flyspell-entry)
   (defun bibtex-created-date ()
     (interactive)
     (insert (format-time-string "created = \"%Y.%m.%d\",")))
   (local-set-key (kbd "C-c d") 'bibtex-created-date)
   (defun bibtex-updated-date ()
     (interactive)
     (insert (format-time-string "updated = \"%Y.%m.%d\"")))
   (local-set-key (kbd "C-c u") 'bibtex-updated-date)
   (local-set-key (kbd "C-c p") 'bibtex-completion-open-pdf-of-entry-at-point)
   (local-set-key (kbd "C-c n") 'bibtex-completion-njh-edit-note)
   (defun mynote ()
      "Insert mynote field in Bib file."
      (interactive)
      (insert "mynote = \"Not printed.\","))
)
(add-hook 'bibtex-mode-hook 'my-bibtex-mode-hook)

;; My function based on the obvious commands.
(defun njh-open-cite-pdf ()
  (interactive)
  (save-excursion
  (reftex-view-crossref) (switch-window)
  (bibtex-completion-open-pdf-of-entry-at-point)(delete-window)))
(defun njh-open-cite-note ()
  (interactive)
  (save-excursion
  (reftex-view-crossref) (switch-window)
   (bibtex-completion-njh-edit-note) ))
(add-hook 'LaTeX-mode-hook '(lambda ()
          (local-set-key (kbd "C-c p") 'njh-open-cite-pdf)
          (local-set-key (kbd "C-c n") 'njh-open-cite-note)
          ))
(add-hook 'org-mode-hook '(lambda ()
          (local-set-key (kbd "C-c p") 'njh-open-cite-pdf)
          (local-set-key (kbd "C-c n") 'njh-open-cite-note)
          ))
(add-hook 'matlab-mode-hook '(lambda ()
          (local-set-key (kbd "C-c p") 'njh-open-cite-pdf)
          (local-set-key (kbd "C-c n") 'njh-open-cite-note)
          ))
(add-hook 'emacs-lisp-mode-hook '(lambda ()
          (local-set-key (kbd "C-c p") 'njh-open-cite-pdf)
          (local-set-key (kbd "C-c n") 'njh-open-cite-note)
          ))

;; BibTeX mode.
(require 'bibtex)
(setq bibtex-string-files '("strings.bib"))

;; Does removing trailing / on next line cure
;; bibtex-parse-buffers-stealthily errors?
;; (setq bibtex-string-file-path '("~/texmf/bibtex/bib"))
(setq bibtex-string-file-path (concat (getenv "HOME") "/texmf/bibtex/bib"))

(setq bibtex-field-delimiters 'double-quotes)
;; Can't match my key exactly - compromise on fixed # chars from each name.
; (setq bibtex-autokey-names-stretch 3);  Use up to 4 names in total
; (setq bibtex-autokey-name-length 4);    Max no chars to use.
(setq bibtex-autokey-names-stretch 0);  Use up to 4 names in total
(setq bibtex-autokey-name-length nil);    Max no chars to use.
(setq bibtex-autokey-titlewords 0);     Don't use title in key.
(setq bibtex-autokey-titlewords-stretch 0);
(setq bibtex-text-indentation 0) ; No indentation for content.

;; From comment at https://nickhigham.wordpress.com/2016/01/06/managing-bibtex-files-with-emacs/
;; Modifications by M. Fasi.
(defun bibtex-generate-autokey ()
  (let* ((bibtex-autokey-names nil)
         (bibtex-autokey-year-length 2)
         (bibtex-autokey-name-separator "\0")
         (names (split-string (bibtex-autokey-get-names) "\0"))
         (year (bibtex-autokey-get-year))
         (name-char
          (cond ((= (length names) 1)(min 4 (length (car names))))
          ;; Handle surnames with three or fewer characters.
                ((= (length names) 2) 2)
                (t 1)))
         (existing-keys (bibtex-parse-keys)) key)
    (setq names (mapconcat (lambda (x)(substring x 0 name-char))
                           names ""))
    (setq names (substring names 0 (min (length names) 4)))
    ;; Use only first four initials for papers with five or more authors.
    (setq key (format "%s%s" names year))
    (let ((ret key))
      (loop for c from ?a to ?z
            while (assoc ret existing-keys)
            do (setq ret (format "%s%c" key c)))
      ret)))

;; (defun bibtex-generate-autokey ()
;;   (let* ((bibtex-autokey-names nil)
;;   (bibtex-autokey-year-length 2)
;;   (bibtex-autokey-name-separator "\0")
;;   (names (split-string (bibtex-autokey-get-names) "\0"))
;;   (year (bibtex-autokey-get-year))
;;   (name-char (cond ((= (length names) 1) 4) ((= (length names) 2) 2) (t 1)))
;;   (existing-keys (bibtex-parse-keys)) key)
;;   (setq names (mapconcat (lambda (x)
;;   (substring x 0 name-char))
;;   names ""))
;;   (setq key (format "%s%s" names year))
;;   (let ((ret key))
;;   (loop for c from ?a to ?z
;;   while (assoc ret existing-keys)
;;   do (setq ret (format "%s%c" key c)))
;;   ret)))

;; This is for inserting text of citation within a tex file.
;; Use in TeX mode and others (with different keys).
(defun my-cite()
   (interactive)
   (let ((reftex-cite-format "%a, %t, %j %v, %p, %e: %b, %u, %s, %y %<"))
                           (reftex-citation)))
;; Above reftex-cite-format string has same effect as "'locally" but
;; with title added and author list not abbreviated.

;; [2020-11-07 Sat 19:21]
;; This now needed for previous command to work.
;; https://tex.stackexchange.com/questions/425883/emacs-auctex-reftex-and-biblatexs-multicite-commands
;; Might not be needed! ;; my-cite works everywhere except in whatis.org!  Why?
;; [2020-11-08 Sun 16:37] Now it works!
;; [2020-12-05 Sat 12:28] Only work in certain places in whatis.org!
(setq LaTeX-reftex-ref-style-auto-activate nil)
(setq LaTeX-reftex-cite-format-auto-activate nil)

(defun my-cite-hook ()
(local-set-key (kbd "C-c m") 'my-cite))

(global-set-key (kbd "C-c [") 'reftex-citation) ;; For all modes.

;; Customize BibTeX bibtex-clean-entry.
;; That command doesn't work properly on the Mac - unclear why.
;; E.g. https://github.com/pcdavid/config/blob/master/emacs/feature-latex.el
;; (setq bibtex-entry-format
;;       `(("opts-or-alts", "page-dashes", "required-fields",
;;          "numerical-fields", "whitespace", "last-comma", "delimiter",
;;          "unify-case", "sort-fields"
;; )))
(setq bibtex-entry-format
      `(page-dashes required-fields
         numerical-fields whitespace last-comma delimiters
         unify-case sort-fields))

(setq bibtex-field-delimiters 'double-quotes)
(setq bibtex-entry-delimiters 'braces)

;; I prefer closing brace on its own line after cleaning BibTeX entry.
(setq bibtex-clean-entry-hook 'mybibtex-clean-extra)
(defun mybibtex-clean-extra ()
  "Move final right brace to a line of its own."
  (progn (bibtex-end-of-entry) (left-char) (newline-and-indent)
         (insert "      ")))

;; These seem to work in LaTeX mode too, so no need to distinguish?
(defun my-tex-mode-hook ()
;; f5 saves file then runs LaTeX with no need to hit return.
;; http://stackoverflow.com/questions/1213260/one-key-emacs-latex-compilation
(local-set-key (kbd "<f5>") (kbd "C-x C-s C-c C-c C-j"))

(if (system-is-mac)
     ; Next line not really needed, since same as f5, but use it for
     ; consistency between Mac and Windows.
;     (local-set-key (kbd "<C-f5>") (kbd "C-x C-s C-c C-c C-j")))
     (local-set-key (kbd "<C-f5>") (kbd "C-c C-v")))
(if (system-is-windows)
    (local-set-key (kbd "<C-f5>")  'sumatra-jump-to-line))

(defun my-ref()
  (interactive)
  (insert "\\ref{}")
  (backward-char))
(local-set-key (kbd "C-c r") 'my-ref)
(defun my-eqref()
  (interactive)
  (insert "\\eqref{}")
  (backward-char))
(local-set-key (kbd "C-c e") 'my-eqref)
(local-set-key (kbd "C-c C-t C-c") `TeX-clean); Remove .log, .aux files etc.
(setq TeX-clean-confirm nil);                   Don't ask for confirmation.
(local-set-key (kbd "C-c m") 'my-cite)
)
(add-hook 'TeX-mode-hook 'my-tex-mode-hook)

;; Add return after C-c C-j.
(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (local-set-key "\C-c\C-j"
          	   (lambda () (interactive)
	           (LaTeX-insert-item) (TeX-newline)
))))

;; Command to run BibTeX directly.
;; http://comments.gmane.org/gmane.emacs.auc-tex/925
(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-c C-g")
                (lambda () (interactive) (TeX-command-menu "BibTeX")))))

;; Command to run LaTeX directly and force it always to run.
(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (local-set-key (kbd "<S-f5>")
                (lambda () (interactive) (TeX-command-menu "LaTeX")))
; 	    (local-set-key (kbd "C-c C-a")
;                (lambda () (interactive) (TeX-command-menu "LaTeX")))
            (local-set-key (kbd "C-M-[") 'LaTeX-find-matching-begin)
            (local-set-key (kbd "C-M-]") 'LaTeX-find-matching-end)
            ))

;; Check next function: is the backward sentence needed?
;; It sometimes reformats the previous line!
;; http://stackoverflow.com/questions/539984/how-do-i-get-emacs-to-fill-sentences-but-not-paragraphs
(defun fill-sentence ()
  (interactive)
  (save-excursion
    (or (eq (point) (point-max)) (forward-char))
    (forward-sentence -1)
;    (indent-relative t)
    (let ((beg (point))
          (ix (string-match "LaTeX" mode-name)))
      (forward-sentence)
      (if (and ix (equal "LaTeX" (substring mode-name ix)))
          (LaTeX-fill-region-as-paragraph beg (point))
        (fill-region-as-paragraph beg (point))))))
(global-set-key (kbd "<f7>") 'fill-sentence)

;; From comment at https://nickhigham.wordpress.com/2016/01/06/managing-bibtex-files-with-emacs/
(defvar bp/bibtex-fields-ignore-list
  '("keywords" "abstract" "file" "issn" "eprint" "issue_date" "publisher"
    "address" "articleno" "numpages" "acmid"))
(defun bp/bibtex-clean-entry-hook ()
  (save-excursion
  (let (bounds)
  (when (looking-at bibtex-entry-maybe-empty-head)
  (goto-char (match-end 0))
  (while (setq bounds (bibtex-parse-field))
  (goto-char (bibtex-start-of-field bounds))
  (if (member (bibtex-name-in-field bounds)
  bp/bibtex-fields-ignore-list)
  (kill-region (caar bounds) (nth 3 bounds))
  (goto-char (bibtex-end-of-field bounds))))))))
(add-hook 'bibtex-clean-entry-hook 'bp/bibtex-clean-entry-hook)
(global-set-key (kbd "<f7>") 'fill-sentence)

;; Single space after period denotes end of sentence.
(setq sentence-end-double-space nil)

;; http://emacswiki.org/emacs/UnfillParagraph
;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))
(global-set-key (kbd "<S-f7>") 'unfill-paragraph)

(defun unfill-region ()
  "Unfill a region, i.e., make text in that region not wrap."
   (interactive)
   (let ((fill-column (point-max)))
   (fill-region (region-beginning) (region-end) nil)))

(defun fill-to-end-of-buffer ()
"Fill to end of buffer."
(interactive)
(save-excursion
(delete-trailing-whitespace)
(fill-region (point) (point-max) nil)
(untabify (point) (point-max))))

;; --------------------------------------------------------
;; AUCTeX stuff.

;; Next line definitely not needed now I have auctex installed from Gnu Elpa.
;; (load "auctex.el" nil t t) ;; Not clear if this is needed.

(setq TeX-parse-self t); Enable parse on load.
(setq TeX-PDF-mode t)
(setq TeX-save-query nil); No autosave before compiling
(setq TeX-quote-after-quote 1); Now fancy quotes only on hitting "".

;; May not need next line, unless parse on load proves slow.
;; Useful for multi-file docs, so turn on locally for them.
;; (setq TeX-auto-save t);  Enable save of parsed info to ./auto.

;; Turn off AucTex previewing.
;; (load "preview-latex.el" nil t t)
;; Is latter necessary - turned off while trying 24.4 and doesn't seem
;; needed.  Needed on Mac else tex-buf fails to load below.
;; But the load auctex above avoid the latter problem.

; Section titles in color but not larger font.
(setq font-latex-fontify-sectioning 'color)
;; Turn off AucTex special fonts for subscripts etc.
(setq font-latex-fontify-script nil)

(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(setq reftex-plug-into-AUCTeX t)            ; Integrate RefTeX with AUCTeX.

;; This redefinition is to make njh-open-cite-pdf work in comments, as by
;; default RefTeX doesn't want to let reftex-view-crossref work in
;; comments.  Hope it doesn't have any unwanted side effects.
(defun reftex-in-comment ()
  "Return non-nil if point is in a comment."
   (interactive)
   nil)

(add-hook 'text-mode-hook 'my-cite-hook)  ;; And in org mode, below.
(add-hook 'matlab-mode-hook 'my-cite-hook)
(add-hook 'lisp-interaction-mode-hook 'my-cite-hook) ;; For scratch buffer.

;; So RefTeX knows where to look when not in a .tex file.
(setq reftex-default-bibliography
      (quote
       ("njhigham.bib" "la.bib" "strings.bib" "misc.bib" "work.bib")))
;; work.bib is solely for entries I want to include but not cite.

(setq reftex-ref-macro-prompt nil) ; No prompt for ref type (new to 24.3).
;; Specifying how AUCTeX creates labels for these environments.
;; Note that refs to eq* envs set to use \eqref.
(setq reftex-label-alist
'(
("algorithm"   ?a "alg."  "~\\ref{%s}" t   ("Algorithm"))
("corollary"   ?c "cor."  "~\\ref{%s}" t   ("Corollary"))
("definition"  ?d "def."  "~\\ref{%s}" nil ("Definition" "Definitions"))
(nil           ?e ""      "~\\eqref{%s}" nil nil )  ; equation, eqnarray
(nil           ?i ""      "~\\ref{%s}" nil nil )  ; item
("example"     ?z "ex."   "~\\ref{%s}" t   ("Example" "Examples"))
("figure"      ?f "fig."  "~\\ref{%s}" t   ("Figure" "Figures"))
("lemma"       ?l "lem."  "~\\ref{%s}" t   ("Lemma"))
("assumption"  ?m "ass."  "~\\ref{%s}" t   ("Assumption"))
("problem"     ?x "prob." "~\\ref{%s}" t   ("Problem"))
("proposition" ?p "prop." "~\\ref{%s}" t   ("Proposition"))
("code"        ?n "line." "~\\ref{%s}" nil nil) ;; Doesn't work!
(nil           ?s "sec."  "~\\ref{%s}" nil nil)
("table"       ?t "table."  "~\\ref{%s}" t   ("Tables" "Tables"))
("theorem"     ?h "thm."  "~\\ref{%s}" t   ("Theorem" "Theorems"))
	)
)
(setq reftex-insert-label-flags (quote ("s" "seftacihlpz")))

(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (LaTeX-add-environments
	     '("algorithm" LaTeX-env-label)
	     '("corollary" LaTeX-env-label)
	     '("definition" LaTeX-env-label)
	     '("example" LaTeX-env-label)
	     '("lemma" LaTeX-env-label)
	     '("mylist2" nil)
	     '("problem" LaTeX-env-label)
	     '("proposition" LaTeX-env-label)
	     '("theorem" LaTeX-env-label)
	     )
	    )
	  )

(setq LaTeX-eqnarray-label ""
      LaTeX-equation-label ""
      LaTeX-figure-label "fig"
      LaTeX-table-label "table"
      LaTeX-indent-level 0  ; default 2
      LaTeX-item-indent 0   ; default 2
)

;; This causes latex-mode not to start on loading a .tex file.  Why?
;; ;; Support for latexmk
;; ;; https://github.com/jedrz/.emacs.d/blob/master/setup-latex-mode.el
;; (use-package auctex-latexmk
;;   :load-path "~/dropbox/elisp/auctex-latexmk"
;;   :defer t
;;   :init
;;   (with-eval-after-load 'latex
;;     (auctex-latexmk-setup)
;;     (setq auctex-latexmk-inherit-TeX-PDF-mode t)
;;     ))

(use-package bratex
  :load-path "~/dropbox/elisp/bratex"
  :config
  ;; (require 'bratex)
  (add-hook 'LaTeX-mode-hook #'bratex-config)
)

;; This is slow to load!
;; Support for latexmk
(use-package auctex-latexmk
  ;; Neither "defer" or "after" allow it to load.
  ;; :defer
  ;; :after (auctex)
;;  :load-path "~/dropbox/elisp/auctex-latexmk"
  :config
     (auctex-latexmk-setup)
     (setq auctex-latexmk-inherit-TeX-PDF-mode t)
)

;; This loads no faster than the use-package variant above (3 secs).
;; (add-to-list 'load-path "~/dropbox/elisp/auctex-latexmk")
;; (require 'auctex-latexmk)
;; (auctex-latexmk-setup)
;; (setq auctex-latexmk-inherit-TeX-PDF-mode t)

;; http://vince-debian.blogspot.co.uk/2007/11/reftex-and-beamer.html
;; http://emacsworld.blogspot.co.uk/2008/03/getting-beamer-frame-titles-into-reftex.html
;; Don't need the hook!  I think the (require 'reftex) above suffices.
;; The sorting of entries comes out fine.
;; (add-hook 'LaTeX-mode-hook (lambda ()
;;   (turn-on-reftex)
  (setq reftex-section-levels
    (cons '("Article" . -1) reftex-section-levels))  ;; PCAM
  (setq reftex-section-levels
  (append '(("begin{frame}" . -3) ) reftex-section-levels))
;;   (append '(("begin{frame}" . -3) ("frametitle" . -3))  reftex-section-levels))
  ;; NB: previous line produces list with unwanted outer parens if cons is
  ;;     used in place of append.
  ;; (setq reftex-section-levels
  ;;   (cons '("begin{frame}" . -3) reftex-section-levels))
  ;; (setq reftex-section-levels
  ;;   (cons '("frametitle" . -3) reftex-section-levels))
;;  ))

;; Turn off Auctex autoindent, which is annoying in version 11.90.2.
;; http://stackoverflow.com/questions/21862391/prevent-auctex-indentation-with-fill-paragraph
;; http://stackoverflow.com/questions/10743708/emacs-turn-off-indentation-when-doing-a-paragraph-fill-in-latex-mode
(add-hook 'LaTeX-mode-hook
          (lambda ()
;;   https://www.gnu.org/software/auctex/manual/auctex/Indenting.html
;;            (define-key latex-map (kbd "RET") 'LaTeX-newline)
            (local-set-key (kbd "RET") 'LaTeX-newline)
            (setq LaTeX-insert-into-comments nil) ;; Else adds unwanted "%".
;             (kill-local-variable 'line-indent-function)
;;            (setq LaTeX-indent-level 0)
;;            (setq LaTeX-item-indent 0)
;;            (setq fill-indent-according-to-mode nil))
))

;---------------------------------
;; Let AucTeX know about my own macros.
;; Fontification
;; http://tex.stackexchange.com/questions/85849/auctex-new-commands-recognized-as-such
;; http://lists.gnu.org/archive/html/emacs-orgmode/2009-05/msg00236.html
;; http://www.gnu.org/software/auctex/manual/auctex/Fontification-of-macros.html

; Use next line for standard macros.
      ;; (setq font-latex-match-reference-keywords
      ;; '(
      ;;   ("cite" "[{")
      ;;   ))
(setq font-latex-match-italic-command-keywords
      '(
        ;; ("cite" "[{")
        ("iemph" "{")
        ("citet" "{")
        ))
;---------------------------------

;; http://stackoverflow.com/questions/10531115/insert-starred-environment-or-command-in-auctex
(defun LaTeX-star-environment()
  "Convert between the starred and the not starred version of the current environment."
  (interactive)
  ;; If the current environment is starred.
  (if (string-match "\*$" (LaTeX-current-environment))
    ;; Remove the star from the current environment.
    (LaTeX-modify-environment (substring (LaTeX-current-environment) 0 -1))
    ;; Else add a star to the current environment.
    (LaTeX-modify-environment (concat (LaTeX-current-environment) "*"))))
(add-hook 'LaTeX-mode-hook '(lambda () (local-set-key (kbd "C-c C-u") 'LaTeX-star-environment)))

;; PDF previewers.
(if (system-is-windows)
(progn
(setq TeX-view-program-list '(("Sumatra" "\"SumatraPDF.exe\" -reuse-instance %o")))
;; (setq TeX-view-program-list '(("Sumatra" "\"C:/Program Files (x86)/SumatraPDF/SumatraPDF.exe\" -reuse-instance %o")))
;; (setq TeX-view-program-list '(("Sumatra" "Sumatra_emacs.bat %o") ))
(setq TeX-view-program-selection '((output-pdf "Sumatra") (output-dvi "dviout")))
))

;; Following didn't work when put within previous progn.
;; http://william.famille-blum.org/blog/static.php?page=static081010-000413
(if (system-is-windows)
(require 'sumatra-forward)   ; For forward search.
)

;; From http://www.bleedingmind.com/index.php/2010/06/17/synctex-on-linux-and-mac-os-x-with-emacs/
;; Trying TeX-view-program-list-builtin (added "builtin") doesn't help.
(if (system-is-mac)
(progn
(setq TeX-view-program-list
'(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b")
("Preview" "open -a Preview.app %o")))
(setq TeX-view-program-selection '((output-pdf "Skim")))
))
;; Then f5 and C-c C-v open Skim at the current Emacs location.
;; See also, for a different set of arguments to Skim (oddly):
;; http://stackoverflow.com/questions/7899845/emacs-synctex-skim-how-to-correctly-set-up-syncronization-none-of-the-exia

;; My function to open TeX file in Acrobat (for printing or talk).
;; Only intended for Windows.  Need to modify for Mac.
;; https://stackoverflow.com/questions/17325713/looking-for-a-replace-in-string-function-in-elisp
(defun open-in-acrobat (arg)
  "Open PDF of current LaTeX buffer in Acrobat."
  (interactive "p")
  (shell-command
   (concat "start /pgm Acrobat.exe "
   (file-name-sans-extension (buffer-file-name)) ".pdf" )
   ))
(global-set-key [C-S-f5]'open-in-acrobat)

;; http://tex.stackexchange.com/questions/24510/pdflatex-fails-within-emacs-app-but-works-in-terminal
;; This is needed on MBPro w/Mountain Lion and TeXLiVe 2012
;; in order that pdflatex is found.
(if (system-is-mac)
(progn
; For LaTeX:
(setenv "PATH"
(concat "/usr/texbin" ":" "/Library/TeX/texbin" ":" (getenv "PATH")))
; For gpg:
; http://danzorx.tumblr.com/post/11976550618/easypg-for-emacs-on-os-x-or-sometimes-emacs-doesnt
(add-to-list 'exec-path "/usr/local/bin")
;; Next line needed because not all env variables inherited by Emacs shell.
;; (setenv "BIBINPUTS" "/Users/nick/texmf/bibtex/bib;.")
(setenv "BIBINPUTS" (concat (getenv "HOME") "/texmf/bibtex/bib:."))
))

;;------------------------------------------------------------
;; https://with-emacs.com/posts/tips/quit-current-context/
(defun keyboard-quit-context+ ()
  "Quit current context.

This function is a combination of `keyboard-quit' and
`keyboard-escape-quit' with some parts omitted and some custom
behavior added."
  (interactive)
  (cond ((region-active-p)
         ;; Avoid adding the region to the window selection.
         (setq saved-region-selection nil)
         (let (select-active-regions)
           (deactivate-mark)))
        ((eq last-command 'mode-exited) nil)
        (current-prefix-arg
         nil)
        (defining-kbd-macro
          (message
           (substitute-command-keys
            "Quit is ignored during macro defintion, use \\[kmacro-end-macro] if you want to stop macro definition"))
          (cancel-kbd-macro-events))
        ((active-minibuffer-window)
         (when (get-buffer-window "*Completions*")
           ;; hide completions first so point stays in active window when
           ;; outside the minibuffer
           (minibuffer-hide-completions))
         (abort-recursive-edit))
        (t
         (when completion-in-region-mode
           (completion-in-region-mode -1))
         (let ((debug-on-quit nil))
           (signal 'quit nil)))))

(global-set-key [remap keyboard-quit] #'keyboard-quit-context+)

;;------------------------------------------------------------
;; Question about how reliably this works.
;; http://www.emacswiki.org/emacs/TN#toc8
(require 'tex-buf)
(defun TeX-command-default (name)
  "Next TeX command to use. Most of the code is stolen from `TeX-command-query'."
  (cond ((if (string-equal name TeX-region)
			     (TeX-check-files (concat name "." (TeX-output-extension))
					      (list name)
					      TeX-file-extensions)
			   (TeX-save-document (TeX-master-file)))
			 TeX-command-default)
			((and (memq major-mode '(doctex-mode latex-mode))
			      (TeX-check-files (concat name ".bbl")
					       (mapcar 'car
						       (LaTeX-bibliography-list))
					       BibTeX-file-extensions))
			 ;; We should check for bst files here as well.
			 TeX-command-BibTeX)
			((TeX-process-get-variable name
						   'TeX-command-next
						   TeX-command-Show))
			(TeX-command-Show)))

;; NJH: added next line in place of the one after to stop viewer being called.
(setq TeX-texify-Show nil)
;; (defcustom TeX-texify-Show t "Start view-command at end of TeX-texify?" :type 'boolean :group 'TeX-command)
(defcustom TeX-texify-max-runs-same-command 5 "Maximal run number of the same command" :type 'integer :group 'TeX-command)

(defun TeX-texify-sentinel (&optional proc sentinel)
  "Non-interactive! Call the standard-sentinel of the current LaTeX-process.
If there is still something left do do start the next latex-command."
  (set-buffer (process-buffer proc))
  (funcall TeX-texify-sentinel proc sentinel)
  (let ((case-fold-search nil))
    (when (string-match "\\(finished\\|exited\\)" sentinel)
      (set-buffer TeX-command-buffer)
      (unless (plist-get TeX-error-report-switches (intern (TeX-master-file)))
	(TeX-texify)))))

(defun TeX-texify ()
  "Get everything done."
  (interactive)
  (let ((nextCmd (TeX-command-default (TeX-master-file)))
	proc)
    (if (and (null TeX-texify-Show)
	     (equal nextCmd TeX-command-Show))
	(when  (called-interactively-p 'any)
	  (message "TeX-texify: Nothing to be done."))
      (TeX-command nextCmd 'TeX-master-file)
      (when (or (called-interactively-p 'any)
		(null (boundp 'TeX-texify-count-same-command))
		(null (boundp 'TeX-texify-last-command))
		(null (equal nextCmd TeX-texify-last-command)))
	(mapc 'make-local-variable '(TeX-texify-sentinel TeX-texify-count-same-command TeX-texify-last-command))
	(setq TeX-texify-count-same-command 1))
      (if (>= TeX-texify-count-same-command TeX-texify-max-runs-same-command)
	  (message "TeX-texify: Did %S already %d times. Don't want to do it anymore." TeX-texify-last-command TeX-texify-count-same-command)
	(setq TeX-texify-count-same-command (1+ TeX-texify-count-same-command))
	(setq TeX-texify-last-command nextCmd)
	(and (null (equal nextCmd TeX-command-Show))
	     (setq proc (get-buffer-process (current-buffer)))
	     (setq TeX-texify-sentinel (process-sentinel proc))
	     (set-process-sentinel proc 'TeX-texify-sentinel))))))

(add-hook 'LaTeX-mode-hook '(lambda () (local-set-key (kbd "C-c C-y") 'TeX-texify)))

;; Run make.bat file.  For particular use to run makeindex.
(if (system-is-windows)
(defun make()
   (interactive)
   (TeX-save-document (TeX-master-file)) ;; From tex-buf.el.
   (shell-command (concat "make.bat "
       (file-name-sans-extension buffer-file-name))))
)

(defun TeX-remove-macro ()
  "Remove current macro and return `t'.  If no macro at point,
return `nil'."
  (interactive)
  (when (TeX-current-macro)
    (let ((bounds (TeX-find-macro-boundaries))
          (brace  (save-excursion
                    (goto-char (1- (TeX-find-macro-end)))
                    (TeX-find-opening-brace))))
      (delete-region (1- (cdr bounds)) (cdr bounds))
      (delete-region (car bounds) (1+ brace)))
    t))

; (eval-after-load "tex"
; '(local-set-key (kbd "M-DEL") 'mg-TeX-delete-current-macro))
; The latter didn't override the default M-DEL (backward-kill-word),
;; so try making it global.  NB: M-DEL = M-backspace.
(global-set-key (kbd "M-DEL") 'TeX-remove-macro)

;; My simplified version of TeX-home-buffer.
;; Just go to master buffer.
(defun TeX-master-buffer ()
  "Go to the master TeX file."
  (interactive)
      (find-file (TeX-master-file TeX-default-extension))
)
(add-hook 'LaTeX-mode-hook '(lambda ()
                            (local-set-key (kbd "C-c ^")
                            'TeX-master-buffer)))

;; http://mbork.pl/2016-07-04_Compiling_a_single_Beamer_frame_in_AUCTeX
;; LaTeX current slide as _region-.tex (useful for bib Beamer files).
;; Can add advice to avoid having to press enter on LaTeX command.
(defun LaTeX-command-beamer-frame ()
  "Run `TeX-command-region' on the current frame environment."
  (interactive)
  (save-mark-and-excursion
    (while (not (looking-at-p "\\\\begin *{frame}"))
      (LaTeX-find-matching-begin))
    (forward-char)
    (LaTeX-mark-environment)
    (TeX-command-region)))


;; -------------------------------------------------
;; http://www.emacswiki.org/emacs/TransposeWindows
;; Ideally, want prefix arg to reverse order of rotation - TODO.
(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond
   ((not (> (count-windows) 1))
    (message "You can't rotate a single window!"))
   (t
    (let ((i 1)
          (num-windows (count-windows)))
      (while  (< i num-windows)
        (let* ((w1 (elt (window-list) i))
               (w2 (elt (window-list) (+ (% i num-windows) 1)))
               (b1 (window-buffer w1))
               (b2 (window-buffer w2))
               (s1 (window-start w1))
               (s2 (window-start w2)))
          (set-window-buffer w1 b2)
          (set-window-buffer w2 b1)
          (set-window-start w1 s2)
          (set-window-start w2 s1)
          (setq i (1+ i))))))))
(global-set-key (kbd "<C-f7>") 'rotate-windows)

;; Printing
;; http://www.emacswiki.org/cgi-bin/wiki/PrintingFromEmacs

(if (system-is-windows)
(progn
(setq ps-lpr-command "c:/Program Files/gs/gs9.05/bin/gswin64c.exe")
(setq ps-lpr-switches '("-q" "-dNOPAUSE" "-dBATCH" "-sDEVICE=mswinpr2" "-sPAPERSIZE#a4"))
(setq ps-printer-name t)
(setq ps-print-header nil)
; (setq ps-header-lines 1)
))

;; Summing a column
;; http://www.emacswiki.org/emacs/RectangleAdd (renamed to *sum).
;; Note: It seems to need a space after each number.

(defun rectangle-sum (start end)
  "Add all the lines in the region-rectangle and put the result in the
   kill ring."
  (interactive "r")
  (let ((sum 0))
    (mapc (lambda (line)
            (setq sum (+ sum (rectangle-sum-make-number line))))
          (extract-rectangle start end))
    (kill-new (number-to-string sum))
    (message "%s" sum)))

(defun rectangle-sum-make-number (n)
  "Turn a string into a number, being tolerant of commas and even other
   'junk'."
(while (string-match "[^0-9.]" n)
  (setq n (replace-match "" nil nil n)))
  (string-to-number n))

;;; * Org Mode
(setq org-directory "~/Dropbox/org")

(require 'ox-latex)
;; extarticle allows font sizes 9, 14, 17, 20pt.
(add-to-list 'org-latex-classes
  '("extarticle"
     "\\documentclass[14pt]{extarticle}"
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
    )

;;  http://katherine.cox-buday.com/blog/2015/03/14/writing-specs-with-org-mode/
(add-to-list 'org-latex-classes
'("memoir"
"\\documentclass{memoir}
[DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; This turns off default packages, one of which (textcomp) messes up
;; bullets in itemize.  May only need this when using Lucida.
;; Don't think I can specify packages to load here.
;; [2017-12-12 Tue 20:24] Added the \usepackage but they don't work!
(add-to-list 'org-latex-classes
'("basic"
"\\documentclass[12pt]{extarticle}
\\usepackage{a4}
\\usepackage[hyphens]{url}
\\usepackage{hyperref}
\\usepackage{amssymb}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; https://emacs.stackexchange.com/questions/12878/how-to-change-style-of-hyperlinks-within-pdf-published-from-org-mode-document/12879
(add-to-list 'org-latex-default-packages-alist "\\PassOptionsToPackage{hyphens}{url}")

;; https://blog.karssen.org/2013/08/22/using-bibtex-from-org-mode/
;; Use latexmk for PDF export
(setq org-latex-pdf-process (list "latexmk -pdf %f"))

;; Next line seems needed to make org functions available outside org,
;; before org has been invoked (C-c d above).
;; (require 'ox-beamer)

(setq org-default-notes-file (concat org-directory "/todo.org"))
;; With just one file specified this file's contents specify the files.
;; Explained in org.el, but not the manual.
(setq org-agenda-files (concat org-directory "/agenda_files.txt"))

;; http://orgmode.org/worg/org-tutorials/orgtutorial_dto.html
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;; iswitchb is now obsolete in Emacs 24.4:
;; (define-key global-map "\C-cb" 'org-iswitchb)  ; ORG manual.
(setq org-log-done t)  ;; Add time stamp when move to DONE state.
;; To get ido completion (http://patchwork.newartisans.com/patch/84):
(setq org-completion-use-ido t)
(setq org-completion-use-iswitchb nil)

;; This stops hitting return after a URL opening browser.
;; (setq org-return-follows-link t)
(setq org-return-follows-link nil)

(setq org-src-fontify-natively t)   ;; http://irreal.org/blog/?p=671

;; Causes problems! See notes.
;; (setq org-list-allow-alphabetical t) ;; Allows "a)" numbering. And "A."!

(define-key global-map (kbd "C-M-SPC") 'org-capture)  ; Was "\C-cc"
(define-key global-map (kbd "C-M-=")
   (lambda () (interactive) (org-capture nil "t")))  ; Create TODO.

(add-hook 'org-mode-hook
	  '(lambda()
	     ;; (local-unset-key [C-S-left])  ; Prefer buffer-move (see above).
	     ;; (local-unset-key [C-S-right])
	     ;; (local-unset-key [C-S-up])
	     ;; (local-unset-key [C-S-down])
	     (local-set-key [M-S-up]   'move-line-up)
	     (local-set-key [M-S-down] 'move-line-down)
	     (local-unset-key (kbd "M-a")) ; Prefer Ace-jump.
	     (local-unset-key (kbd "C-c [")) ; Prefer my-cite
	     (local-unset-key (kbd "S-<return>")) ; Prefer smart-open-line.
             (local-set-key (kbd "C-c &") 'reftex-view-crossref)
;;	     (local-unset-key (kbd "C-]")) ; Prefer nothing
;;             (local-set-key (kbd "<f5>") 'org-export-as-pdf)
;; Latter line doesn't work in ORG 8.0.
;             (local-set-key (kbd "<f5>") 'org-latex-export-to-pdf)
           (local-set-key (kbd "<f5>")
;;           (lambda () (interactive) (save-buffer) (org-latex-export-to-pdf)))
           (lambda () (interactive) (save-buffer)
                      (org-open-file (org-latex-export-to-pdf))))
           ))

;; Next assignment is the default minus "fdb_latexmk". Reason is that in Emacs 27.1
;; I'm getting errors
;; "Processing LaTeX file whatis.tex...
;; mapc: Removing old name: Permission denied, d:/Dropbox (Personal)/org/whatis.fdb_latexmk"
(setq org-latex-logfiles-extensions
  '("aux" "bcf" "blg" "fls" "figlist" "idx" "log" "nav" "out"
    "ptc" "run.xml" "snm" "toc" "vrb" "xdv"))

;; Link abbrevations.
(setq org-link-abbrev-alist
       '(("doi" . "https://doi.org/")
         ("google"   . "http://www.google.com/search?q=")
        ))

(defun my-insert-inactive-timestamp ()
  (interactive)
;  (beginning-of-line)
;  (insert "   ")
  (org-insert-time-stamp nil t t nil nil nil))
(global-set-key (kbd "C-c d") 'my-insert-inactive-timestamp) ; Global!

;; From http://doc.norang.ca/org-mode.html
(defun my-insert-TODO ()
  (interactive)
  (insert "** TODO "))
; (defun my-org-mode-hook ()
;     (local-set-key (kbd "C-M-=") 'my-insert-TODO)) ; Override global setting.
; (add-hook 'org-mode-hook 'my-org-mode-hook)
; Could simply not get next hook to work with C-M-=!
(add-hook 'org-mode-hook
	  '(lambda()
             (local-set-key (kbd "C-=") 'my-insert-TODO)
	     ))

; Go to top outline level.  Useful before org2blog-post-subtree.
(defun my-top-level ()
  (interactive)
  (let ((current-prefix-arg '(9))) ; Assuming at most 9 levels in.
  (call-interactively 'outline-up-heading)))
;; (add-hook 'org-mode-hook
;; 	  '(lambda()
;;              (local-set-key (kbd "C-M-[") 'my-top-level)
;; 	     ))
; Make next keypress global, since I can't make C-M-... keypresses
; local in ORG mode (same problem with 'my-insert-TODO).
(global-set-key (kbd "C-M-u") 'my-top-level)
; (global-set-key [S-f11] 'org2blog/wp-post-subtree)
(global-set-key [S-f11] 'org2blog-subtree-post-save)
(global-set-key [M-f11] 'org2blog-buffer-post-publish)

;; This doesn't work when already at top level.
;; (defun my-wp-post-subtree ()
;;   "Move to top outline level then post"
;;   (interactive)
;;   (progn (my-top-level) (org2blog/wp-post-subtree)))
;; (global-set-key [S-f11] 'my-wp-post-subtree)

;; This is originally assigned to C-j. See how it goes.
;; I want it so that lists easier to enter.
;; Turned off, since has unwanted effects, e.g. in todo.org.
;; Either turn on selectively or use C-j.
;; (define-key org-mode-map (kbd "<return>") 'org-return-indent)

(setq org-capture-templates
   '(("t" "TODO" entry (file+headline (concat org-directory "/todo.org")
;;                                       "Captures")
                                       "General")
       "* TODO %?\n  %U\n  %a" :prepend t :empty-lines 0)
    ("e" "CLAIMED" entry (file+headline (concat org-directory "/todo.org")
                                       "Expense claims")
       "* %?\n  %U\n  %a" :prepend t :empty-lines 0)
    ("i" "item" entry (file+headline (concat org-directory "/todo.org")
                                       "General")
       "* %?\n  %U\n  %a" :prepend t :empty-lines 0)
))
(setq org-reverse-note-order t)  ;; Refile at top instead of bottom.

(setq org-todo-keywords
           '((sequence "TODO(t!)" "WAITING(w!)" "|" "DONE(d!)")
             (sequence "CLAIMED(c!)" "ON THE WAY(o!)" "|" "RECEIVED(r!)")
             )
)

;; Needs updating for Org 9.2.
;; ;; http://irreal.org/blog/?p=2029
;; (add-to-list 'org-structure-template-alist
;;              '("n" "#+BEGIN_COMMENT\n?\n#+END_COMMENT"
;;                "<comment>\n?\n</comment>"))

;; Now in Org 7.8.11 as org-table-transpose-table-at-point
;; http://orgmode.org/worg/org-hacks.html
;; (defun org-transpose-table-at-point ()
;;   "Transpose orgmode table at point, eliminate hlines"
;;   (interactive)
;;   (let ((contents
;;          (apply #'mapcar* #'list
;;                 ;; remove 'hline from list
;;                 (remove-if-not 'listp
;;                                ;; signals error if not table
;;                                (org-table-to-lisp)))))
;;     (delete-region (org-table-begin) (org-table-end))
;;     (insert (mapconcat (lambda(x) (concat "| " (mapconcat 'identity x " | " ) "  |\n" ))
;;                        contents ""))
;;     (org-table-align)))

;; http://www.patokeefe.com/blog
;; Modified by NJH.
(defun orgtbl-to-latex-matrix (table params)
  "Convert the Orgtbl mode TABLE to a LaTeX Matrix."
  (interactive)
  (let* ((params2
          (list
           :tstart (concat "\\[\n\\bmatrix{")
           :tend "}\n\\]"
           :lstart "" :lend " \\cr" :sep " & "
           :efmt "%s%s" :hline "\\hline")))
    (orgtbl-to-generic table (org-combine-plists params2 params))))

(defun orgtbl-insert-matrix ()
  "Insert a radio table template appropriate for this major mode."
  (interactive)
  (let* ((txt orgtbl-latex-matrix-string)
         name pos)
    (setq name (read-string "Table name: "))
    (while (string-match "%n" txt)
      (setq txt (replace-match name t t txt)))
    (or (bolp) (insert "\n"))
    (setq pos (point))
    (insert txt)
    (previous-line)
    (previous-line)))

(defcustom orgtbl-latex-matrix-string  "% BEGIN RECEIVE ORGTBL %n
% END RECEIVE ORGTBL %n
\\begin{comment}
#+ORGTBL: SEND %n orgtbl-to-latex-matrix :splice nil :skip 0

\\end{comment}\n"
  "Template for the latex matrix orgtbl translator
All occurrences of %n in a template will be replaced with the name of the
table, obtained by prompting the user."
  :type 'string
  :group 'org-table)

(if (system-is-windows)
;; Open PDFs visited in Org-mode in Sumatra (not the default choice, Acrobat).
;; http://stackoverflow.com/a/8836108/789593
(add-hook 'org-mode-hook
   '(lambda ()
      (delete '("\\.pdf\\'" . default) org-file-apps)
;;      (add-to-list 'org-file-apps '("\\.pdf\\'" . "d:\\bat\\sumatra_emacs.bat %s")))
;;      (add-to-list 'org-file-apps '("\\.pdf\\'" . "\"C:/Program Files (x86)/SumatraPDF/SumatraPDF.exe\" -reuse-instance %s")))
      (add-to-list 'org-file-apps '("\\.pdf\\'" . "\"C:/Program Files/SumatraPDF/SumatraPDF.exe\" -reuse-instance %s")))
))

;; Open PDFs in Skim instead of Acrobat.
(if (system-is-mac)
(add-hook 'org-mode-hook
   '(lambda ()
      (delete '("\\.pdf\\'" . default) org-file-apps)
      (add-to-list 'org-file-apps '("\\.pdf\\'" . "skim %s")
))))

;; Mobile org
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/dropbox/org/todo.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

;; Activate additional Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((calc . t)
   ))

;;; * Misc

;; Useful functions for generating html from org, e.g. to paste into
;; Wordpress.

;; http://sachachua.com/blog/2014/10/publishing-wordpress-thumbnail-images-using-emacs-org2blog/
;; http://pages.sachachua.com/.emacs.d/Sacha.html#sec-1-8-18-5
(defun sacha/org-copy-region-as-html (beg end &optional level)
  "Make it easier to copy code for Wordpress posts and other things."
  (interactive "r\np")
  (let ((org-export-html-preamble nil)
        (org-html-toplevel-hlevel (or level 3)))
    (kill-new
     (org-export-string-as (buffer-substring beg end) 'html t))))

(defun sacha/org-copy-subtree-as-html ()
  (interactive)
  (sacha/org-copy-region-as-html
   (org-back-to-heading)
   (org-end-of-subtree)))

;; For Org to convert to doc.
;; http://blog.binchen.org/posts/how-to-take-screen-shot-for-business-people-efficiently-in-emacs.html
(setq org-odt-preferred-output-format "doc")

;; In Emacs 27.1:
;; Error (use-package): Failed to install smtpmail: Package ‘smtpmail-’ is unavailable
;; so commented out.
;; (load-file "~/Dropbox/.emacs-mail-setup")

;; http://www.howardism.org/Technical/Emacs/orgmode-wordprocessor.html
(setq org-hide-emphasis-markers t)
(add-to-list 'org-emphasis-alist
             '("*" (:foreground "pink")
               ))

;; http://pragmaticemacs.com/emacs/prevent-comments-from-breaking-paragraphs-in-org-mode-latex-export/
;; Remove comments from org document for use with export hook
;; https://emacs.stackexchange.com/questions/22574/orgmode-export-how-to-prevent-a-new-line-for-comment-lines
(defun delete-org-comments (backend)
  (loop for comment in (reverse (org-element-map (org-element-parse-buffer)
                    'comment 'identity))
    do
    (setf (buffer-substring (org-element-property :begin comment)
                (org-element-property :end comment))
          "")))
;; Add to export hook.
(add-hook 'org-export-before-processing-hook 'delete-org-comments)

;; Execute this from scratch buffer to remove the hook:
;; (remove-hook 'org-export-before-processing-hook 'delete-org-comments)

;; http://pragmaticemacs.com/emacs/highlight-latex-text-in-org-mode/
(setq org-highlight-latex-and-related '(latex))

;; For converting org tables to csv in place.
;; Useful if have several table separated by text.
;; https://stackoverflow.com/questions/17717483/howto-convert-org-mode-table-to-original-tabbed-format
(defun org-table-transform-in-place ()
  "Just like `ORG-TABLE-EXPORT', but instead of exporting to a
  file, replace table with data formatted according to user's
  choice, where the format choices are the same as
  org-table-export."
  (interactive)
  (unless (org-at-table-p) (user-error "No table at point"))
  (org-table-align)
  (let* ((format
      (completing-read "Transform table function: "
               '("orgtbl-to-tsv" "orgtbl-to-csv" "orgtbl-to-latex"
                 "orgtbl-to-html" "orgtbl-to-generic"
                 "orgtbl-to-texinfo" "orgtbl-to-orgtbl"
                 "orgtbl-to-unicode")))
     (curr-point (point)))
    (if (string-match "\\([^ \t\r\n]+\\)\\( +.*\\)?" format)
    (let ((transform (intern (match-string 1 format)))
          (params (and (match-end 2)
               (read (concat "(" (match-string 2 format) ")"))))
          (table (org-table-to-lisp
              (buffer-substring-no-properties
               (org-table-begin) (org-table-end)))))
      (unless (fboundp transform)
        (user-error "No such transformation function %s" transform))
      (save-restriction
        (with-output-to-string
          (delete-region (org-table-begin) (org-table-end))
          (insert (funcall transform table params) "\n")))
      (goto-char curr-point)
      (beginning-of-line)
      (message "Tranformation done."))
    (user-error "Table export format invalid"))))

;; https://yiufung.net/post/org-mode-hidden-gems-pt1/
;; Cut out blank lines in collapsed view.
(setq org-cycle-separator-lines 0)
;; Avoid inadvertent text edit in invisible area.
(setq org-catch-invisible-edits 'show-and-error)

;; Try this. Cursor must be at beginning of headline.  Hit "?" for help.
(setq org-use-speed-commands t)

;; https://orgmode.org/manual/Export-Settings.html
(setq org-export-allow-bind-keywords t)

;; So that C-c = calls imenu (set above).
;; https://superuser.com/questions/828713/how-to-override-a-keybinding-in-emacs-org-mode
(define-key org-mode-map (kbd "C-c =") nil)
(setq org-imenu-depth 7)

;; To allow multi-line emphasis.
;; https://emacs.stackexchange.com/questions/27892/italic-paragraphs-in-org-mode
(setf (nth 4 org-emphasis-regexp-components) 10)
(load-library "org")

;; For stripe-table-mode
(use-package stripe-buffer)

;; Reset gc threshold that was increased at start.
(setq gc-cons-threshold (* 2 1000 1000))

;; New to Emacs 27 and mentioned in \cite{peta20}.
;; Automatically loaded, it seems.
;; (use-package project)

;;; * Local Variables
;; Local Variables:
;; eval: (orgstruct-mode 1).
;; orgstruct-heading-prefix-regexp: ";;; ";
; End:
