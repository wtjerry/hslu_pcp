;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname exercise) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; 1 -------------------------------
(define couple (list 
  (cons "Adam" (cons "Eva" empty)) 
  (cons "Paul" (cons "Paula" empty))))

(define spec-list (list 1 (list 2 3 (list 5 7) 9)))

; a)
(rest (first couple))         ; -> (list "Eva")
(first (rest couple))         ; -> (list "Paul" "Paula")
(rest (rest couple))          ; -> '()
(first (first (rest couple))) ; -> "Paul"
(rest (first (rest couple)))  ; -> (list "Paula")
(cons? (rest (rest couple)))  ; -> #false

; b)
(first (rest (first (rest (rest (first (rest spec-list)))))))



; 2 -------------------------------
;(define (redouble a-list)
;  (cond
;    ((empty? a-list) empty)
;    (else (cons (* 2 (first a-list))
;                (redouble (rest a-list))))))
(define (apply_factor factor a-list)
  (cond
    ((empty? a-list) empty)
    (else (cons (* factor (first a-list))
                (apply_factor factor (rest a-list))))))



; 3 -------------------------------

; a) returns last element from a list
(define (f liste)
  (if (empty? liste)
      empty
      (if (empty? (rest liste))
          (first liste)
          (f (rest liste)))))

; b) empty or max
(define (g liste)
  (cond
    ((empty? liste) empty)
    ((empty? (rest liste)) (first liste))
    (else
      (if (> (first liste) (g (rest liste)))
        (first liste)
        (g (rest liste))))))



; 4 -------------------------------
(define (delete item a-list)
  (cond
    ((empty? a-list) empty)
    ((eqv? item (first a-list)) (rest a-list))
    (else
      (cons (first a-list) (delete item (rest a-list))))))

; (delete 3 (list 1 2 3 4))  ; (list 1 2 4)
; (delete 'c '(a b c d))     ; (list 'a 'b 'd)
; (delete 'f '(a b c d))     ; (list 'a 'b 'c 'd)
; (delete 'f empty)          ; '()
; (delete 'f (list 1 2 3 4)) ; (list 1 2 3 4)



; 5 -------------------------------
(define (contains? item a-list)
  (cond
    ((empty? a-list) #f)
    ((eqv? item (first a-list)) #t)
    (else
      (contains? item (rest a-list)))))

; (contains? 'c '(a b c d))  ; true
; (contains? 'f '(a b c d))  ; false



; 6 -------------------------------
(define (list-filter rel-op a-list value)
  (cond
    [(empty? a-list) empty]
    [else
      (cond
        [(rel-op (first a-list) value)
          (cons (first a-list)
                (list-filter rel-op (rest a-list) value))]
        [else (list-filter rel-op (rest a-list) value)])]))

; a) Suche ein bestimmtes Symbol in einer Liste von Symbolen
; (list-filter eqv? (list 'a 1 'c 'q 99) 'c)          ; -> (list 'c)

; b) Suche ein bestimmtes Zeichen in einer Liste von Zeichen
; (list-filter eqv? (list "a" "b" "c") "c")           ; -> (list "c")

; c) Suche einen bestimmten String in einer Liste von Strings
; (list-filter eqv? (list "abc" "def" "ghi") "def")   ; -> (list "def")



; 7 -------------------------------
; dividend / divisor = quotient
(define (is-divisible? dividend divisor)
  (= 0 (remainder dividend divisor)))
; (list-filter is-divisible? (list 1 2 3 4 5 6) 3)  ; -> (list 3 6) 



; 8 -------------------------------

; Sortieren durch Einfügen 
(define (sort-a-list op num-list)
  (cond
    ((empty? num-list) empty)
    (else (insert op
                  (first num-list)
                  (sort-a-list op (rest num-list))))
    ))  

; Einfügen in sortierter Liste
(define (insert op item a-list)
  (cond 
    ((empty? a-list) (list item))
    ((op item (first a-list)) (cons item a-list))
    (else (cons (first a-list) (insert op item (rest a-list))))
    ))

;  (sort-a-list > (list 1 4 6 2 5))
;  (sort-a-list string>? (list "a" "b" "d" "c"))



; 9 -------------------------------

; a) falls a positiv dann + sonst - (ähnlich wie abolut)
(define (a-op a)
  (cond
    [(>= a 0) +]
    [else -]))
; ((a-op -5) 100 -5)  ; -> 105
; ((a-op 5) 100 5)    ; -> 105

; b)
(define (abs-a-plus-b a b)
  ((a-op b) ((a-op a) a) b))
; (abs-a-plus-b 10 2)   ; -> 12
; (abs-a-plus-b 10 -2)  ; -> 12
; (abs-a-plus-b -10 2)  ; -> 12
; (abs-a-plus-b -10 -2) ; -> 12

; c)
(define (abs-a-op-b op a b)
  (op
    [(a-op a) a]
    [(a-op b) b]))
; (abs-a-op-b = 3 -3)     ; -> #t
; (abs-a-op-b < 2 -3)     ; -> #t
; (abs-a-op-b > 2 -3)     ; -> #f
; (abs-a-op-b + 2 -3)     ; -> 5
; (abs-a-op-b list 5 -3)  ; -> (list 5 3)