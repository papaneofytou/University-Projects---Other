(defrule get_brand
	"Starting here... First question: camera brand"
	=>
	(printout t crlf "Welcome!" crlf)
	(printout t "We are here to help you choose the most suitable camera!" crlf)
	(printout t "Answer the questions by entering the name of the option you want as is (case insensitive)" crlf) 
	(printout t "(Note that there's always the answer \"All\" if you don't mind" crlf)
	(printout t "or \"Cancel\" if you want to stop the procedure at any time)." crlf)
	(printout t "No other answer is accepted." crlf)
	(printout t "Let's start..." crlf crlf crlf)

	(printout t crlf "Choose a brand:
	1. Canon
	2. Kodak
	3. Nikon
	4. Olympus
	5. Panasonic
	6. Samsung
	7. Sony
	8. All
	9. Cancel" crlf crlf)
	
	(bind ?brand (lowcase (sym-cat(read))))
	
	(bind ?ok 0)
	(while (= ?ok 0)
		(switch ?brand
		(case canon then (assert (brand ?brand))
						 (bind ?ok 1))
		(case kodak then (assert (brand ?brand))
						 (bind ?ok 1))
		(case nikon then (assert (brand ?brand))
						 (bind ?ok 1))
		(case olympus then (assert (brand ?brand))
						   (bind ?ok 1))
		(case panasonic then (assert (brand ?brand))
							 (bind ?ok 1))
		(case samsung then (assert (brand ?brand))
						   (bind ?ok 1))
		(case sony then (assert (brand ?brand))
						(bind ?ok 1))
		(case all then (assert (brand ?brand))
					   (bind ?ok 1))
		(case cancel then (printout t "Bye bye!!" crlf)
						  (retract *)
						  (bind ?ok 1))
		(default (printout t "Wrong input. Try again" crlf crlf)
				 (bind ?brand (lowcase (sym-cat(read))))))))
				 

(defrule get_type
	"Second question: camera type"
	(brand ?brandok&canon|kodak|nikon|olympus|panasonic|samsung|sony|all)
	=>
	(printout t crlf "Choose a type:
	1. DSLR
	2. High_Zoom
	3. Lifestyle
	4. High_Performance
	5. All
	6. Cancel" crlf crlf)
	
	(bind ?type (lowcase (sym-cat(read))))
	
	(bind ?ok 0)
	(while (= ?ok 0)
		(switch ?type
		(case dslr then (assert (type ?type))
						 (bind ?ok 1))
		(case high_zoom then (assert (type ?type))
						 (bind ?ok 1))
		(case lifestyle then (assert (type ?type))
						 (bind ?ok 1))
		(case high_performance then (assert (type ?type))
						   (bind ?ok 1))
		(case all then (assert (type ?type))
					   (bind ?ok 1))
		(case cancel then (printout t "Bye bye!!" crlf)
						  (retract *)
						  (bind ?ok 1))
		(default (printout t "Wrong input. Try again" crlf crlf)
				 (bind ?type (lowcase (sym-cat(read))))))))
				 
				 
(defrule get_megapixels
	"Third question: camera megapixels"
	(type ?typeok&dslr|high_zoom|lifestyle|high_performance|all)
	=>
	(printout t crlf "Choose megapixels:
	1. 10
	2. 12
	3. 14
	4. 16
	5. 18
	6. 20
	7. All
	8. Cancel" crlf crlf)
	
	(bind ?megapix (lowcase (sym-cat (read))))
	
	(bind ?ok 0)
	(while (= ?ok 0)
		(switch ?megapix
		(case (sym-cat 10) then (assert (megapixels (sym-cat ?megapix mp)))
						 (bind ?ok 1))
		(case (sym-cat 12) then (assert (megapixels (sym-cat ?megapix mp)))
						 (bind ?ok 1))
		(case (sym-cat 14) then (assert (megapixels (sym-cat ?megapix mp)))
						 (bind ?ok 1))
		(case (sym-cat 16) then (assert (megapixels (sym-cat ?megapix mp)))
						   (bind ?ok 1))
		(case (sym-cat 18) then (assert (megapixels (sym-cat ?megapix mp)))
						   (bind ?ok 1))
		(case (sym-cat 20) then (assert (megapixels (sym-cat ?megapix mp)))
						   (bind ?ok 1))
		(case all then (assert (megapixels ?megapix))
					   (bind ?ok 1))
		(case cancel then (printout t "Bye bye!!" crlf)
						  (retract *)
						  (bind ?ok 1))
		(default (printout t "Wrong input. Try again" crlf crlf)
				 (bind ?megapix (lowcase (sym-cat (read)))))))
				 
	(if (= (str-compare ?typeok dslr) 0) then (assert (optzoom no_zoom))))
	

(defrule get_optzoom
	"Fourth question: camera optical zoom"
	(type ?typeok&high_zoom|lifestyle|high_performance|all)
	(megapixels ?megapixok&10mp|12mp|14mp|16mp|18mp|24mp|all)
	=>
	(printout t crlf "Choose optical zoom:
	1. 	 3x
	2. 	 4x
	3. 	 5x
	4. 	 6x
	5. 	 7x
	6. 	 8x
	7. 	10x
	8. 	12x
	9. 	14x
	10. 16x
	11. 18x
	12. 20x
	13. 26x
	14. 42x
	15. All
	16. Cancel" crlf crlf)
	
	(bind ?optzoom (lowcase (sym-cat (read))))
	
	(bind ?ok 0)
	(while (= ?ok 0)
		(switch ?optzoom
		(case 3x then (assert (optzoom ?optzoom))
						 (bind ?ok 1))
		(case 4x then (assert (optzoom ?optzoom))
						 (bind ?ok 1))
		(case 5x then (assert (optzoom ?optzoom))
						 (bind ?ok 1))
		(case 6x then (assert (optzoom ?optzoom))
						   (bind ?ok 1))
		(case 7x then (assert (optzoom ?optzoom))
						   (bind ?ok 1))
		(case 8x then (assert (optzoom ?optzoom))
						   (bind ?ok 1))
		(case 10x then (assert (optzoom ?optzoom))
						   (bind ?ok 1))
		(case 12x then (assert (optzoom ?optzoom))
						   (bind ?ok 1))
		(case 14x then (assert (optzoom ?optzoom))
						   (bind ?ok 1))
		(case 16x then (assert (optzoom ?optzoom))
						   (bind ?ok 1))
		(case 18x then (assert (optzoom ?optzoom))
						   (bind ?ok 1))
		(case 20x then (assert (optzoom ?optzoom))
						   (bind ?ok 1))
		(case 26x then (assert (optzoom ?optzoom))
						   (bind ?ok 1))
		(case 42x then (assert (optzoom ?optzoom))
						   (bind ?ok 1))
		(case all then (assert (optzoom ?optzoom))
					   (bind ?ok 1))
		(case cancel then (printout t "Bye bye!!" crlf)
						  (retract *)
						  (bind ?ok 1))
		(default (printout t "Wrong input. Try again" crlf crlf)
				 (bind ?optzoom (lowcase (sym-cat(read))))))))	
				 
				 
(defrule get_iso
	"Fifth question: camera max ISO"
	(optzoom ?optok&3x|4x|5x|6x|7x|8x|10x|12x|14x|16x|18x|20x|26x|42x|all|no_zoom)
	=>
	(printout t crlf "Choose maximum ISO:
	1.  1600
	2.  3200
	3.  6400
	4. 12800
	5. 16000
	7. All
	8. Cancel" crlf crlf)
	
	(bind ?iso (lowcase(sym-cat (read))))
	
	(bind ?ok 0)
	(while (= ?ok 0)
		(switch ?iso
		(case (sym-cat 1600) then (assert (iso (sym-cat ?iso m)))
						 (bind ?ok 1))
		(case (sym-cat 3200) then (assert (iso (sym-cat ?iso m)))
						 (bind ?ok 1))
		(case (sym-cat 6400) then (assert (iso (sym-cat ?iso m)))
						 (bind ?ok 1))
		(case (sym-cat 12800) then (assert (iso (sym-cat ?iso m)))
						   (bind ?ok 1))
		(case (sym-cat 16000) then (assert (iso (sym-cat ?iso m)))
						   (bind ?ok 1))
		(case all then (assert (iso ?iso))
					   (bind ?ok 1))
		(case cancel then (printout t "Bye bye!!" crlf)
						  (retract *)
						  (bind ?ok 1))
		(default (printout t "Wrong input. Try again" crlf crlf)
				 (bind ?iso (lowcase(sym-cat (read))))))))
				 
				 
				 
(defrule get_videoan
	"Sixth question: camera video analysis"
	(iso ?isook&1600m|3200m|6400m|12800m|16000m|all)
	=>
	(printout t crlf "Choose video analysis:
	1.   640x480
	2.  1280x720
	3. 1920x1080
	4. No_video
	5. All
	6. Cancel" crlf crlf)
	
	(bind ?videoan (lowcase (sym-cat (read))))
	
	(bind ?ok 0)
	(while (= ?ok 0)
		(switch ?videoan
		(case 640x480 then (assert (videoan ?videoan))
						 (bind ?ok 1))
		(case 1280x720 then (assert (videoan ?videoan))
						 (bind ?ok 1))
		(case 1920x1080 then (assert (videoan ?videoan))
						 (bind ?ok 1))
		(case no_video then (assert (videoan ?videoan))
						   (bind ?ok 1))
		(case all then (assert (videoan ?videoan))
					   (bind ?ok 1))
		(case cancel then (printout t "Bye bye!!" crlf)
						  (retract *)
						  (bind ?ok 1))
		(default (printout t "Wrong input. Try again" crlf crlf)
				 (bind ?videoan (lowcase (sym-cat (read))))))))


(defrule get_3d
	"Seventh question: 3D Technology"
	(videoan ?videoanok&640x480|1280x720|1920x1080|no_video|all)
	=>
	(printout t crlf "You want the camera to be 3D technology?
	1. Yes
	2. No
	3. All
	4. Cancel" crlf crlf)
	
	(bind ?threed (lowcase (sym-cat (read))))
	
	(bind ?ok 0)
	(while (= ?ok 0)
		(switch ?threed
		(case yes then (assert (threed ?threed))
						 (bind ?ok 1))
		(case no then (assert (threed ?threed))
						 (bind ?ok 1))
		(case all then (assert (threed ?threed))
					   (bind ?ok 1))
		(case cancel then (printout t "Bye bye!!" crlf)
						  (retract *)
						  (bind ?ok 1))
		(default (printout t "Wrong input. Try again" crlf crlf)
				 (bind ?threed (lowcase (sym-cat (read))))))))
	
	
(defrule get_color
	"Eigth question: camera color"
	(threed ?threedok&yes|no|all)
	=>
	(printout t crlf "Choose color:
	1.  Black
	2.  Blue
	3.  Brown
	4.  Gold
	5.  Green
	6.  Grey
	7.  Orange
	8.  Pink
	9.  Purple
	10. Red
	11. Silver
	12. Violet
	13. White
	14. Yellow
	15. All
	16. Cancel" crlf crlf)
	
	(bind ?color (lowcase (sym-cat (read))))
	
	(bind ?ok 0)
	(while (= ?ok 0)
		(switch ?color
		(case black then (assert (color ?color))
						 (bind ?ok 1))
		(case blue then (assert (color ?color))
						 (bind ?ok 1))
		(case brown then (assert (color ?color))
						 (bind ?ok 1))
		(case gold then (assert (color ?color))
						   (bind ?ok 1))
		(case green then (assert (color ?color))
						   (bind ?ok 1))
		(case grey then (assert (color ?color))
						   (bind ?ok 1))
		(case orange then (assert (color ?color))
						   (bind ?ok 1))
		(case pink then (assert (color ?color))
						   (bind ?ok 1))
		(case purple then (assert (color ?color))
						   (bind ?ok 1))
		(case red then (assert (color ?color))
						   (bind ?ok 1))
		(case silver then (assert (color ?color))
						   (bind ?ok 1))
		(case violet then (assert (color ?color))
						   (bind ?ok 1))
		(case white then (assert (color ?color))
						   (bind ?ok 1))
		(case yellow then (assert (color ?color))
						   (bind ?ok 1))
		(case all then (assert (color ?color))
					   (bind ?ok 1))
		(case cancel then (printout t "Bye bye!!" crlf)
						  (retract *)
						  (bind ?ok 1))
		(default (printout t "Wrong input. Try again" crlf crlf)
				 (bind ?color (lowcase (sym-cat(read))))))))
				 
				 
				 
(defrule get_price
	"Ninth question: camera price"
	(color ?colorok&black|blue|brown|gold|green|grey|orange|pink|purple|red|silver|violet|white|yellow|all)
	=>
	(printout t crlf "Choose price range:
	1.       0-99
	2.    100-199
	3.    200-299
	4.    300-399
	5.    400-599
	6.    600-799
	7.    800-999
	8.  1000-1199
	9.  1200-1399
	10. 1400-1600
	11. All
	12. Cancel" crlf crlf)
	
	(bind ?price (lowcase (sym-cat (read))))
	
	(bind ?ok 0)
	(while (= ?ok 0)
		(switch ?price
		(case 0-99 then (assert (price ?price))
						 (bind ?ok 1))
		(case 100-199 then (assert (price ?price))
						 (bind ?ok 1))
		(case 200-299 then (assert (price ?price))
						 (bind ?ok 1))
		(case 300-399 then (assert (price ?price))
						   (bind ?ok 1))
		(case 400-599 then (assert (price ?price))
						   (bind ?ok 1))
		(case 600-799 then (assert (price ?price))
						   (bind ?ok 1))
		(case 800-999 then (assert (price ?price))
						   (bind ?ok 1))
		(case 1000-1199 then (assert (price ?price))
						   (bind ?ok 1))
		(case 1200-1399 then (assert (price ?price))
						   (bind ?ok 1))
		(case 1400-1600 then (assert (price ?price))
						   (bind ?ok 1))
		(case all then (assert (price ?price))
					   (bind ?ok 1))
		(case cancel then (printout t "Bye bye!!" crlf)
						  (retract *)
						  (bind ?ok 1))
		(default (printout t "Wrong input. Try again" crlf crlf)
				 (bind ?price (lowcase (sym-cat(read))))))))
				 

(deffunction print_camera (?name ?brand ?type ?megapixels ?optzoom ?iso ?videoan ?threed ?color ?price)
	(printout t crlf "------------------------------" crlf ?name crlf "------------------------------" crlf)
	(printout t "brand:" tab ?brand crlf)
	(printout t "Type:" tab ?type crlf)
	(printout t "Megapixels:" tab ?megapixels crlf)
	(printout t "Optical Zoom: " tab ?optzoom crlf)
	(printout t "Maximum ISO:" tab ?iso crlf)
	(printout t "Video Analysis:" tab ?videoan crlf)
	(printout t "3D: " tab ?threed crlf)
	(printout t "Color:" tab ?color crlf)
	(printout t "Price:" tab ?price crlf)
	(printout t "==============================" crlf))


	
;;database
(defrule Ixus_115HS
	(brand canon|all)
	(type lifestyle|all)
	(megapixels 12mp|all)
	(optzoom 4x|all)
	(iso 3200m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color pink|all)
	(price 100-199|all)
	=>
	(print_camera Ixus_115HS canon lifestyle 12 4 3200 1280x720 no pink 135))

	
(defrule A800
	(brand canon|all)
	(type lifestyle|all)
	(megapixels 10mp|all)
	(optzoom 3x|all)
	(iso 1600m|all)
	(videoan 640x480|all)
	(threed no|all)
	(color silver|all)
	(price 0-99|all)
	=>
	(print_camera A800 canon lifestyle 10 3 1600 640x480 no silver 49))
	
(defrule SX_220HS
	(brand canon|all)
	(type high_zoom|all)
	(megapixels 12mp|all)
	(optzoom 14x|all)
	(iso 3200m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color purple|all)
	(price 200-299|all)
	=>
	(print_camera SX_220HS canon high_zoom 12 14 3200 1280x720 no purple 219))
	
(defrule EOS_1100D
	(brand canon|all)
	(type dslr|all)
	(megapixels 12mp|all)
	(iso 6400m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color black|all)
	(price 400-599|all)
	=>
	(print_camera EOS_1100D canon dslr 12 no_zoom 6400 1280x720 no black 469))
	
(defrule G12
	(brand canon|all)
	(type high_performance|all)
	(megapixels 10mp|all)
	(optzoom 5x|all)
	(iso 3200m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color black|all)
	(price 400-599|all)
	=>
	(print_camera G12 canon high_performance 10 5 3200 1280x720 no black 529))
	
(defrule EOS_550D
	(brand canon|all)
	(type dslr|all)
	(megapixels 18mp|all)
	(iso 6400m|all)
	(videoan 1920x1080|all)
	(threed no|all)
	(color black|all)
	(price 600-799|all)
	=>
	(print_camera EOS_550D canon dslr 18 no_zoom 6400 1920x1080 no black 695))
	
(defrule A3300
	(brand canon|all)
	(type lifestyle|all)
	(megapixels 16mp|all)
	(optzoom 5x|all)
	(iso 1600m|all)
	(videoan 640x480|all)
	(threed no|all)
	(color blue|all)
	(price 100-199|all)
	=>
	(print_camera A3300 canon lifestyle 16 5 1600 640x480 no blue 109))
	
(defrule M532
	(brand kodak|all)
	(type lifestyle|all)
	(megapixels 14mp|all)
	(optzoom 4x|all)
	(iso 1600m|all)
	(videoan 640x480|all)
	(threed no|all)
	(color silver|all)
	(price 0-99|all)
	=>
	(print_camera M532 kodak lifestyle 14 4 1600 640x480 no silver 79))
	
(defrule M552
	(brand kodak|all)
	(type lifestyle|all)
	(megapixels 14mp|all)
	(optzoom 5x|all)
	(iso 1600m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color silver|all)
	(price 0-99|all)
	=>
	(print_camera M552 kodak lifestyle 14 5 1600 1280x720 no silver 75))
	
(defrule M583
	(brand kodak|all)
	(type high_zoom|all)
	(megapixels 14mp|all)
	(optzoom 8x|all)
	(iso 1600m|all)
	(videoan 640x480|all)
	(threed no|all)
	(color black|all)
	(price 0-99|all)
	=>
	(print_camera M583 kodak high_zoom 14 8 1600 640x480 no black 99))

(defrule L25
	(brand nikon|all)
	(type lifestyle|all)
	(megapixels 10mp|all)
	(optzoom 5x|all)
	(iso 1600m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color red|all)
	(price 0-99|all)
	=>
	(print_camera L25 nikon lifestyle 10 5 1600 1280x720 no red 69))
	
(defrule L26
	(brand nikon|all)
	(type lifestyle|all)
	(megapixels 16mp|all)
	(optzoom 5x|all)
	(iso 1600m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color yellow|all)
	(price 0-99|all)
	=>
	(print_camera L26 nikon lifestyle 16 5 1600 1280x720 no yellow 89))
	
(defrule S2600
	(brand nikon|all)
	(type lifestyle|all)
	(megapixels 14mp|all)
	(optzoom 5x|all)
	(iso 3200m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color pink|all)
	(price 0-99|all)
	=>
	(print_camera S2600 nikon lifestyle 14 5 3200 1280x720 no pink 94))
	
(defrule S3300
	(brand nikon|all)
	(type lifestyle|all)
	(megapixels 16mp|all)
	(optzoom 6x|all)
	(iso 3200m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color purple|all)
	(price 100-199|all)
	=>
	(print_camera S3300 nikon lifestyle 16 6 3200 1280x720 no purple 129))

(defrule L310
	(brand nikon|all)
	(type high_performance|all)
	(megapixels 14mp|all)
	(optzoom 20x|all)
	(iso 6400m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color black|all)
	(price 100-199|all)
	=>
	(print_camera L310 nikon high_performance 14 21 6400 1280x720 no black 199))
	
(defrule S8200
	(brand nikon|all)
	(type high_zoom|all)
	(megapixels 16mp|all)
	(optzoom 14x|all)
	(iso 3200m|all)
	(videoan 1920x1080|all)
	(threed no|all)
	(color gold|all)
	(price 200-299|all)
	=>
	(print_camera S8200 nikon high_zoom 16 14 3200 1920x1080 no gold 229))
	
(defrule L810
	(brand nikon|all)
	(type high_performance|all)
	(megapixels 16mp|all)
	(optzoom 26x|all)
	(iso 1600m|all)
	(videoan 1280x720|all)
	(threed yes|all)
	(color black|all)
	(price 200-299|all)
	=>
	(print_camera L810 nikon high_performance 16 26 1600 1280x720 yes black 239))
	
(defrule P510
	(brand nikon|all)
	(type high_performance|all)
	(megapixels 16mp|all)
	(optzoom 42x|all)
	(iso 3200m|all)
	(videoan 1920x1080|all)
	(threed yes|all)
	(color black|all)
	(price 300-399|all)
	=>
	(print_camera P510 nikon high_performance 16 42 3200 1920x1080 yes black 379))
	
(defrule J1
	(brand nikon|all)
	(type dslr|all)
	(megapixels 10mp|all)
	(iso 3200m|all)
	(videoan 1920x1080|all)
	(threed no|all)
	(color black|all)
	(price 400-599|all)
	=>
	(print_camera J1 nikon dslr 10 no_zoom 3200 1920x1080 no black 474))
	
(defrule P7100
	(brand nikon|all)
	(type high_performance|all)
	(megapixels 10mp|all)
	(optzoom 7x|all)
	(iso 12800m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color black|all)
	(price 400-599|all)
	=>
	(print_camera P7100 nikon high_performance 10 7 12800 1280x720 no black 479))
	
(defrule S2500
	(brand nikon|all)
	(type lifestyle|all)
	(megapixels 12mp|all)
	(optzoom 4x|all)
	(iso 3200m|all)
	(videoan 640x480|all)
	(threed no|all)
	(color orange|all)
	(price 0-99|all)
	=>
	(print_camera S2500 nikon lifestyle 12 4 3200 640x480 no orange 49))
	
(defrule VG-150
	(brand olympus|all)
	(type lifestyle|all)
	(megapixels 12mp|all)
	(optzoom 4x|all)
	(iso 1600m|all)
	(videoan 640x480|all)
	(threed no|all)
	(color gold|all)
	(price 0-99|all)
	=>
	(print_camera VG-150 olympus lifestyle 12 4 1600 640x480 no gold 79))
	
(defrule VR-340
	(brand olympus|all)
	(type high_zoom|all)
	(megapixels 16mp|all)
	(optzoom 10x|all)
	(iso 1600m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color green|all)
	(price 100-199|all)
	=>
	(print_camera VR-340 olympus high_zoom 16 10 1600 1280x720 no green 149))
	
(defrule SP-810UZ
	(brand olympus|all)
	(type high_performance|all)
	(megapixels 14mp|all)
	(optzoom 42x|all)
	(iso 3200m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color silver|all)
	(price 200-299|all)
	=>
	(print_camera SP-810UZ olympus high_performance 14 42 3200 1280x720 no silver 265))
	
(defrule TG-310
	(brand olympus|all)
	(type lifestyle|all)
	(megapixels 14mp|all)
	(optzoom 3x|all)
	(iso 1600m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color white|all)
	(price 100-199|all)
	=>
	(print_camera TG-310 olympus lifestyle 14 3 1600 1280x720 no white 139))
	
(defrule DMC-S2
	(brand panasonic|all)
	(type lifestyle|all)
	(megapixels 14mp|all)
	(optzoom 4x|all)
	(iso 1600m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color violet|all)
	(price 100-199|all)
	=>
	(print_camera DMC-S2 panasonic lifestyle 14 4 1600 1280x720 no violet 102))
	
(defrule DMC-FT20
	(brand panasonic|all)
	(type lifestyle|all)
	(megapixels 16mp|all)
	(optzoom 4x|all)
	(iso 1600m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color orange|all)
	(price 200-299|all)
	=>
	(print_camera DMC-FT20 panasonic lifestyle 16 4 1600 1280x720 no orange 249))
	
(defrule DMC-TZ25
	(brand panasonic|all)
	(type high_performance|all)
	(megapixels 12mp|all)
	(optzoom 16x|all)
	(iso 3200m|all)
	(videoan 1920x1080|all)
	(threed no|all)
	(color white|all)
	(price 300-399|all)
	=>
	(print_camera DMC-TZ25 panasonic high_performance 12 16 3200 1920x1080 no white 332))
	
(defrule DMC-TZ30
	(brand panasonic|all)
	(type high_performance|all)
	(megapixels 14mp|all)
	(optzoom 20x|all)
	(iso 3200m|all)
	(videoan 1920x1080|all)
	(threed no|all)
	(color brown|all)
	(price 300-399|all)
	=>
	(print_camera DMC-TZ30 panasonic high_performance 14 20 3200 1920x1080 no brown 379))
	
(defrule DMC-FS16
	(brand panasonic|all)
	(type lifestyle|all)
	(megapixels 14mp|all)
	(optzoom 4x|all)
	(iso 1600m|all)
	(videoan 640x480|all)
	(threed no|all)
	(color pink|all)
	(price 0-99|all)
	=>
	(print_camera DMC-FS16 panasonic lifestyle 14 4 1600 640x480 no pink 79))
	
(defrule DMC-TZ20
	(brand panasonic|all)
	(type high_performance|all)
	(megapixels 14mp|all)
	(optzoom 16x|all)
	(iso 1600m|all)
	(videoan 1280x720|all)
	(threed yes|all)
	(color blue|all)
	(price 200-299|all)
	=>
	(print_camera DMC-TZ20 panasonic high_performance 14 16 1600 1280x720 yes blue 239))
	
(defrule EC-PL170
	(brand samsung|all)
	(type lifestyle|all)
	(megapixels 16mp|all)
	(optzoom 5x|all)
	(iso 3200m|all)
	(videoan 1920x1080|all)
	(threed no|all)
	(color yellow|all)
	(price 100-199|all)
	=>
	(print_camera EC-PL170 samsung lifestyle 16 5 3200 1920x1080 no yellow 139))
	
(defrule EC-WB150F
	(brand samsung|all)
	(type high_zoom|all)
	(megapixels 14mp|all)
	(optzoom 18x|all)
	(iso 3200m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color black|all)
	(price 200-299|all)
	=>
	(print_camera EC-WB150F samsung high_zoom 14 18 3200 1280x720 no black 210))
	
(defrule EC-WB850F
	(brand samsung|all)
	(type high_performance|all)
	(megapixels 16mp|all)
	(optzoom 20x|all)
	(iso 3200m|all)
	(videoan 1920x1080|all)
	(threed no|all)
	(color black|all)
	(price 300-399|all)
	=>
	(print_camera EC-WB850F samsung high_performance 16 20 3200 1920x1080 no black 379))
	
(defrule EC-PL210
	(brand samsung|all)
	(type high_zoom|all)
	(megapixels 14mp|all)
	(optzoom 10x|all)
	(iso 1600m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color black|all)
	(price 100-199|all)
	=>
	(print_camera EC-PL210 samsung high_zoom 14 10 1600 1280x720 no black 119))
	
(defrule MV800
	(brand samsung|all)
	(type lifestyle|all)
	(megapixels 16mp|all)
	(optzoom 5x|all)
	(iso 3200m|all)
	(videoan 1280x720|all)
	(threed yes|all)
	(color black|all)
	(price 200-299|all)
	=>
	(print_camera MV800 samsung lifestyle 16 5 3200 1280x720 yes black 229))
	
(defrule DSC-S5000
	(brand sony|all)
	(type lifestyle|all)
	(megapixels 14mp|all)
	(optzoom 5x|all)
	(iso 3200m|all)
	(videoan 640x480|all)
	(threed no|all)
	(color yellow|all)
	(price 0-99|all)
	=>
	(print_camera DSC-S5000 sony lifestyle 14 5 3200 640x480 no yellow 84))
	
(defrule DSC-W610
	(brand sony|all)
	(type lifestyle|all)
	(megapixels 14mp|all)
	(optzoom 4x|all)
	(iso 3200m|all)
	(videoan 640x480|all)
	(threed no|all)
	(color green|all)
	(price 0-99|all)
	=>
	(print_camera DSC-W610 sony lifestyle 14 4 3200 640x480 no green 89))
	
(defrule DSC-W620
	(brand sony|all)
	(type lifestyle|all)
	(megapixels 14mp|all)
	(optzoom 6x|all)
	(iso 3200m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color red|all)
	(price 100-199|all)
	=>
	(print_camera DSC-W620 sony lifestyle 14 6 3200 1280x720 no red 122))
	
(defrule DSC-H90
	(brand sony|all)
	(type high_zoom|all)
	(megapixels 16mp|all)
	(optzoom 16x|all)
	(iso 3200m|all)
	(videoan 1280x720|all)
	(threed no|all)
	(color brown|all)
	(price 200-299|all)
	=>
	(print_camera DSC-H90 sony high_zoom 16 16 3200 1280x720 no brown 236))
	
(defrule DSC-WX100
	(brand sony|all)
	(type high_zoom|all)
	(megapixels 18mp|all)
	(optzoom 10x|all)
	(iso 12800m|all)
	(videoan 1920x1080|all)
	(threed yes|all)
	(color white|all)
	(price 200-299|all)
	=>
	(print_camera DSC-WX100 sony high_zoom 18 10 12800 1920x1080 yes white 255))
	
(defrule DSC-HX20V
	(brand sony|all)
	(type high_performance|all)
	(megapixels 18mp|all)
	(optzoom 20x|all)
	(iso 12800m|all)
	(videoan 1920x1080|all)
	(threed yes|all)
	(color black|all)
	(price 400-599|all)
	=>
	(print_camera DSC-HX20V sony high_performance 18 20 12800 1920x1080 yes black 439))
	
(defrule DSC-HX200V
	(brand sony|all)
	(type high_performance|all)
	(megapixels 18mp|all)
	(optzoom 26x|all)
	(iso 3200m|all)
	(videoan 1920x1080|all)
	(threed yes|all)
	(color black|all)
	(price 400-599|all)
	=>
	(print_camera DSC-HX200V sony high_performance 18 26 3200 1920x1080 yes black 504))
	
(defrule SLT-A65VK
	(brand sony|all)
	(type dslr|all)
	(megapixels 20mp|all)
	(iso 16000m|all)
	(videoan 1920x1080|all)
	(threed yes|all)
	(color black|all)
	(price 1000-1199|all)
	=>
	(print_camera SLT-A65VK sony dslr 20 no_zoom 16000 1920x1080 yes black 1150))
	
(defrule SLT-A35K
	(brand sony|all)
	(type dslr|all)
	(megapixels 16mp|all)
	(iso 12800m|all)
	(videoan 1920x1080|all)
	(threed no|all)
	(color black|all)
	(price 600-799|all)
	=>
	(print_camera SLT-A35K sony dslr 16 no_zoom 12800 1920x1080 no black 649))
