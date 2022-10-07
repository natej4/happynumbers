#!/usr/bin/sbcl --script

(defun createArray(x y size)
(let ((c 0)(nums))
;; (setq size (- y x))
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
    (defvar size)
    (princ "Enter first argument: ")
    (terpri)
    (setq x (read))
    (princ "Enter second argument: ")
    (terpri)
    (setq y (read))
    (setq size (- y x))
    (setq nums (createArray x y size))
    ;; (print-elements-of-list nums)
    ;;(dolist (n (createArray x y))

    (print nums)
    
    (write-line "")
)
