;;; recursive process
(define (f n)
    (if (< n 3) n
        (+ (f (- n 1))
                    (* (f (- n 2)) 2)
                        (* (f (- n 3)) 3))))
                  
;;; iterative process
(define (f n)
    (f-iter 0 1 2 n))

(define (f-iter a b c count)
    (if (< count 3)
        c
        (f-iter b c (+ (* a 3) (* b 2) c) (- count 1))))