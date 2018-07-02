#lang racket

;;; recursive process
(define (f n)
  (if (< n 3) n
    (+ (f (- n 1))
      (* 2 (f (- n 2)))
      (* 3 (f (- n 3))))))
                  
;;; iterative process
(define (f2 n)
    (f-iter 0 1 2 n))

(define (f-iter a b c count)
    (if (= count 0)
        a
        (f-iter b c (+ (* a 3) (* b 2) c) (- count 1))))

