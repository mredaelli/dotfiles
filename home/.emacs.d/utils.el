
(defun remove-nth-element (nth list)
  (if (zerop nth) (cdr list)
    (let ((last (nthcdr (1- nth) list)))
      (setcdr last (cddr last))
      list)))

(defun prepend-to-all (prefix list)
    (mapcar (lambda (c) (concatenate 'string prefix c)) list)
)
(defun flatten (list-of-lists)
  (apply #'append list-of-lists))
