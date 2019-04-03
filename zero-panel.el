;; provide emacs interface for zero-panel dbus service.

;;================
;; implementation
;;================

(require 'dbus)

(defun zero-panel-async-call (method handler &rest args)
  "call Method on zero-panel service asynchronously. This is a wrapper around `dbus-call-method-asynchronously'"
  (apply 'dbus-call-method-asynchronously
	 :session "com.emacsos.zero.Panel"
	 "/com/emacsos/zero/Panel"
	 "com.emacsos.zero.Panel"
	 method nil args))

;;============
;; public API
;;============

(defun zero-panel-move (x y)
  "move panel to specific position
(x, y) are coordinates, (0, 0) is at screen top left corner"
  (zero-panel-async-call "Move" nil :int32 x :int32 y))

(defun zero-panel-show-candidates (preedit_str candidate_length candidates)
  "show candidates"
  (zero-panel-async-call "ShowCandidates" nil
			 :string preedit_str
			 :int32 candidate_length
			 (or candidates '(:array))))

(defun zero-panel-show ()
  "show panel"
  (zero-panel-async-call "Show" nil))

(defun zero-panel-hide ()
  "hide panel"
  (zero-panel-async-call "Hide" nil))

(defun zero-panel-quit ()
  "quit panel application"
  (zero-panel-async-call "Quit" nil))

(provide 'zero-panel)
