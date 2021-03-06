;;; fns-tests.el --- tests for src/fns.c

;; Copyright (C) 2014 Free Software Foundation, Inc.

;; This file is part of GNU Emacs.

;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see `http://www.gnu.org/licenses/'.

;;; Commentary:

;;; Code:

(require 'cl-lib)
(eval-when-compile (require 'cl))

(ert-deftest fns-tests-reverse ()
  (should-error (reverse))
  (should-error (reverse 1))
  (should-error (reverse (make-char-table 'foo)))
  (should (equal [] (reverse [])))
  (should (equal [0] (reverse [0])))
  (should (equal [1 2 3 4] (reverse (reverse [1 2 3 4]))))
  (should (equal '(a b c d) (reverse (reverse '(a b c d)))))
  (should (equal "xyzzy" (reverse (reverse "xyzzy"))))
  (should (equal "こんにちは / ｺﾝﾆﾁﾊ" (reverse (reverse "こんにちは / ｺﾝﾆﾁﾊ")))))

(ert-deftest fns-tests-nreverse ()
  (should-error (nreverse))
  (should-error (nreverse 1))
  (should-error (nreverse (make-char-table 'foo)))
  (should (equal (nreverse "xyzzy") "yzzyx"))
  (let ((A []))
    (nreverse A)
    (should (equal A [])))
  (let ((A [0]))
    (nreverse A)
    (should (equal A [0])))
  (let ((A [1 2 3 4]))
    (nreverse A)
    (should (equal A [4 3 2 1])))
  (let ((A [1 2 3 4]))
    (nreverse A)
    (nreverse A)
    (should (equal A [1 2 3 4])))
  (let* ((A [1 2 3 4])
	 (B (nreverse (nreverse A))))
    (should (equal A B))))

(ert-deftest fns-tests-reverse-bool-vector ()
  (let ((A (make-bool-vector 10 nil)))
    (dotimes (i 5) (aset A i t))
    (should (equal [nil nil nil nil nil t t t t t] (vconcat (reverse A))))
    (should (equal A (reverse (reverse A))))))

(ert-deftest fns-tests-nreverse-bool-vector ()
  (let ((A (make-bool-vector 10 nil)))
    (dotimes (i 5) (aset A i t))
    (nreverse A)
    (should (equal [nil nil nil nil nil t t t t t] (vconcat A)))
    (should (equal [t t t t t nil nil nil nil nil] (vconcat (nreverse A))))))
