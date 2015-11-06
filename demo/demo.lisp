(in-package #:parenscript-react-demo)

(define-easy-handler (parenscript :uri "/parenscript.js") ()
  (setf (content-type*) "application/javascript")
  (ps* *ps-lisp-library*))

(define-easy-handler (ticktoc :uri "/demo/ticktoc") ()
  (setf (content-type*) "text/html")
  (who-ps-html
   (:html
    (:head
     (:script :src "https://cdnjs.cloudflare.com/ajax/libs/react/0.14.2/react.js")
     (:script :src "https://cdnjs.cloudflare.com/ajax/libs/react/0.14.2/react-dom.js")
     (:script :src "/parenscript.js"))
    (:body
     (:div :id "content")
     (:script :src "/demo/ticktoc.js" :type "application/javascript")))))

#.(setf (readtable-case *readtable*) :invert)


(define-easy-handler (ticktoc-js :uri "/demo/ticktoc.js") ()
  (setf (content-type*) "application/javascript")
  (ps
    (defvar *set-interval-mixin
      (create component-will-mount
              (lambda ()
                (setf (@ this intervals) '()))

              set-interval
              (lambda (&rest intervals)
                (setf (@ this intervals) (mapcar set-interval intervals)))

              component-will-unmount
              (lambda ()
                (map clear-interval (@ this intervals)))))

    (defcomponent *tick-toc (*set-interval-mixin)
      ((get-initial-state ()
                          (create seconds 0))
       (component-did-mount ()
                            ((@ this set-interval) (@ this tick) 1000))
       (tick ()
             ((@ this set-state) (create seconds (1+ (@ this state seconds)))))
       (render ()
               (create-element "p" nil
                               (concatenate 'string "React has been doing this for " (@ this state seconds) " seconds")))))

    (render (create-element TickToc) (get-element-by-id "content"))))


;; (start (make-instance 'easy-acceptor :port 8080 :read-timeout 1000))

#.(setf (readtable-case *readtable*) :upcase)
