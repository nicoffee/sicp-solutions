#lang racket
 
(require rackunit
         "1.23.rkt")

(check-equal? (prime? 10) #f "Number is not prime")
(check-equal? (prime? 7) #t "Number is prime")