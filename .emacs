
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (deeper-blue)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
	(youdao-dictionary w3m w3 vue-mode company-go go-complete company popup-complete popup go-mode auto-complete)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common ((t (:inherit company-preview))))
 '(company-tooltip ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-common ((((type x)) (:inherit company-tooltip :weight bold)) (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :weight bold)) (t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:background "steelblue" :foreground "white")))))

;; 设置字体
(set-default-font "Menlo-13")

;; 加载PATH
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
    "[ \t\n]*$"
    ""
    (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
  (setenv "PATH" path-from-shell)
  (setq eshell-path-env path-from-shell) ; for eshell users
  (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

;;
(setenv "GOPATH" "/Users/ckeyer/go")
(setenv "GOROOT" "/usr/local/go")

(require 'package)  
(setq package-archives  
  '(("gnu" . "http://elpa.gnu.org/packages/")  
    ("marmalade" . "http://marmalade-repo.org/packages/")  
  ("melpa" . "http://melpa.milkbox.net/packages/")
))  
(package-initialize)

(setq user-full-name "ckeyer")
(setq user-mail-address "me@ckeyer.com")

;; 显示行列号
(global-linum-mode t)
(setq column-number-mode t)
(setq line-number-mode t)

;; tab键为4个字符宽度
(setq default-tab-width 4)

;; 防止页面滚动时跳动， scroll-margin 3 可以在靠近屏幕边沿3行时就开始滚动，可以很好的看到上下文。
(setq scroll-margin 3 scroll-conservatively 10000)

;; 在标题栏显示buffer的名字
(setq frame-title-format "%b [%f]")

;; 屏幕滚动光标不动 
(setq scroll-step 1)
(setq scroll-preserve-screen-position 1)

;; 自动补全成对符号
(setq skeleton-pair-alist 
  '((?\" _ "\"" >)
  (?\' _ "\'" >)
  (?\( _ ")" >)
  (?\[ _ "]" >)
  (?\{ _ "}" >)
  (?\{ _ ">" >)))

(setq skeleton-pair t)

(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\'") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "<") 'skeleton-pair-insert-maybe)

;; 高亮匹配括号
(add-to-list 'load-path "~/.emacs.d/elpa/highlight-parentheses.el/")
(require 'highlight-parentheses)
(show-paren-mode 1)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)
(setq hl-paren-colors
  '(;"#8f8f8f" ; this comes from Zenburn
  ; and I guess I'll try to make the far-outer parens look like this
    "red1" "orange1" "greenyellow" "yellow1" "purple" "green1"
    "springgreen1" "cyan1" "slateblue1" "magenta1"))
;; (global-set-key [(f8)] 'loop-alpha)  ;;注意这行中的F8 , 可以改成你想要的按键

(make-directory "/tmp/.emacs.d/autosaves/" t)
(make-directory "/tmp/.emacs.d/backups/" t)
; put files
(custom-set-variables
  '(auto-save-file-name-transforms '((".*" "/tmp/.emacs.d/autosaves/" t)))
  '(backup-directory-alist '((".*" . "/tmp/.emacs.d/backups/"))))

;; MODE
(require 'go-mode)
(require 'vue-mode)

;; 自动补全
(require 'auto-complete)
;(require 'go-autocomplete)
;(require 'auto-complete-config)
;(ac-config-default)

; '(auto-complete-mode 1)
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .1)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

;; GO-HOOK
;; go get -u -v github.com/nsf/gocode
;; go get -u -v github.com/rogpeppe/godef
(defun go-run-current-buffer ()
  "save current buffer to file then exec it (go run file)"
  (interactive)
  (let ((go-source-filename (buffer-file-name (current-buffer))))
    (when go-source-filename
      (save-excursion
        (save-buffer)
        (let ((cmd (concatenate 'string
          "go run "
          go-source-filename)))
          (shell-command cmd cmd))))))
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'go-mode-hook (lambda () (hs-minor-mode 1)))
(add-hook 'go-mode-hook (lambda ()
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook (lambda ()
  (local-set-key (kbd "C-c C-i") 'go-goto-imports)))
(add-hook 'go-mode-hook (lambda ()
  (local-set-key (kbd "C-.") 'gofmt)
  (local-set-key (kbd "C-c j") 'godef-jump)
  (local-set-key (kbd "C-c z") 'pop-tag-mark)
  (local-set-key (kbd "C-c C-z") 'pop-tag-mark)
  (local-set-key (kbd "C-c C-b") 'go-run-current-buffer)
  (local-set-key (kbd "C-g C-a") 'go-goto-arguments)
  (local-set-key (kbd "C-g C-f") 'go-goto-function)
  (local-set-key (kbd "C-g C-n") 'go-goto-function-name)
  (local-set-key (kbd "C-g C-m") 'go-goto-method-receiver)
  (local-set-key (kbd "C-g C-d") 'go-goto-docstring)
  (local-set-key (kbd "C-g C-r") 'go-goto-return-values)
  (set (make-local-variable 'company-backends) '(company-go))
  (company-mode)))

(global-set-key (kbd "M-u") 'scroll-down)
(global-set-key (kbd "C-u") 'scroll-up)
(global-set-key (kbd "C-c C-g") 'goto-line)
(global-set-key (kbd "s-/") 'comment-line)

(global-set-key (kbd "C-,") 'youdao-dictionary-search-at-point+) ;; 字典查询
