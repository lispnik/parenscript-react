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

(defpsmacro defcomponent (name mixins methods)
  `(defvar ,name
          (React.createClass
           (create displayName ',name
                   mixins (list ,@mixins)
                   ,@(mapcan #'(lambda (method)
                                 (destructuring-bind (name args &body body) method
                                   (list name `(lambda ,args ,@body))))
                             methods)))))

(in-package #:parenscript-react-dom)

(defpsmacro render (element container &optional callback)
  `(ReactDOM.render ,element ,container ,callback))

;; Not really part of React API:

(defpsmacro get-element-by-id (id)
  `(document.getElementById ,id))

#.(setf (readtable-case *readtable*) :upcase)
