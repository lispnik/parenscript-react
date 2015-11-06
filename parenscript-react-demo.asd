(defpackage #:parenscript-react-demo-system (:use #:common-lisp #:asdf))
(in-package #:parenscript-react-demo-system)

(defsystem #:parenscript-react-demo
  :serial t
  :components ((:module "demo"
                        :components ((:file "package")
                                     (:file "demo"))))
  :depends-on (#:parenscript
               #:hunchentoot
               #:parenscript-react))
