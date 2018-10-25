;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define PI 3.1415)

(define (area r)
  (* (sqr r) PI))

(area 10)

(boolean? #t)

(boolean? (area 10))

(define (squarenumber? num)
  (integer? (sqrt num)))

(squarenumber? 25)
(squarenumber? 15)

(define (absolute x) (if (< x 0) (- x) x))
(define (absoluteCond x)
  (cond
    [(< x 0) (- x)]
    [else x]))

(define-struct song (artist title album))
(define s1 (make-song 'Eluveitie 'Inis_Mona 'Slania))
(song-artist s1)
(song? s1)
