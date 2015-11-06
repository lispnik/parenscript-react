(defpackage #:parenscript-react-system (:use #:common-lisp #:asdf))
(in-package #:parenscript-react-system)

(defsystem #:parenscript-react
  :serial t
  :components ((:file "package")
               (:file "parenscript-react"))
  :depends-on (#:parenscript))
