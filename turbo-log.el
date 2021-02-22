;;; turbo-log.el --- Automating the process of writing meaningful log messages  -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Shen, Jen-Chieh
;; Created date 2021-02-22 14:27:53

;; Author: Shen, Jen-Chieh <jcs090218@gmail.com>
;; Description: Automating the process of writing meaningful log messages.
;; Keyword: log debug
;; Version: 0.1.0
;; Package-Requires: ((emacs "24.3"))
;; URL: https://github.com/jcs-elpa/turbo-log

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Automating the process of writing meaningful log messages.
;;

;;; Code:

(require 'cl-lib)

(defgroup turbo-log nil
  "Automating the process of writing meaningful log messages."
  :prefix "turbo-log-"
  :group 'tool
  :link '(url-link :tag "Repository" "https://github.com/jcs-elpa/turbo-log"))

(defcustom turbo-log-format
  '((actionscript-mode     . "trace(\"%s\");")
    (csharp-mode           . "Console.WriteLine(%s);")
    (javascript-mode       . "console.log(%s);")
    (js-mode               . "console.log(%s);")
    (js1-mode              . "console.log(%s);")
    (js2-mode              . "console.log(%s);")
    (emacs-lisp-mode       . "(message \"%%s\" %s)")
    (lisp-interaction-mode . "(message \"%%s\" %s)")
    (lisp-mode             . "(message \"%%s\" %s)"))
  ""
  :type 'list
  :group 'turbo-log)

;;
;; (@* "Util" )
;;

(defun turbo-log--inside-comment-or-string-p ()
  "Return non-nil if point is inside comment or string."
  (or (nth 4 (syntax-ppss)) (nth 8 (syntax-ppss))))

(defun turbo-log--char-count (str)
  "Return the character count from region STR."
  (length (split-string str " " t)))

;;
;; (@* "Core" )
;;

(defun turbo-log--insert (var)
  "Insert VAR by format."
  (goto-char (line-end-position))
  (insert "\n") (indent-for-tab-command)
  (let ((fmt (cdr (assoc major-mode turbo-log-format))))
    (insert (format fmt var))))

(defun turbo-log-string (str)
  "Log the STR by it's current `major-mode'."
  (deactivate-mark)
  (setq str (string-trim str))
  (cond ((not (= (turbo-log--char-count str) 1))
         (user-error "Warning: multiple tokens region selected"))
        ((turbo-log--inside-comment-or-string-p)
         (user-error "Warning: comment or string symbol"))
        (t (turbo-log--insert str))))

;;;###autoload
(defun turbo-log (beg end)
  "Turbo log the current selected region."
  (interactive "r")
  (if (not (use-region-p))
      (user-error "Region is not declare for Turbo Log")
    (turbo-log-string (buffer-substring (region-beginning) (region-end)))))

(provide 'turbo-log)
;;; turbo-log.el ends here
