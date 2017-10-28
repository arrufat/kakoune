# http://clojure.org
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# require lisp.kak

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.](cljs?) %{
    set buffer filetype clojure
}

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/ group clojure

add-highlighter shared/clojure ref lisp

add-highlighter shared/clojure regex \b(clojure.core/['/\w]+)\b 0:keyword

# Commands
# ‾‾‾‾‾‾‾‾

def -hidden clojure-filter-around-selections lisp-filter-around-selections
def -hidden clojure-indent-on-new-line       lisp-indent-on-new-line

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾
hook -group clojure-highlight global WinSetOption filetype=clojure %{ add-highlighter window ref clojure }

hook global WinSetOption filetype=clojure %[
    hook window InsertEnd  .* -group clojure-hooks  clojure-filter-around-selections
    hook window InsertChar \n -group clojure-indent clojure-indent-on-new-line
]

hook -group clojure-highlight global WinSetOption filetype=(?!clojure).* %{ remove-highlighter window/clojure }

hook global WinSetOption filetype=(?!clojure).* %{
    remove-hooks window clojure-indent
    remove-hooks window clojure-hooks
}
