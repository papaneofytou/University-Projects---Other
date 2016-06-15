;;pots problem
;;by Georgia Papaneofytou

;;problem's representation (a/amax, b/bmax, c/cmax) where a, b, c is the number of litres the corresponding pot contains and amax, bmax, cmax the maximum number of litres they can contain.

(defvar *inok* 0)
(defvar *maxv* (list 7 4 2)) 
(defvar *cv* (list -2 -2 -2))

(defvar a 0)
(defvar b 1)
(defvar c 2)

(defvar *ok* -1)
(defvar *fileout* 0)

(defun main ()
  (let* (
    (ch1 0)
    (x 0)
    (z 0)
    (filein 0)
    (ex 0)
    (char1 0)
    (char2 0)
    (charr 0))

    (setf *inok* 0)
    (format t "~2%General Instructions 
               ~%--------------------- 
               ~% We have three pots: a, b, c. The maximum litres for each are 7, 4, 2 respectively.
               ~% At first you must give the initial amount of litres for each pot either by console or file.
               ~% Then you can use the available actions to achieve your goal.
               ~% The available actions are: 
               ~%   1. Fill the pot. Use the command: (fillPot pot)
               ~%   2. Empty the pot. Use the command: (emptyPot pot)
               ~%   3. Transfuse the content of a pot to another pot. Use the command: (transfusion pot1 pot2)
               ~% Where \"pot\" you must use the numbers 0 for pot a, 1 for pot b and 2 for pot c.
               ~% You can exit the program by typing -1 at any point.
               ~%---------------------------------------------------------------------------------------------
               ~3%")

    (format t "You must first provide a file for the record of the interaction.~%")
    (loop until (= x 1) do
      (setf z 0)
      (format t "Enter the device you want the file to be stored to (e.g. For disk C enter the letter c) (-1 to exit):   ")
      (setf *fileout* (prin1-to-string (read)))
      (if (string-equal *fileout* "-1") (return-from main)) 
      (format t "~%Enter the full path of the file without the device letter (e.g. For path C:/Users/Giorgina/Desktop/pots.txt enter Users/Giorgina/Desktop/pots.txt) (-1 to exit):   ")
      (setf ex (prin1-to-string (read)))
      (if (string-equal ex "-1") (return-from main))
      (setf *fileout* (concatenate 'string *fileout* ":/" ex))
      (if (probe-file *fileout*) (progn (loop until (= z 1) do
	                                (format t "File already exist. Proceed and replace? (y/n) (-1 to exit):   ") 
                                        (setf ex (prin1-to-string (read)))
                                        (cond ((string-equal ex "y") (with-open-file (str *fileout* 
								       :direction :output
								       :if-exists :supersede
								       :if-does-not-exist :create))
								     (setf z 1)	
								     (setf x 1))
					      ((string-equal ex "n") (setf z 1))
					      ((string-equal ex "-1") (return-from main))
					      (t (format t "~%Wrong input. Try again:   ")))))
			       (progn (with-open-file (str *fileout* 
				        :direction :output
				        :if-exists :supersede
				        :if-does-not-exist :create))
				      (setf x 1))))

    (loop until (or (eql ch1 1) (eql ch1 2)) do
      (format t "~%Insert initial state from ~%  1. Console ~%  2. File ~%Please choose method (-1 to exit): ~2%")
      (setf ch1 (read))
      (cond ((eql ch1 1)
               ;;reading from console
               (setf x 0)
               (loop until (= x 1) do
                 (format t "~%Enter the initial amount of litres in pot a (-1 to exit):  ")
				 (setf (nth 0 *cv*) (read))
                 (if (integerp (nth 0 *cv*)) (if (= (nth 0 *cv*) -1) (return-from main) (setf x (check1 (nth 0 *cv*) (nth 0 *maxv*)))) 
                                             (format t "Please give an integer between 0 and ~a.~2%" (nth 0 *maxv*))))
               (setf x 0)
               (loop until (= x 1) do
                 (format t "~%Enter the initial amount of litres in pot b (-1 to exit):  ")
                 (setf (nth 1 *cv*) (read))
                 (if (integerp (nth 1 *cv*)) (if (= (nth 1 *cv*) -1) (return-from main) (setf x (check1 (nth 1 *cv*) (nth 1 *maxv*)))) 
                                             (format t "Please give an integer between 0 and ~a.~2%" (nth 1 *maxv*))))
               (setf x 0)
               (loop until (= x 1) do
                 (format t "~%Enter the initial amount of litres in pot c (-1 to exit):  ")
                 (setf (nth 2 *cv*) (read))
                 (if (integerp (nth 2 *cv*)) (if (= (nth 2 *cv*) -1) (return-from main) (setf x (check1 (nth 2 *cv*) (nth 2 *maxv*)))) 
                                             (format t "Please give an integer between 0 and ~a.~2%" (nth 2 *maxv*))))
               (setf *inok* 1)
               (format t "~2%Initial state given. ~%")
               (writeToFile *fileout* "Initial state:   ")
               (setf ex (writeState))
	       (writeToFile *fileout* ex)
               (printState))
            ((eql ch1 2)
               ;;reading from file
               (setf x 0)
               (format t "~2%The format of the file must be in the form of \"a = x  b = y  c = z\"
                          ~%where x, y, z are integers values for the capacities of the corresponding pots.
                          ~%Blanks and new lines are also allowed. 
                          ~%-------------------------------------------------------------------------------~3%")
               (loop until (= x 1) do
                 (format t "Enter the device that contains the file (e.g. For disk C enter the letter c) (-1 to exit):   ")
                 (setf filein (prin1-to-string (read)))
                 (if (string-equal filein "-1") (return-from main)) 
                 (format t "~%Enter the full path of the file without the device letter (e.g. For path C:/Users/Giorgina/Desktop/pots.txt enter Users/Giorgina/Desktop/pots.txt) (-1 to exit):   ")
                 (setf ex (prin1-to-string (read)))
                 (if (string-equal ex "-1") (return-from main))
                 (setf filein (concatenate 'string filein ":/" ex))
                 (if (probe-file filein) (setf x 1) (format t "File does not exist. Please try again. ~2%")))
               (setf x 0)
               (with-open-file (stream filein)
                 (setf *ok* 0)
                 (do ((line (read-line stream nil) (read-line stream nil)))
                     ((null line))
                     ;;(print line)
                     (with-input-from-string (stream2 line)
                       (do ((char (peek-char t stream2 nil) (peek-char t stream2 nil)))
                           ((null char))
                           (cond ((= 0 *ok*) 
                                    (setf char1 (read-char stream2 nil))
                                    (peek-char t stream2 nil)
                                    (setf char2 (read-char stream2 nil))
                                    (setf charr "a")
                                    (setf x (check3 char1 charr char2)))
                                 ((= 1 *ok*)
                                    (setf char1 (read stream2))
                                    (setf x (check2 0 char1)))
                                 ((= 2 *ok*)
                                    (setf char1 (read-char stream2 nil)) 
                                    (peek-char t stream2 nil)
                                    (setf char2 (read-char stream2 nil))
                                    (setf charr "b")
                                    (setf x (check3 char1 charr char2)))
                                 ((= 3 *ok*)
                                    (setf char1 (read stream2)) 
                                    (setf x (check2 1 char1)))
                                 ((= 4 *ok*)
                                    (setf char1 (read-char stream2 nil)) 
                                    (peek-char t stream2 nil)
                                    (setf char2 (read-char stream2 nil))
                                    (setf charr "c")
                                    (setf x (check3 char1 charr char2))) 
                                 ((= 5 *ok*) 
                                    (setf char1 (read stream2)) 
                                    (setf x (check2 2 char1))
                                    (if (= x 1) (setf *inok* 1)))
                                 (t (format t "Wrong format of data in file. Please change the file and try again.~2%") 
                                    (setf *inok* 0) 
                                    (return-from main)))
                           (if (= x -1) (return-from main))))))
						   (writeToFile *fileout* "Initial state:   ")
						   (setf ex (writeState))
	                       (writeToFile *fileout* ex))
            
            ((eql ch1 -1) (return))            
            (t (format t "~%Wrong input. Try again. ~2%"))))))

 
(defun check1 (p pmax)
  (if (and (>= p 0) (<= p pmax)) (return-from check1 1) 
                                 (progn (format t "Value must be between 0 and ~a. ~%Please try again. ~2%" pmax) 
                                        (return-from check1 -1))))

										
(defun check2 (mem num)
  (let* ((y 0))
  (if (integerp num) (progn (setf (nth mem *cv*) num)
                            (setf y (check1 (nth mem *cv*) (nth mem *maxv*)))) 
                     (progn (format t "Wrong format of data in file. Expected integer. Please change the file and try again.~2%")
						    (setf y -1)))
  (if (= y 1) (setf *ok* (incf *ok*)))
  (return-from check2 y)))
															  

(defun check3 (char1 charr char2)
  (if (string-equal char1 charr) (if (string-equal char2 "=") (setf *ok* (incf *ok*))
                                                              (progn (format t "Wrong format of data in file. Expected character \"=\" after character \"~a\". Please change the file and try again.~2%" char1)
                                                              (setf *ok* -1)))
							     (progn (setf *ok* -1)
								        (format t "Wrong format of data in file. Expected character \"~a\". Please change the file and try again.~2%" charr)))
  (return-from check3 *ok*))

															  
(defun printState ()
  (if (= *inok* 1) (progn (format t "Current state: (~a/~a, ~a/~a, ~a/~a) ~%" (nth 0 *cv*) (nth 0 *maxv*) (nth 1 *cv*) (nth 1 *maxv*) (nth 2 *cv*) (nth 2 *maxv*)))
                   (format t "Program not initialized. Please execute the command: (main) ~2%")))


(defun fillPot (p)
  (let* ((y 0))
    (if (= *inok* 1) (progn (if (or (= p 0) (= p 1) (= p 2)) (if (= (nth p *cv*) (nth p *maxv*)) (format t "Pot is already full. ~%") 
                                                                                                 (progn (setf (nth p *cv*) (nth p *maxv*))
                                                                                                        (setf y (concatenate 'string "Filling pot " (prin1-to-string p) "..."))
                                                                                                        (writeToFile *fileout* y)
                                                                                                        (writeToFile *fileout* (writeState))))
                                                             (format t "Wrong input. Argument must be a(0), b(1) or c(2). ~2%"))
                            (printState))
                     (format t "Program not initialized. Please execute the command: (main) ~2%"))))


(defun emptyPot (p)
  (let* ((y 0))
    (if (= *inok* 1) (progn (if (or (= p 0) (= p 1) (= p 2)) (if (= (nth p *cv*) 0) (format t "Pot is already empty. ~%") 
                                                                                    (progn (setf (nth p *cv*) 0)
                                                                                           (setf y (concatenate 'string "Emptying pot " (prin1-to-string p) "..."))
                                                                                           (writeToFile *fileout* y)
                                                                                           (writeToFile *fileout* (writeState))))
                                                             (format t "Wrong input. Argument must be a(0), b(1) or c(2). ~2%"))
                            (printState))
                     (format t "Program not initialized. Please execute the command: (main) ~2%"))))


(defun transfusion (p1 p2)
  (let* ((y 0))
    (if (= *inok* 1) (progn (if (and (or (= p1 a) (= p1 b) (= p1 c)) (or (= p2 a) (= p2 b) (= p2 c)))
                                  (if (> (nth p1 *cv*) 0) (if (< (nth p2 *cv*) (nth p2 *maxv*))
                     								        (progn (if (> (nth p1 *cv*) (- (nth p2 *maxv*) (nth p2 *cv*))) 
                                                              (progn (setf (nth p1 *cv*) (- (nth p1 *cv*) (- (nth p2 *maxv*) (nth p2 *cv*))))
                                                                     (setf (nth p2 *cv*) (nth p2 *maxv*)))
                                                              (progn (setf (nth p2 *cv*) (+ (nth p1 *cv*) (nth p2 *cv*)))
                                                                     (setf (nth p1 *cv*) 0)))
                                                                                               (setf y (concatenate 'string "Transfusing content of pot " (prin1-to-string p1) " to pot " (prin1-to-string p2)  "..."))
                                                                                               (writeToFile *fileout* y)
                                                                                               (writeToFile *fileout* (writeState)))
                                                            (format t "Pot ~a is full. Choose another action.~2%" p2))
                                                          (format t "Pot ~a is empty. Choose another action.~2%" p1))
                                  (format t "Wrong input. Arguments must be a(0), b(1) or c(2). ~2%"))
                            (printState))
                     (format t "Program not initialized. Please execute the command: (main) ~2%"))))


(defun writeState ()
  (let* ((y 0))
       (setf y (concatenate 'string "\(" (write-to-string (nth 0 *cv*)) "/" (write-to-string (nth 0 *maxv*)) "\, " (write-to-string (nth 1 *cv*)) "\/" (write-to-string (nth 1 *maxv*)) "\, " (write-to-string (nth 2 *cv*)) "\/" (write-to-string (nth 2 *maxv*)) "\)~2%"))
  (return-from writeState y))) 
  

(defun writeToFile (f_name content)
  (with-open-file (stream  f_name
                    :direction :output
                    :if-exists :append)
                  (format stream content))) 