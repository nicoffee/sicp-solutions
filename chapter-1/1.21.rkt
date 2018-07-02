#lang racket

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-milliseconds)))

(define (start-prime-test n start-time)
  (cond ((prime? n)
         (newline)
         (report-prime (- (current-milliseconds) start-time)))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (square a) (* a a))

(define (divides? a b) (= (remainder b a) 0))

(define (search-for-primes min max)
  (timed-prime-test min)
  (cond ((< min max) (search-for-primes (+ min 1) max))))
