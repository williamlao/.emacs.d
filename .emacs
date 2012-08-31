;;; Will's .emacs file

;  MODES
; 	For mode help type control-h m while in that mode

;  Load Path
(add-to-list 'load-path "~/.emacs.d/")

;  Color Theme
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
	     (color-theme-initialize)
			      (color-theme-hober)))

; IDO (buffer helper)
(require 'ido)
(ido-mode t)
;(setq ido-enable-flex-matching t)

;  Smooth Scrolling
(setq redisplay-dont-pause t 
      scroll-conservatively 1 
      scroll-step 0) 

; Language
(set-language-environment "utf-8")

;  Screen positioning
(setq scroll-preserve-screen-position 'always) 

; autocomplete
(add-to-list 'load-path "~/.emacs.d/autocomplete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/autocomplete//ac-dict")
(ac-config-default)

; window title
(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))

;  Highlight selections
(transient-mark-mode 1)

;  Global Modes
(global-font-lock-mode 1)
(global-auto-revert-mode 1)

;  Disable backup
(setq backup-inhibited t)
;  Disable auto save
(setq auto-save-default nil)

;  Display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;  Prevent extraneous tabs
(setq-default indent-tabs-mode nil)
(setq default-tab-width 2)
(setq tab-width 2)
(setq java-indent-offset 2)
(setq java-indent-mode 2)
(setq c-basic-offset 2)

;  Slime
(add-to-list 'load-path "~/.emacs.d/slime-2012-07-05")
(require 'slime)
(setq slime-net-coding-system 'utf-8-unix)
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
(setq inferior-lisp-program "sbcl") 
(slime-setup '(slime-fancy))

;  Set Paren Matching
; (show-paren-mode 1)
(autoload 'paredit-mode "paredit"
      "Minor mode for pseudo-structurally editing Lisp code." t)
    (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
    (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
    (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
    (add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))

;  Require Paren Highlighting
(require 'highlight-parentheses)
(setq hl-paren-colors
      '("orange1" "yellow1" "greenyellow" "green1"
        "springgreen1" "cyan1" "slateblue1" "magenta1" "purple"))
 (define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
	  (lambda ()
		  (highlight-parentheses-mode t)))
			(global-highlight-parentheses-mode t)

(add-to-list 'load-path "which-folder-ace-jump-mode-file-in/")
;; 
;; enable a more powerful jump back function from ace jump mode
;;
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;  Show Whitespace
(require 'whitespace)
(global-set-key (kbd "C-x w") 'whitespace-mode)

;  Define Key Mappings
(define-key global-map "\C-x\C-u" 'undo) ; Prevent that annoying undo message (should be using C-_)
(define-key global-map "\C-\\" 'enlarge-window-horizontally) ; Enlarge window
(define-key global-map "\C-]" 'shrink-window-horizontally) ; Shrink window
(define-key global-map "\M-\\" 'enlarge-window) ; Enlarge window vertically
(define-key global-map "\M-]" 'shrink-window) ; Shrink window vertically

(global-set-key "\C-l" 'goto-line) ; [Ctrl]-[L] 
(global-set-key (kbd "C-x C-l") 'toggle-truncate-lines) ; enable/disable word wrap
(global-set-key (kbd "C-x C-b") 'buffer-menu) ; Buffer Menu in present window

(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

;	Text Mode
(setq major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;  Ruby Mode
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))

;  Scala Mode
(require 'scala-mode-auto)

;  HTML Mode
(setq auto-mode-alist  (cons '(".rhtml$" . html-mode) auto-mode-alist))

;  Clojure Mode
(require 'clojure-mode)

;  Javascript Mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)
