
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 143 :width normal)))))

(define-key global-map [C-return] 'set-mark-command)

;;(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/elpa/company-0.8.12/")
(add-to-list 'load-path "~/.emacs.d/elpa/go-mode-20150503.258/")
;;(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-20150618.1949/")
;;(add-to-list 'load-path "~/.emacs.d/elpa/popup-20150609.2145/")

(require 'company)
(require 'company-go)

(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

(add-hook 'go-mode-hook (lambda ()
			  (gofmt-before-save)
			  (global-set-key (kbd "C-.") 'gofmt)
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))
(add-hook 'python-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-pysmell))
                          (company-mode)))

(custom-set-faces
 '(company-preview
   ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common
   ((t (:inherit company-preview))))
 '(company-tooltip
   ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-selection
   ((t (:background "steelblue" :foreground "white"))))
 '(company-tooltip-common
   ((((type x)) (:inherit company-tooltip :weight bold))
    (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection
   ((((type x)) (:inherit company-tooltip-selection :weight bold))
    (t (:inherit company-tooltip-selection)))))


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


  
;; (global-set-key [(f8)] 'loop-alpha)  ;;注意这行中的F8 , 可以改成你想要的按键

    
(setq alpha-list '((75 65) (100 100)))
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
