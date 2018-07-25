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
  (display prime)
  (display " *** ")
  (display elapsed-time)
  (newline))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (next n)
  (cond ((= n 2) 3)
        (else (+ n 2))))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (search-for-primes min max)
  (timed-prime-test min)
  (cond ((< min max) (search-for-primes (+ min 1) max))))