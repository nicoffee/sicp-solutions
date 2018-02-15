#lang racket

(define (pascalTriangle row column)
  (if (or (= column 1) (= row 1) (= row column))
       1
  (+ (pascalTriangle (- row 1) (- column 1))
     (pascalTriangle (- row 1) column))))