syntax match Message /"message":"\zs\(\(\\\"\|[^"]\)*\)"/
syntax match Filename /"filename":"\zs[^"]\+/
syntax match LineNumber /"line_number":\zs[^,]\+/
syntax match Error /"level":"\zsERROR"/
syntax match Warn /"level":"\zsWARN"/

highlight Message guifg=#f9e2af
highlight Filename guifg=#89b4fa
highlight LineNumber guifg=#89b4fa
highlight Error guifg=#f38ba8
highlight Warn guifg=#fab387
