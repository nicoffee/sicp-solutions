#lang racket

(#%require (lib "27.ss" "srfi"))

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

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random-integer (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

 (define (prime? n) 
   (fast-prime? n 100))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (search-for-primes min max)
  (timed-prime-test min)
  (cond ((< min max) (search-for-primes (+ min 1) max))))
