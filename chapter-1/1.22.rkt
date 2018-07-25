#lang racket

(require rackunit
         "utils.rkt")

(define (timed-prime-test n)
  (start-prime-test n (current-milliseconds)))

(define (start-prime-test n start-time)
  (cond ((prime? n)
         (newline)
         (report-prime (- (current-milliseconds) start-time) n))))

(define (report-prime elapsed-time prime)
  (display " *** ")
  (display prime)
  (display " *** ")
  (display elapsed-time)
  (newline))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (search-for-primes min max)
  (timed-prime-test min)
  (cond ((< min max) (search-for-primes (+ min 1) max))))

(provide search-for-primes)
