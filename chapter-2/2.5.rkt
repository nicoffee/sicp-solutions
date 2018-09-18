#lang racket

(define (expt b n)
  (if (= n 0)
      1
      (* b (expt b (- n 1)))))

(define (count-0-remainder-divisions n divisor) 
  (define (iter try-exp) 
    (if (= 0 (remainder n (expt divisor try-exp))) 
        (iter (+ try-exp 1))
        (- try-exp 1)))  
  (iter 1)) 

(define (my-cons x y)
  (* (expt 2 x) (expt 3 y)))

(define (car z)
  (count-0-remainder-divisions z 2))

(define (cdr z)
  (count-0-remainder-divisions z 3))