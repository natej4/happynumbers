#!/usr/bin/sbcl --script

(defvar x 10)
(when (> x 11)
    (print "greater than"))

(terpri ) 