
# unify lines of files to guarantee no multiple connections
for i in ddb/*.csv ; do
  head -1 $i > bla
  tail -n +2 $i | sort | uniq >> bla
  mv bla $i
done

