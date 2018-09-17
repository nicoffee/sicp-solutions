#lang racket

(define (make-segment a b)
  (cons a b))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (make-point x y)
  (cons x y))

(define (x-point x) (car x))

(define (y-point x) (cdr x))

(define (midpoint-segment segment)
  (cons (/ (+ (x-point (start-segment segment)) (x-point (end-segment segment))) 2)
        (/ (+ (y-point (start-segment segment)) (y-point (end-segment segment))) 2)))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (make-rect x y width height)
  (cons (make-segment (make-point x y)
                      (make-point x (+ y height)))
        (make-segment (make-point (+ x width) y)
                      (make-point (+ x width) (+ y height)))))

(define (x1y1-point rect) (car (car rect)))

(define (x1y2-point rect) (cdr (car rect)))

(define (x2y2-point rect) (cdr (cdr rect)))

(define (x2y1-point rect) (car (cdr rect)))

(define (print-rect rect)
  (print-point (x1y1-point rect))
  (print-point (x1y2-point rect))
  (print-point (x2y2-point rect))
  (print-point (x2y1-point rect)))

(define (find-height rect) (- (cdr (x1y2-point rect)) (cdr (x1y1-point rect))))

(define (find-width rect) (- (car (x2y1-point rect)) (car (x1y1-point rect))))

(define (permiter rect)
  (* 2 (+ (find-height rect) (find-width rect))))

(define (square rect)
  (* (find-height rect) (find-width rect)))