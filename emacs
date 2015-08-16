
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 143 :width normal))))
 '(company-preview ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common ((t (:inherit company-preview))))
 '(company-tooltip ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-common ((((type x)) (:inherit company-tooltip :weight bold)) (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :weight bold)) (t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:background "steelblue" :foreground "white")))))

(require 'package)  
(setq package-archives  
      '(("gnu" . "http://elpa.gnu.org/packages/")  
        ("marmalade" . "http://marmalade-repo.org/packages/")  
        ("melpa" . "http://melpa.milkbox.net/packages/")))  
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/company/")
(add-to-list 'load-path "~/.emacs.d/lisp/company-go/")
(add-to-list 'load-path "~/.emacs.d/lisp/go-mode/")
(add-to-list 'load-path "~/.emacs.d/lisp/sdcv-mode/")
(add-to-list 'load-path "~/.emacs.d/lisp/highlight-parentheses/")
;;(add-to-list 'load-path "~/.emacs.d/elpa/popup-20150609.2145/")

(require 'company)
(require 'company-go)
(require 'highlight-parentheses)
(require 'sdcv-mode)
'(auto-complete-mode 1)
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

(setq user-full-name "Ckeyer")
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
(setq frame-title-format "%b ckeyer@[%f]")

;; 在行首 C-k 时，同时删除该行。
(setq-default kill-whole-line t)

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

;; 设施背景透明度
(setq alpha-list '((70 65) (100 100)))
(defun loop-alpha ()    
  (interactive)    
  (let ((h (car alpha-list)))                    
    ((lambda (a ab)    
       (set-frame-parameter (selected-frame) 'alpha (list a ab))    
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))    
       ) (car h) (car (cdr h)))    
    (setq alpha-list (cdr (append alpha-list (list h))))    
    )    
  )    

;; 全局模式
(yas-global-mode 1)
(setq elpy-rpc-backend "jedi")

;; 自定义方法
(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullscreen))
  (if (frame-parameter nil 'fullscreen)
      (display-time-mode 1))
  (if (not (frame-parameter nil 'fullscreen))
      (display-time-mode 0))
  )

(defun toggle-letter-case ()
  "Toggle the letter case of current word or text selection.
Toggles from 3 cases: UPPER CASE, lower case, Title Case,
in that cyclic order."
  (interactive)
  (let (pos1 pos2 (deactivate-mark nil) (case-fold-search nil))
	(if (and transient-mark-mode mark-active)
		(setq pos1 (region-beginning)
			  pos2 (region-end))
	  (setq pos1 (car (bounds-of-thing-at-point 'word))
			pos2 (cdr (bounds-of-thing-at-point 'word))))

	(when (not (eq last-command this-command))
	  (save-excursion
		(goto-char pos1)
		(cond
		 ((looking-at "[[:lower:]][[:lower:]]") (put this-command 'state
													 "all lower"))
		 ((looking-at "[[:upper:]][[:upper:]]") (put this-command 'state
													 "all caps") )
		 ((looking-at "[[:upper:]][[:lower:]]") (put this-command 'state
													 "init caps") )
		 (t (put this-command 'state "all lower") )
		 )
		)
	  )

	(cond
	 ((string= "all lower" (get this-command 'state))
	  (upcase-initials-region pos1 pos2) (put this-command 'state "init
caps"))
	 ((string= "init caps" (get this-command 'state))
	  (upcase-region pos1 pos2) (put this-command 'state "all caps"))
	 ((string= "all caps" (get this-command 'state))
	  (downcase-region pos1 pos2) (put this-command 'state "all lower"))
	 )
	)
  )

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
                          (local-set-key (kbd "C-c i") 'go-goto-imports)))
(add-hook 'go-mode-hook (lambda ()
						  (local-set-key (kbd "C-.") 'gofmt)
						  (local-set-key (kbd "C-c j") 'godef-jump)
						  (local-set-key (kbd "C-c C-b") 'go-run-current-buffer)
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

;; PHP-HOOK
(add-hook 'php-mode-hook (lambda () (hs-minor-mode 1)))

;; PYTHON-HOOK
;; (add-hook 'python-mode-hook 'uto-complete-mode)
(add-hook 'python-mode-hook (lambda () (hs-minor-mode 1)))
(add-hook 'python-mode-hook
  (lambda ()
    (setq indent-tabs-mode t)
    (setq python-indent-guess-indent-offset 4)
    ;; (setq python-indent 4)
    (setq tab-width 4)))
;; (add-hook 'python-mode-hook (lambda ()
;; 							  (python-shell-send-buffer "-t test.go")))
;; (set (make-local-variable 'company-backends) '(company-pysmell))

;; C-HOOK
(add-hook 'c-mode-hook (lambda () (hs-minor-mode 1)))
(add-hook 'c-mode-hook (lambda () (semantic-mode 1)))
(add-hook 'c-mode-hook (lambda ()
						  (local-set-key (kbd "C-c j") 'semantic-ia-fast-jump)))

(global-set-key (kbd "C-,") 'sdcv-search) ;; 字典查询
(global-set-key (kbd "M-g") 'goto-line) 
(global-set-key [?\S- ] 'set-mark-command) ;; Shift+Space
(global-set-key (kbd "C-c ,") (kbd "C-c @ C-h"))
(global-set-key (kbd "C-c .") (kbd "C-c @ C-s"))  
(global-set-key (kbd "<f12>") 'toggle-fullscreen)
(global-set-key (kbd "<C-tab>") 'other-window)
