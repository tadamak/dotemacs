;;; Compiled snippets and support files for `rhtml-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'rhtml-mode
                     '(("%" "<%$0 %>\n" "<%$. %>" nil nil nil nil nil nil)
                       ("%%" "<%=$0 %>\n" "<%=$. %>" nil nil nil nil nil nil)
                       ("%ff" "<% form_for(${object}) do |f| %>\n$0\n<% end %>\n" "<% form_for(@user) do |f| %> ... <% end  %>" nil nil nil nil nil nil)
                       ("%ff.url" "<% form_for(${object}, :url => ${path}) do |f| %>\n$0\n<% end %>\n" "<% form_for(@user, :url => user_path) do |f| %> ... <% end  %>" nil nil nil nil nil nil)
                       ("%ff.url_method" "<% form_for(${object}, :url => ${path}, :html => {:method => :${method}}) do |f| %>\n$0\n<% end %>\n" "<% form_for(@user, :url => user_path, :html => {:method => :post}) do |f| %> ... <% end  %>" nil nil nil nil nil nil)
                       ("%ft" "<% form_tag(:action => \"${update}\") do %>\n$0\n<% end %>\n" "<% form_tag(:action => \" ... \") do %> ... <% end  %>" nil nil nil nil nil nil)
                       ("%if" "<% if ${cond} -%>\n$0\n<% end -%>\n" "<% if  ...  -%> $. <% end -%>" nil nil nil nil nil nil)
                       ("%ifel" "<% if ${cond} -%>\n$0\n<% else -%>\n<% end -%>\n" "<% if  ...  -%> $. <% else -%> <% end -%>" nil nil nil nil nil nil)
                       ("%li" "<%= link_to \"${title}\", ${path} %>$0" "<%= link_to \" ... \", \" ... \" %>" nil nil nil nil nil nil)
                       ("%rp" "<%= render(:partial => \"${action}\"$0 ) %>" "<%= render(:partial => ... ) %>" nil nil nil nil nil nil)
                       ("%s" "<%= submit_tag \"${string}\" %>\n$0\n\n" "<%= submit_tag \"送信\" %>" nil nil nil nil nil nil)
                       ("%ta" "<%= f.text_area(:${column}) %>$0\n" "<%= f.text_area(\" ... \", \" ... \") %>" nil nil nil nil nil nil)
                       ("%tf" "<%= f.text_field(:${column}) %>$0" "<%= f.text_field(\" ... \", \" ... \") %>" nil nil nil nil nil nil)
                       ("%unless" "<% unless ${cond} -%>\n$0\n<% end -%>\n" "<% unless  ...  -%> $. <% end -%>" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Sun Oct 21 01:54:58 2012
