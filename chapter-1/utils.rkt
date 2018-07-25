#lang racket

(define (square a) (* a a))

(define (divides? a b) (= (remainder b a) 0))

(provide square)
(provide divides?)