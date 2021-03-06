;  Will's .emacs file

;  MODES
;  For mode help type control-h m while in that mode

;  Load Path
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; inhibut splash screen
(setq inhibit-splash-screen t)

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

; yasnippet
(add-to-list 'load-path "~/.emacs.d/yasnippet-0.8.0/")
(require 'yasnippet) ;; not yasnippet-bundle
(setq yas/snippet-dirs "~/.emacs.d/yasnippet-0.8.0/snippets")
(yas-global-mode 1)

; autocomplete
(add-to-list 'load-path "~/.emacs.d/autocomplete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/autocomplete//ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;; Let's have snippets in the auto-complete dropdown
(add-to-list 'ac-sources 'ac-source-yasnippet)

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
(setq fci-rule-column 80)
(require 'fill-column-indicator)
;(add-hook 'after-change-major-mode-hook 'fci-mode)
(global-set-key (kbd "C-x 8") 'fci-mode)

;  Prevent extraneous tabs
(setq-default indent-tabs-mode nil)
(setq default-tab-width 2)
(setq tab-width 2)
(setq java-indent-offset 2)
(setq java-indent-mode 2)
(setq c-basic-offset 2)
(setq js-indent-level 2)

;; column maker
(require 'column-marker)
(global-set-key (kbd "C-x m") 'column-marker-2)

; Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)


;  Set Paren Matching (highlights the matching paren)
(show-paren-mode 1)
(require 'paren)
(set-face-background 'show-paren-match-face (face-background 'default))
;(set-face-background 'show-paren-match-face "grey80")
(set-face-foreground 'show-paren-match-face "red1")
(set-face-attribute 'show-paren-match-face nil :weight 'extra-bold)

;; Paredit
(autoload 'paredit-mode "paredit"
      "Minor mode for pseudo-structurally editing Lisp code." t)
    (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
    (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
    (add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))

;; Paraedit for all!
(defun my-paredit-nonlisp ()
    "Turn on paredit mode for non-lisps."
      (interactive)
        (set (make-local-variable 'paredit-space-for-delimiter-predicates)
                    '((lambda (endp delimiter) nil)))
          (paredit-mode 1))


;; Paredit electric return
(defvar electrify-return-match
  "[\]}\)\"]"
  "If this regexp matches the text after the cursor, do an \"electric\"
  return.")
(defun electrify-return-if-match (arg)
  "If the text after the cursor matches `electrify-return-match' then
  open and indent an empty line between the cursor and the text.  Move the
  cursor to the new line."
  (interactive "P")
  (let ((case-fold-search nil))
    (if (looking-at electrify-return-match)
        (save-excursion (newline-and-indent)))
    (newline arg)
    (indent-according-to-mode)))

; Emacs lisp mode hook
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (paredit-mode t)
            (turn-on-eldoc-mode)
            (eldoc-add-command
             'paredit-backward-delete
             'paredit-close-round)
            (local-set-key (kbd "RET") 'electrify-return-if-match)
            (eldoc-add-command 'electrify-return-if-match)
            (show-paren-mode t)))


;  Require Paren Highlighting
(require 'highlight-parentheses)
(setq hl-paren-colors
      '("red3" "darkgreen" "yellow3" "purple3" "orange3" "blue3"
        "red4" "darkgreen" "yellow4" "purple4" "orange4" "blue4"))

(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;;
;; ace jump mode major function
;; 
(autoload
    'ace-jump-mode
      "ace-jump-mode"
        "Emacs quick move minor mode"
          t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(setq ace-jump-mode-gray-background nil)

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

;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
            (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;  Show Whitespace
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
;(global-whitespace-mode t)
(global-set-key (kbd "C-x w") 'whitespace-mode)

;;  Define Key Mappingsss

; Prevent that annoying undo message (should be using C-_)
(define-key global-map "\C-x\C-u" 'undo)
(define-key global-map "\C-\\" 'enlarge-window-horizontally) ; Enlarge window
(define-key global-map "\C-]" 'shrink-window-horizontally) ; Shrink window
(define-key global-map "\M-\\" 'enlarge-window) ; Enlarge window vertically
(define-key global-map "\M-]" 'shrink-window) ; Shrink window vertically

(global-set-key (kbd "C-l") 'goto-line) 
(global-set-key (kbd "C-x C-b") 'buffer-menu) ; Buffer Menu in present window

(global-set-key (kbd "C-c C-c") 'comment-region)   ; Comment region
(global-set-key (kbd "C-c C-v") 'uncomment-region) ; Uncomment region

;(setq word-wrap nil)
;(setq visual-line-mode t)
(setq-default truncate-lines t) ; default word-wrap to false
(global-set-key (kbd "C-x C-l") 'toggle-truncate-lines) ; toggle word-wrap

(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

; Text Mode
(setq major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;  Ruby Mode
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))

;  Scala Mode
;(require 'scala-mode-auto)

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;  YAML Mode
(require 'yaml-mode)
(setq auto-mode-alist  (cons '(".yml$" . yaml-mode) auto-mode-alist))
(add-hook 'yaml-mode-hook
          '(lambda () (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;  HTML Mode
(setq auto-mode-alist  (cons '(".rhtml$" . html-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".html$" . html-mode) auto-mode-alist))

;  Rainbow delimiters
(require 'rainbow-delimiters)

;  Clojure Mode
(require 'clojure-mode)
(setq auto-mode-alist  (cons '(".d$" . clojure-mode) auto-mode-alist))
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

;  Require nrepl
(require 'nrepl)
(add-hook 'nrepl-interaction-mode-hook
            'nrepl-turn-on-eldoc-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)


; js2 Mode
; M-x byte-compile-file RE js2-mode.el RET
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js2-highlight-level 3)

;; beautify code
;;    npm install -g js-beautify
(require 'web-beautify) ;; Not necessary if using ELPA package
(eval-after-load 'js2-mode
    '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'json-mode
    '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'sgml-mode
    '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'css-mode
    '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

;; beautify save hooks
(eval-after-load 'js2-mode
    '(add-hook 'js2-mode-hook
               (lambda ()
                 (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

(eval-after-load 'json-mode
  '(add-hook 'json-mode-hook
             (lambda ()
               (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

(eval-after-load 'sgml-mode
  '(add-hook 'html-mode-hook
             (lambda ()
               (add-hook 'before-save-hook 'web-beautify-html-buffer t t))))

(eval-after-load 'css-mode
    '(add-hook 'css-mode-hook
               (lambda ()
                 (add-hook 'before-save-hook 'web-beautify-css-buffer t t))))

; show hide tabs
(defun show-tabs ()
  (interactive)
  (let ((d (make-display-table)))
    (aset d 9 (vector ?> ?> ?>))
    (set-window-display-table nil d)))

(defun hide-tabs ()
  (interactive)
  (set-window-display-table nil nil))

(global-set-key (kbd "C-x t") 'show-tabs)
(global-set-key (kbd "C-x g") 'hide-tabs)

;; goto-line-percent
(defun goto-percent (percent)
  "Goto PERCENT of buffer."
  (interactive "nGoto percent: ")
  (goto-char (/ (* percent (point-max)) 100)))
(global-set-key (kbd "C-x p") 'goto-percent)

;; flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Remove newline checks, since they would trigger an immediate check
;; when we want the idle-change-delay to be in effect while editing.
(setq flycheck-check-syntax-automatically '(save
                                            idle-change))

(setq flycheck-idle-change-delay 10)
(setq flycheck-highlighting-mode 'symbols)
(setq flycheck-indication-mode 'left-fringe)

(global-set-key  (kbd "C-c C-p") 'flycheck-previous-error) 
(global-set-key  (kbd "C-c C-n") 'flycheck-next-error)

; auto resize split screens by golden ratio 
(require 'golden-ratio)
(golden-ratio-mode 1)

(provide '.emacs)
;;; .emacs

