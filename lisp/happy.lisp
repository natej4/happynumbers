#!/usr/bin/sbcl --script
;;;;Asks the user for two positive integers
;;;;and returns the 10 happy numbers between them
;;;;with the greatest norms, sorted descending by the norms

;;;;by Nate Jackson for CSC330

(progn
    ;;globals
    (defvar x)
    (defvar y)
    (defvar nums (make-array 1000))
    (defvar sum)
    (defvar happies (make-array 1000))
    (let ((c 0))
    ;;input
    (princ "Enter first argument: ")
    (terpri)
    (setq x (read))
    (princ "Enter second argument: ")
    (terpri)
    (setq y (read))
    ;; exit case when numbers are the same
    (when (= x y)
        (princ "NOBODYS HAPPY")
        (terpri)
        (EXIT))
    (when (> x y)
        (rotatef x y)
        )
;;; filling array with nums between entered values
    (loop for a from x to y do(
        progn 
        (setf (aref nums c) a)
        (setq c(+ c 1))))
   
;;; function to determine if a number is happy
;;; (hand written btw, not easy)
    (defun isHappy(number)
        (let ((cache (make-array 1000))(digit)(count 0)(sum))
            (setq sum 0)
            (setq digit 0)
            (loop
                (unless (> number 1)
                    (return-from isHappy T))
                (dotimes (i (1- count))
                    (when (= (aref cache i) number)
                        (return-from isHappy nil)))

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
    (defun bubble-sort (array array2 cmp-fun) 
  "Bubble sort implementation in common lisp. Using the extended loop facility."
  (let ((result (copy-seq array)) (output (copy-seq array2)))
    (loop for i from (1- (length result)) downto 0 do
        (loop for j from 0 to i
            when (funcall cmp-fun (aref result i) (aref result j))
               do (rotatef (aref result i) (aref result j)) 
               (rotatef (aref output i) (aref output j))))
    output))

    ;; finding happies within nums, putting into happies array
    (let ((numHappies 0))
    (dotimes (i c)
        (when (isHappy (aref nums i))
            (let ((n (aref nums i)))
            (setf (aref happies numHappies) n))
            (setq numHappies (1+ numHappies)))
            )
    ;; exit case when no happies exist
    (when (= numHappies 0)
        (princ "NOBODYS HAPPY")
        (terpri)
        (EXIT))
;;; function to find the norm of a happy number
    (defun norm (number)
    (let ((cache (make-array 1000))(digit)(count 0)(sum))
            (setq sum 0)
            (setq digit 0)
            (loop
                (unless (> number 1)
                    (return 0))
                (dotimes (i (1- count))
                    (when (= (aref cache i) number)
                        (return 0)))

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
        (setq result 0)
        (setq x 0)
        (dotimes (j count)
            (setq x (* (aref cache j) (aref cache j)))
            (setq result (+ result x)))

        (setq result (sqrt result))
        result)))

    ;; filling a parallel array with the norm of each happy        
    (let ((normarray (make-array 1000)))
    
    (dotimes (k numHappies)
        (let ((normNum))
            (setq normNum (norm (aref happies k)))
            (setf (aref normarray k) normNum)))
    
    ;; sorting happies array by normarray
    (setf happies (bubble-sort normarray happies '>)))

    ;; only allowing top 10 to be printed
    (when (> numHappies 10)
        (setq numHappies 10))
    
    ;;output
    (dotimes (j numHappies)
            (print (aref happies j)))))

    (write-line ""))
