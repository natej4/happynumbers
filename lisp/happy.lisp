#!/usr/bin/sbcl --script

(defun createArray(x y)
(let ((size 0)(c 0)(nums))
(setq size (- y x))
;; (setq nums '())
(setq nums (make-array '(size)))
(loop for a from x to y do(
    progn 
    (setf (aref nums c) a)
    ;; (print a)
    ;; (cons a nums)
    (+ c 1)
))
nums
))


(progn
    (defvar x)
    (defvar y)
    (defvar nums)
    (princ "Enter first argument: ")
    (terpri)
    (setq x (read))
    (princ "Enter second argument: ")
    (terpri)
    (setq y (read))
    (setq nums (createArray x y))
    ;; (print-elements-of-list nums)
    ;;(dolist (n (createArray x y))

    (print nums)
    
    (write-line "")
)
