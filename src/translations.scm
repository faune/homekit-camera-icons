; Room + translation data for generate_icons.scm.
;
; This is the only file you need to edit to add rooms or languages. It is
; loaded by generate_icons.scm; keep it valid Scheme (mind the quotes/parens).

; Rooms: (file-key . icon-layer-name)
; file-key is used in output filenames and to look up labels below.
; The living-room icon is "Icon Stue" (the couch); "Icon Livingroom" is unused.
(define rooms (list
  (cons "diningroom" "Icon Diningroom")
  (cons "kitchen"    "Icon Kitchen")
  (cons "livingroom" "Icon Stue")
  (cons "garage"     "Icon Garage")
  (cons "garden"     "Icon Garden")
  (cons "bedroom"    "Icon Bedroom")
  (cons "laundry"    "Icon Washroom")
  (cons "bathroom"   "Icon Bathroom")
  (cons "toilet"     "Icon Toilet")
  (cons "hallway"    "Icon Hallway")
  (cons "office"     "Icon Office")
  (cons "gym"        "Icon Gym")))

; Translations: one block per language -> (room-key . label).
; To add a language, copy an existing block, change the language code (used in
; the output filename, e.g. kitchen_sv.png), and translate every label.
; Every room-key from `rooms` must be present in every language block.
(define languages (list

  (list "en" (list
    (cons "diningroom" "Dining room")
    (cons "kitchen"    "Kitchen")
    (cons "livingroom" "Living room")
    (cons "garage"     "Garage")
    (cons "garden"     "Garden")
    (cons "bedroom"    "Bedroom")
    (cons "laundry"    "Laundry room")
    (cons "bathroom"   "Bathroom")
    (cons "toilet"     "Toilet")
    (cons "hallway"    "Hallway")
    (cons "office"     "Office")
    (cons "gym"        "Gym")))

  (list "no" (list
    (cons "diningroom" "Spisestue")
    (cons "kitchen"    "Kjøkken")
    (cons "livingroom" "Stue")
    (cons "garage"     "Garasje")
    (cons "garden"     "Hage")
    (cons "bedroom"    "Soverom")
    (cons "laundry"    "Vaskerom")
    (cons "bathroom"   "Baderom")
    (cons "toilet"     "Toalett")
    (cons "hallway"    "Hall")
    (cons "office"     "Kontor")
    (cons "gym"        "Treningsrom")))

  (list "sv" (list
    (cons "diningroom" "Matsal")
    (cons "kitchen"    "Kök")
    (cons "livingroom" "Vardagsrum")
    (cons "garage"     "Garage")
    (cons "garden"     "Trädgård")
    (cons "bedroom"    "Sovrum")
    (cons "laundry"    "Tvättstuga")
    (cons "bathroom"   "Badrum")
    (cons "toilet"     "Toalett")
    (cons "hallway"    "Hall")
    (cons "office"     "Kontor")
    (cons "gym"        "Gym")))

  (list "da" (list
    (cons "diningroom" "Spisestue")
    (cons "kitchen"    "Køkken")
    (cons "livingroom" "Stue")
    (cons "garage"     "Garage")
    (cons "garden"     "Have")
    (cons "bedroom"    "Soveværelse")
    (cons "laundry"    "Vaskerum")
    (cons "bathroom"   "Badeværelse")
    (cons "toilet"     "Toilet")
    (cons "hallway"    "Entré")
    (cons "office"     "Kontor")
    (cons "gym"        "Træningsrum")))

  (list "fi" (list
    (cons "diningroom" "Ruokasali")
    (cons "kitchen"    "Keittiö")
    (cons "livingroom" "Olohuone")
    (cons "garage"     "Autotalli")
    (cons "garden"     "Puutarha")
    (cons "bedroom"    "Makuuhuone")
    (cons "laundry"    "Kodinhoitohuone")
    (cons "bathroom"   "Kylpyhuone")
    (cons "toilet"     "WC")
    (cons "hallway"    "Eteinen")
    (cons "office"     "Työhuone")
    (cons "gym"        "Kuntosali")))

  (list "de" (list
    (cons "diningroom" "Esszimmer")
    (cons "kitchen"    "Küche")
    (cons "livingroom" "Wohnzimmer")
    (cons "garage"     "Garage")
    (cons "garden"     "Garten")
    (cons "bedroom"    "Schlafzimmer")
    (cons "laundry"    "Waschküche")
    (cons "bathroom"   "Badezimmer")
    (cons "toilet"     "Toilette")
    (cons "hallway"    "Flur")
    (cons "office"     "Büro")
    (cons "gym"        "Fitnessraum")))

  (list "fr" (list
    (cons "diningroom" "Salle à manger")
    (cons "kitchen"    "Cuisine")
    (cons "livingroom" "Salon")
    (cons "garage"     "Garage")
    (cons "garden"     "Jardin")
    (cons "bedroom"    "Chambre")
    (cons "laundry"    "Buanderie")
    (cons "bathroom"   "Salle de bain")
    (cons "toilet"     "Toilettes")
    (cons "hallway"    "Entrée")
    (cons "office"     "Bureau")
    (cons "gym"        "Salle de sport")))

  (list "es" (list
    (cons "diningroom" "Comedor")
    (cons "kitchen"    "Cocina")
    (cons "livingroom" "Salón")
    (cons "garage"     "Garaje")
    (cons "garden"     "Jardín")
    (cons "bedroom"    "Dormitorio")
    (cons "laundry"    "Lavadero")
    (cons "bathroom"   "Baño")
    (cons "toilet"     "Aseo")
    (cons "hallway"    "Recibidor")
    (cons "office"     "Despacho")
    (cons "gym"        "Gimnasio")))

  ))
