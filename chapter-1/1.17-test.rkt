#lang racket
 
(require rackunit
         "1.17.scm")

(check-equal? (fast-mul 4 5) 20 "Simple amultiplication 1")
(check-equal? (fast-mul 0 125) 0 "Simple amultiplication 2")
(check-equal? (fast-mul 1 15) 15 "Simple amultiplication 3")
(check-equal? (fast-mul 1 0) 0 "Simple amultiplication 4")