(defpackage #:parenscript-react
  (:use #:common-lisp
        #:parenscript)
  (:export #:create-class
           #:create-element
           #:clone-element))

(defpackage #:parenscript-react-user
  (:use #:common-lisp
        #:parenscript-react
        #:parenscript))
