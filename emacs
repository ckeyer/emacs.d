
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

(add-to-list 'load-path "~/.emacs.d/elpa/company-0.8.12/")
(add-to-list 'load-path "~/.emacs.d/elpa/go-mode-20150503.258/")
(add-to-list 'load-path "~/.emacs.d/lisp/sdcv-mode/")
(add-to-list 'load-path "~/.emacs.d/lisp/highlight-parentheses/")
;;(add-to-list 'load-path "~/.emacs.d/elpa/popup-20150609.2145/")

(require 'company)
(require 'company-go)
(require 'highlight-parentheses)
(require 'sdcv-mode)

(global-set-key (kbd "C-,") 'sdcv-search) ;; 字典查询
(global-set-key (kbd "M-g") 'goto-line) 
(global-set-key [?\S- ] 'set-mark-command) ;; Shift+Space
(global-set-key (kbd "C-c ,") (kbd "C-c @ C-h"))
(global-set-key (kbd "C-c .") (kbd "C-c @ C-s"))  

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

;; tab键为8个字符宽度
(setq default-tab-width 4)

;; 防止页面滚动时跳动， scroll-margin 3 可以在靠近屏幕边沿3行时就开始滚动，可以很好的看到上下文。
(setq scroll-margin 3 scroll-conservatively 10000)

;; 在标题栏显示buffer的名字
(setq frame-title-format "emacs@%b")

;; 在行首 C-k 时，同时删除该行。
(setq-default kill-whole-line t)

;; 自动补全成对符号
(setq skeleton-pair-alist 
      '((?\" _ "\"" >)
	(?\' _ "\'" >)
	(?\( _ ")" >)
	(?\[ _ "]" >)
	(?\{ _ "}" >)))

(setq skeleton-pair t)

(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\'") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)


;; 高亮匹配括号
(show-paren-mode 1)
;; (global-set-key [(f8)] 'loop-alpha)  ;;注意这行中的F8 , 可以改成你想要的按键

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

;; GO-HOOK
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'go-mode-hook (lambda () (hs-minor-mode 1)))
(add-hook 'go-mode-hook (lambda ()
			  (gofmt-before-save)
			  (highlight-parentheses-mode)
			  (global-set-key (kbd "C-.") 'gofmt)
			  (local-set-key (kbd "M-.") 'godef-jump)
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

;; PYTHON-HOOK
(add-hook 'python-mode-hook 'uto-complete-mode)
(add-hook 'python-mode-hook (lambda () (hs-minor-mode 1)))
;; (set (make-local-variable 'company-backends) '(company-pysmell))
