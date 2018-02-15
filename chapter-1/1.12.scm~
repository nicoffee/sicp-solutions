#lang racket

(define (pascalTriangle row column)
  (if (= column 1)
       1
  (+ pascalTriangle (- row 1) (- column 1)
     pascalTriangle (- row 1) (+ column 1)))
)