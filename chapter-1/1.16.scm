#lang racket
(define (square n) (* n n))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-expt b n)
  (fast-expt-iter b n 1))

(define (fast-expt-iter b n a)
  (cond ((= n 0) a)
      ((even? n) (square (fast-expt b (/ n 2))))
      (else (* b (fast-expt b (- n 1))))))


      

