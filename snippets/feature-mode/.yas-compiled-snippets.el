;;; Compiled snippets and support files for `feature-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'feature-mode
                     '(("and" "And ${1:something else}\n$0\n" "And something else" nil nil
                        ((yas-indent-line 'fixed))
                        nil nil nil)
                       ("bac" "Background:\n  Given ${1: a known starting condition}\n  $0\n" "Background" nil nil
                        ((yas-indent-line 'fixed))
                        nil nil nil)
                       ("fea" "Feature: ${1:Name}\n  In order to ${2:get some business value}\n  ${3:Role} will need ${4:this sweet new feature}\n\n  $0\n" "Feature: Name" nil nil
                        ((yas-indent-line 'fixed))
                        nil nil nil)
                       ("giv" "Given ${1:a known starting condition}\n$0\n" "Given a known starting condition" nil nil
                        ((yas-indent-line 'fixed))
                        nil nil nil)
                       ("sce" "Scenario: ${1:Name}\n  $0\n" "Scenario: Name" nil nil
                        ((yas-indent-line 'fixed))
                        nil nil nil)
                       ("the" "Then ${1:some expected outcome}\n$0\n" "Then some expected outcome" nil nil
                        ((yas-indent-line 'fixed))
                        nil nil nil)
                       ("whe" "When ${1:some action}\n$0\n" "When some action" nil nil
                        ((yas-indent-line 'fixed))
                        nil nil nil)))


;;; Do not edit! File generated at Sun Oct 21 01:54:58 2012
