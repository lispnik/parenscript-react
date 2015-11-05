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

(defpsmacro defcomponent (name methods &body body)
  `(psetq ,name
          (React.createClass
           (create 'display-name ',name
                   ,@(mapcan #'(lambda (method)
                                 (destructuring-bind (defun-ignore name args &body body) method
                                   (declare (ignore defun-ignore))
                                   (list name `(lambda ,args ,@body))))
                             methods)))))

(ps
  (defcomponent *Foo
      ((defun render (foo bar baz)
         (+ 1 2))

       (defun component-did-mount ()
         (console.log "lol")))))

#.(setf (readtable-case *readtable*) :upcase)
