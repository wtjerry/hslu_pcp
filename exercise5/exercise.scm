;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 1 -------------------------------

;(42 + (25 - 3 * 4)) : 11
(/ (+ 42 (- 25 (* 3 4))) 11)

;(24 + 32) : 7 + 3 * (17 - 15)
(+ (/ (+ 24 32) 7) (* 3 (- 17 15)))

;34428 : 38 - (1103 - 197)
(- (/ 34428 38) (- 1103 197))



; 2 -------------------------------

;1 / (1 + 1)
(/ 1 (+ 1 1))

;1 / (1 + (1 / (1 + 1)))
(/ 1 (+ 1 (/ 1 (+ 1 1))))

;1 / (1 + (1 / (1 + (1 / (1 + 1)))))
(/ 1 (+ 1 (/ 1 (+ 1 (/ 1 (+ 1 1))))))



; 3 -------------------------------

(define (diagonal x y)
  (sqrt (+ (sqr x) (sqr y))))
(diagonal 10 10)



; 4 -------------------------------

;-[10a + 20b - 40c] - [-(7a - 14c) - {-(15b - 4c) - (27a - 5b)}]
;t0 = -t1 - [-t2 - {-t3 - t4}]
;t1 = [10a + 20b - 40c]
;t2 = (7a - 14c)
;t3 = (15b - 4c)
;t4 = (27a - 5b)
;(define a 3)
;(define b 7)
;(define c 13)
;(define t1 [- (+ (* 10 a) (* 20 b)) (* 40 c)])
;(define t2 (- (* 7 a) (* 14 c)))
;(define t3 (- (* 15 b) (* 4 c)))
;(define t4 (- (* 27 a) (* 5 b)))
;(define t0 (- (- t1) [- (- t2) {- (- t3) t4}]))
(define (solve_term a b c)
  (- (- [- (+ (* 10 a) (* 20 b)) (* 40 c)]) [- (- (- (* 7 a) (* 14 c))) {- (- (- (* 15 b) (* 4 c))) (- (* 27 a) (* 5 b))}]))


; redefine - as + and use 1 as value for a, b and c



; 5 -------------------------------
; a) nein. eg falls heiss nicht die erste klausel ist dann wird sie nie aufgerufen
; b) nein. eg falls "durch 3 teilbar" zuerst ist dann wird potentiell "durch 2 teilbar" nicht gebraucht.



; 6 -------------------------------
; a) total-weight must be a number bigger than 0.
; b) different behavior. eg total-weight <= 1000 at the end would not be evaluated.
; c) either compare to a exact number with '=' or define both limits eg > X and <= Y



; 7 -------------------------------
; (* (cond 
;      ((> a b) a)
;      ((< a b) b)
;      (else -1))
;    (+ a 1))

; a) korrekt, aber falls als funktion gebraucht werden will, braucht es noch ein (define (somename a b) vorheriger_ausdruck )
; b)
(define (some_function a b)
  (* (cond
       ((> a b) a)
       ((< a b) b)
       (else -1))
     (+ a 1)))
(some_function 3 3) ; -> -4
(some_function 2 4) ; -> 12
(some_function 4 2) ; -> 20



; 8 -------------------------------
(define-struct point (x y))
(define (distance_to_origin p)
  (sqrt
    (+
      (sqr (point-x p))
      (sqr (point-y p)))))

(distance_to_origin (make-point 3 3))



; 9 -------------------------------
; a)
(define-struct human (age gender thigh_bone_length))
; b)
(define (b-length h)
  (-
    (cond
      ((string=? "male" (human-gender h)) (male_formula (human-thigh_bone_length h)))
      ((string=? "male" (human-gender h)) (female_formula (human-thigh_bone_length h))))
    (decrease_by_age (human-age h))))

(define (male_formula thigh_bone_length)
  (+ 69.089 (* 2.238 thigh_bone_length)))

(define (female_formula thigh_bone_length)
  (+ 61.412 (* 2.317 thigh_bone_length)))

(define (decrease_by_age age)
  (cond
    ((< age 30) 0)
    (else (* 0.06 (- age 30)))))

(b-length (make-human 1 "male" 2))

