; GIMP Skript das ein konfigurierbares Gitternetz im GIMP zeichnet
; Im GIMP und im Menu registrieren
(script-fu-register 
 "script-fu-grid-lines-2" ; Funktionsname
 "New gridlines 2"	; Menu Punkt
 "Illustrates the structure of a GIMP script" ; Beschreibung
 "Roger Diehl"          ; Autor
 "2015, HSLU - T&A"     ; Copyright Notiz
 "October 2015"         ; Erstellungsdatum
 ""                     ; Bild Typ des Skript - "" heisst, es muss kein Bild geladen sein
 ; aktuelle Parameter von script-fu-grid-lines
 SF-IMAGE "Image" 0;                                 ; current image
 SF-ADJUSTMENT "Spacing" '(20 2 100 1 1 0 1)         ; spacing - default 20
 SF-BRUSH "Brush" '("Circle (01)" 100.0 1 0)         ; brush - default Circle (01)
 SF-COLOR "Foreground" '(0 0 0)                      ; foreground color - default white
 SF-TOGGLE "Horizontal lines" FALSE                   ; horizontal - default TRUE
 SF-TOGGLE "Vertical lines" TRUE                    ; vertical - default FALSE
 SF-TOGGLE "Dashed lines" FALSE                      ; dashed - default FALSE
 )
(script-fu-menu-register "script-fu-grid-lines-2"
                         "<Image>/File/Create/Gridlines_overlay")

; Das eigentliche Skript
(define (script-fu-grid-lines-2 image spacing brush foreground horizontal vertical dashed)
  
  (gimp-context-push)
  (let*(
        ; Grundeinstellungen - Farbe, Breite, Höhe, Ebene...
        (color 0)
        (drawable_width (car(gimp-image-width image)))
        (drawable_height (car(gimp-image-height image)))
        (layer (car(gimp-layer-new image drawable_width drawable_height RGBA-IMAGE "grid-layer" 100 NORMAL-MODE)))
        (layer_width (car(gimp-drawable-width layer)))
        (layer_height (car(gimp-drawable-height layer)))
        ; Anfangs- und Endpunkt einer Linie definieren x1, y1, x2, y2
        (point (cons-array 4 'double))
        (invert FALSE)
        )
    ; Gimp Kontext sezten - Transparenz, Hintergrund, Vordergrund, Pinsel, Füllfarbe, Ebene...
    (set! color TRANSPARENT-FILL) 
    (gimp-context-set-foreground  foreground)
    (gimp-context-set-brush (car brush))
    (gimp-drawable-fill layer color)
    (gimp-image-add-layer image layer -1)
    
    ; Demo zum Zeichnen einer Linie
    (define (draw_line x1 y1 x2 y2)
      ; Variablen x1, y1, x2, y2 den Anfangs- und Endpunkten der Linie zuordnen
      (aset point 0 x1)
      (aset point 1 y1)
      (aset point 2 x2)
      (aset point 3 y2)
      ; Linie zeichnen
      (gimp-paintbrush-default layer 4 point)
      )
    (cond ((and (eq? vertical FALSE) (eq? horizontal FALSE))
           (draw_line spacing spacing (- layer_width spacing) (- layer_height spacing))
           ))
    
    
    ; ab hier die Gitterlinien-Funktionen...

    ; Horizontal
    (define (draw_h yPos)
         (cond
             ((< yPos layer_height) 
              (draw_line 0 yPos layer_width yPos)
              (draw_h (+ yPos spacing))
             )
         )
     )
    
    ; Vertikal
    (define (draw_w xPos)
         (cond
             ((< xPos layer_width) 
              (draw_line xPos 0 xPos layer_height)
              (draw_w (+ xPos spacing)))
          )
    )

    ; Horizontal dashed
     (define (draw_h_dashed yPos xPos)
         (cond
             ((< yPos layer_height)
                (cond
                   ((<= xPos layer_width)
                    
                      (draw_line xPos yPos (+ xPos spacing) yPos)
                      (draw_h_dashed yPos (+ xPos (* 2 spacing)))
                   )
                   (else (draw_h_dashed (+ yPos spacing) 0))
                )
             )
         )
     )

    ; Vertikal dashed
      (define (draw_w_dashed yPos xPos)
         (cond
             ((< xPos layer_width)
                (cond
                   ((<= yPos layer_height)
                      (draw_line xPos yPos xPos (+ yPos spacing))
                      (draw_w_dashed (+ yPos (* 2 spacing)) xPos)
                   )
                   (else (draw_w_dashed 0 (+ xPos spacing)))
                )
             )
         )
      )
   
    (cond
      ((and (eq? vertical FALSE) (and (eq? horizontal TRUE) (eq? dashed FALSE))) (draw_h spacing))
      ((and (eq? vertical TRUE) (and (eq? horizontal FALSE) (eq? dashed FALSE))) (draw_w spacing))
      ((and (eq? vertical TRUE) (and (eq? horizontal TRUE) (eq? dashed FALSE))) (draw_w spacing) (draw_h spacing))
      ((and (eq? vertical FALSE) (and (eq? horizontal TRUE) (eq? dashed TRUE))) (draw_h_dashed spacing 0))
      ((and (eq? vertical TRUE) (and (eq? horizontal FALSE) (eq? dashed TRUE))) (draw_w_dashed 0 spacing))
      ((and (eq? vertical TRUE) (and (eq? horizontal TRUE) (eq? dashed TRUE))) (draw_w_dashed 0 spacing) (draw_h_dashed spacing 0))
    )
    
    ; ...Ende der Gitterlinien-Funktionen
    
    ; Bild anzeigen
    (gimp-display-new image)
    (gimp-context-pop)
    (gimp-displays-flush)
    )
  )
