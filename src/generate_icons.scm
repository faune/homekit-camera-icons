; Auto-generate HomeKit camera-still PNGs from the GIMP template.
;
; Text labels are data-driven: they live in the `languages` table below, NOT as
; per-language text layers in the .xcf. Adding a new language is just adding one
; block of strings here -- no GIMP editing required. The .xcf only needs to
; provide the icons, the background, and one reusable text layer for styling.
;
; For every (room x language) combination this hides all layers, shows the base
; layers + the room's icon, renders the label onto the style layer (centered),
; flattens, scales to the target resolution and exports <room>_<lang>.png.
;
; Run via gimp-console (see generate_icons.sh). Config comes from the
; environment variables HK_SRC, HK_OUT, HK_W, HK_H and HK_TRANS when present.

; Load the room + translation data. This defines `rooms` and `languages`.
(load (let ((e (getenv "HK_TRANS")))
        (if (and e (> (string-length e) 0)) e
            "/Users/faune/git/homekit-camera-icons/src/translations.scm")))

(let* (       (src   (let ((e (getenv "HK_SRC")))
                (if (and e (> (string-length e) 0)) e
                    "/Users/faune/git/homekit-camera-icons/src/homekit_camera_still_template.xcf")))
       (outdir (let ((e (getenv "HK_OUT")))
                 (if (and e (> (string-length e) 0)) e
                     "/Users/faune/git/homekit-camera-icons/output")))
       (out-w (let ((e (getenv "HK_W"))) (if (and e (> (string-length e) 0)) (string->number e) 1920)))
       (out-h (let ((e (getenv "HK_H"))) (if (and e (> (string-length e) 0)) (string->number e) 1080)))

       ; Layers that must stay visible in every exported still.
       (base-layers (list "AppleTV" "Arrow" "Bakgrunn"))

       ; Existing text layer reused purely as a styling/render surface. It
       ; supplies the font (its embedded "gimpfont1848" alias), so the label
       ; keeps the template's exact typeface. Any of the "Text ..." layers work.
       (style-layer "Text Gym")

       ; Label placement: horizontal + vertical CENTER of the label, in the
       ; original 1920x1080 canvas (scaling to HK_W/HK_H happens afterwards).
       (center-x 960)
       (center-y 698)

       ; Markup wrapper captured from the template (font alias / colour / size).
       ; The label is inserted between these. Change here to restyle every label.
       (mk-pre  "<markup><span font=\"gimpfont1848\"><span foreground=\"#000000\"><span size=\"47185\">")
       (mk-post "</span></span></span></markup>")

       ; `rooms` and `languages` are provided by translations.scm (loaded above).

       (image (car (gimp-file-load RUN-NONINTERACTIVE src "template.xcf")))
       (layer-vec (car (gimp-image-get-layers image))))

  ; ---- helpers -------------------------------------------------------------

  (define (find-layer name)
    (let loop ((i 0))
      (cond ((>= i (vector-length layer-vec))
             (error (string-append "Layer not found: " name)))
            ((string=? name (car (gimp-item-get-name (vector-ref layer-vec i))))
             (vector-ref layer-vec i))
            (else (loop (+ i 1))))))

  (define (assoc-ref key alist)
    (cond ((null? alist) (error (string-append "Missing translation for: " key)))
          ((string=? key (caar alist)) (cdar alist))
          (else (assoc-ref key (cdr alist)))))

  (define (hide-all)
    (let loop ((i 0))
      (when (< i (vector-length layer-vec))
        (gimp-item-set-visible (vector-ref layer-vec i) FALSE)
        (loop (+ i 1)))))

  (define style (find-layer style-layer))

  ; Render `label` on the style layer, centred on (center-x, center-y).
  (define (set-label label)
    (gimp-text-layer-set-markup style (string-append mk-pre label mk-post))
    (let ((w (car (gimp-drawable-get-width style)))
          (h (car (gimp-drawable-get-height style))))
      (gimp-layer-set-offsets style
                              (round (- center-x (/ w 2)))
                              (round (- center-y (/ h 2))))))

  (define (export-still icon-layer label out-path)
    (hide-all)
    (set-label label)
    (for-each (lambda (n) (gimp-item-set-visible (find-layer n) TRUE)) base-layers)
    (gimp-item-set-visible (find-layer icon-layer) TRUE)
    (gimp-item-set-visible style TRUE)
    (let ((dup (car (gimp-image-duplicate image))))
      (gimp-image-flatten dup)
      (gimp-image-scale dup out-w out-h)
      (gimp-file-save RUN-NONINTERACTIVE dup out-path out-path)
      (gimp-image-delete dup)))

  ; ---- generate ------------------------------------------------------------

  (for-each
    (lambda (lang-block)
      (let ((lang   (car lang-block))
            (labels (cadr lang-block)))
        (for-each
          (lambda (room)
            (let* ((key   (car room))
                   (icon  (cdr room))
                   (label (assoc-ref key labels)))
              (export-still icon label (string-append outdir "/" key "_" lang ".png"))))
          rooms)
        (gimp-message (string-append "generated language " lang))))
    languages)

  (gimp-image-delete image))

(gimp-quit 0)
