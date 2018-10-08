#lang racket

(define (make-interval a b) (cons a b))

(define (upper-bound int) (max (cdr int) (car int)))

(define (lower-bound int) (min (cdr int) (car int)))


