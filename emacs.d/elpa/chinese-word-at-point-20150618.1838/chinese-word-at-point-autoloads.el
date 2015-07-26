;;; chinese-word-at-point-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (chinese-or-other-word-at-point chinese-word-at-point)
;;;;;;  "chinese-word-at-point" "chinese-word-at-point.el" (21891
;;;;;;  46762 239290 726000))
;;; Generated autoloads from chinese-word-at-point.el

(autoload 'chinese-word-at-point "chinese-word-at-point" "\
Return the (most likely) Chinese word at point, or nil if none is found.

\(fn)" nil nil)

(autoload 'chinese-or-other-word-at-point "chinese-word-at-point" "\
Return the Chinese or other language word at point, or nil if none is found.

Here's \"other\" denotes any language words that Emacs can understand,
i.e. (thing-at-point 'word) can get proper word.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("chinese-word-at-point-pkg.el") (21891
;;;;;;  46762 253445 588000))

;;;***

(provide 'chinese-word-at-point-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; chinese-word-at-point-autoloads.el ends here
