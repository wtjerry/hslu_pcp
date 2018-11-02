;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname exercise) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; 1 -------------------------------
; Sortieren durch Einfügen
;(define (sort-a-list op a-list)
;  (cond
;    ((empty? a-list) empty)
;    (else (insert op (first a-list)
;                  (sort-a-list op (rest a-list))))
;    ))

; Einfügen in sortierter List
;(define (insert op item a-list)
;  (cond
;    ((empty? a-list) (list item))
;    ((op item (first a-list)) (cons item a-list))
;    (else (cons (first a-list) (insert op item (rest a-list))))
;    ))

(define (sort-by-insert op a-list)
  (local
    (
     (define (insert op item a-list)
       (cond
         ((empty? a-list) (list item))
         ((op item (first a-list)) (cons item a-list))
         (else (cons (first a-list) (insert op item (rest a-list))))))
     
     (define (sort-a-list op a-list)
       (cond
         ((empty? a-list) empty)
         (else (insert op (first a-list)
                       (sort-by-insert op (rest a-list))))))
    )
    (sort-a-list op a-list)))



; 2 -------------------------------
(define (fib n)
  (cond 
    ((or (= n 0) (= n 1)) n)
    (else (+ (fib (- n 1)) 
             (fib (- n 2))))))

; a)
(define (fib-acc n)
  (local (
          (define (fibonacci-acc i current previous)
            (if (= i n) current
                (fibonacci-acc (+ 1 i) (+ current previous) current))))
    (fibonacci-acc 0 0 1)))

; b)
; (fib 35)     ; -> ~3 seconds
; (fib-acc 35) ; -> instant



; 3 -------------------------------

; a)
(define a 42)

(let (
      (a 1)
      (b (+ a 1)))
  b)
; -> 43
(let* (
       (a 1)
       (b (+ a 1)))
  b)
; -> 2

; b)
; because let first evaluates each expression
; and only then assign it to the name the outer a is used.

; because let* evaluates each expression from left to right (top down),
; an new name with the value a is created and bound to 1.
; And only then (+ a 1) is evaluated.



; 4 -------------------------------

; a)
(define x 1)
(define y 5)

((lambda (x y)
   (+ (* 2 x) y))
   y x)
; -> 11
((lambda (a b)
   (+ (* 2 x) y))
 y x)
; -> 7

; b)
; In the first form the values of the outside y and x names
; are passed as arguments for the inner x and y.
; (where x = y and y = x)
; Therefore the value of the inner x is 5 and the value of the inner y is 1.

; In the second form the parameters a and b are bound to the values of the outer x and y
; but then completely ignored.
; The lambda function instead uses the outer x and y directly.



; 5 -------------------------------
; (define a-list (list (list 1 2 3) (list 1 2) (list 1 2 3 4)))

(define a-list
  ((lambda (list-of-lists)
    (map (lambda (inner-list)
           (append '(0) inner-list))
         list-of-lists))
  (list (list 1 2 3) (list 1 2) (list 1 2 3 4))))



; 6 -------------------------------
(define rect-calc-list
  (list (lambda (a b) (* a b)) (lambda (a b) (* 2 (+ a b)))))

(define (calc-a-list l side-a side-b)
  (local
    (
     (define (calc-a-list-pure l side-a side-b)
       (if (empty? l)
           empty
           (cons 
             ((first l) side-a side-b)
             (calc-a-list-pure (rest l) side-a side-b))))

     (define (display-list l)
       (if (empty? l)
           (display "finished")
           (begin
             (display (first l))
             (newline)
             (display-list (rest l)))))
    )
    (display-list (calc-a-list-pure l side-a side-b))))
  