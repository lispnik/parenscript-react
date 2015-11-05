(in-package #:parenscript-react)

#.(setf (readtable-case *readtable*) :invert)

(defpsmacro create-class (specification)
  `(React.createClass ,specification))

(defpsmacro create-element (type &optional props &rest children)
  `(React.createElement ,type ,props ,@children))

(defpsmacro clone-element (element &optional props &rest children)
  `(React.cloneElement ,element ,props ,@children))

(defpsmacro create-factory (class)
  `(React.createFactory ,class))

(defpsmacro is-valid-element (object)
  `(React.isValidElement ,object))

(defpsmacro defcomponent (name mixins methods &body body)
  `(psetq ,name
          (React.createClass
           (create 'display-name ',name
                   ,@(mapcan #'(lambda (method)
                                 (destructuring-bind (name args &body body) method
                                   (list name `(lambda ,args ,@body))))
                             methods)))))

(ps
 (progn
   (psetq SetIntervalMixin
          (create 'willComponentMount
                  (lambda ()
                    (setf (@ this intervals) '()))

                  'setInterval
                  (lambda (&rest intervals)
                    (setf (@ this intervals) (ps:mapcar 'set-interval intervals))) ;; FIXME

                  'componentWillUnmount
                  (lambda () (map clear-interval (@ this inntervals)))))
   (defcomponent TockTock (SetIntervalMixin)
     ((render ()
              (create-element "p"
                              (concatenate 'string "React has been doing this for "
                                           (@ this state seconds) " seconds"))))
     )))

(ps* *ps-lisp-library*)
(ps



 (defcomponent *Foo ()
   ((render (foo bar baz)
            (+ 1 2))

    (component-did-mount ()
                         (console.log "lol")))))

#.(setf (readtable-case *readtable*) :upcase)
