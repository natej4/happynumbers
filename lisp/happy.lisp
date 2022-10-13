#!/usr/bin/sbcl --script

(progn
    (defvar x)
    (defvar y)
    (defvar nums (make-array 1000))
    (defvar sum)
    (defvar happies (make-array 1000))
    (let ((c 0))

    (princ "Enter first argument: ")
    (terpri)
    (setq x (read))
    (princ "Enter second argument: ")
    (terpri)
    (setq y (read))

    (loop for a from x to y do(
        progn 
        (setf (aref nums c) a)
        (setq c(+ c 1))))
    ;; (dotimes (i c)
    ;;     (print (aref nums i)))
    
    (defun isHappy(number)
        (let ((cache (make-array 1000))(digit)(count 0)(sum))
            (setq sum 0)
            (setq digit 0)
            (loop
                (unless (> number 1)
                    (return-from isHappy T))
                ;; (print (aref cache count))
                (dotimes (i (1- count))
                    (when (= (aref cache i) number)
                        (return-from isHappy nil)))

                ;; (when (= (aref cache count) 0)
                ;;     (return-from isHappy nil))
                (setf (aref cache count) number)
                (setq count (1+ count))
                (loop 
                    (when (= number 0)
                        (return number ))
                    (setq digit (floor(mod number 10)))
                    (setq sum (+ sum (* digit digit)))
                    (setq number (floor(/ number 10.0)))
                    )
                
                (setq number sum)
                (setq sum 0))))
;;; adapted from https://literateprograms.org/bubble_sort__lisp_.html 
    (defun bubble-sort (happyarray normarray cmp-fun) 
  ;;"Bubble sort implementation in common lisp. Using the extended loop facility."
    (let ((result (copy-seq happyarray))(norms (copy-seq normarray)))
    (loop for i from (1- (length result)) downto 0 do
        (loop for j from 0 to i
            when (funcall cmp-fun (aref norms i) (aref norms j))
               do (rotatef (aref result i) (aref result j)) ))
    result))


    (let ((numHappies 0))
    (dotimes (i c)
        (when (isHappy (aref nums i))
            (let ((n (aref nums i)))
            (setf (aref happies numHappies) n))
            (setq numHappies (1+ numHappies)))
            )

    (defun norm (number)
    (let ((cache (make-array 1000))(digit)(count 0)(sum))
            (setq sum 0)
            (setq digit 0)
            (loop
                (unless (> number 1)
                    (return 0))
                ;; (print (aref cache count))
                (dotimes (i (1- count))
                    (when (= (aref cache i) number)
                        (return 0)))

                ;; (when (= (aref cache count) 0)
                ;;     (return-from isHappy nil))
                (setf (aref cache count) number)
                (setq count (1+ count))
                (loop 
                    (when (= number 0)
                        (return number ))
                    (setq digit (floor(mod number 10)))
                    (setq sum (+ sum (* digit digit)))
                    (setq number (floor(/ number 10.0)))
                    )
                
                (setq number sum)
                (setq sum 0))
        (let ((x)(result))
        (dotimes (j count)
            (setq x (* (aref cache j) (aref cache j)))
            (setq result (+ result x)))
        (setq result (sqrt result))
        result)))

    (let ((normarray (make-array 1000)))
    (dotimes (k numHappies)
        (let ((normNum))
            (setq normNum (norm (aref happies k)))
            (setf (aref normarray k) normNum)))
        
    (setf happies (bubble-sort happies normarray '>)))
    (dotimes (j numHappies)
            (print (aref happies j)))
        
    ))
    
    (write-line ""))
