import "funcy"; fmap=@funcy.fmap; filter=@funcy.filter;
head=@funcy.head; last=@funcy.last;
reverse=@funcy.reverse; inRange=@funcy.inRange;
deltas=@funcy.deltas; stalinSort=@funcy.stalinSort;
negative=@funcy.negative; positive=@funcy.positive; all=@funcy.all;

filePath = shellArgs[1]

fileTextLines = []

if filePath then
  fileTextLines = file.readLines(filePath)
else
  print "Please provide a relative file path"
end if

processA = function(str)
  words = str.split
  vals = fmap(@val, words)
  dt = deltas(vals)
  n = all(@negative, dt)
  p = all(@positive, dt)
  dtAbs = fmap(@abs, dt)
  r = all(@inRange(1, 3), dtAbs)
  return (n or p) and r
end function

print "Day 02, Part A: " + fmap(@processA, fileTextLines).sum

processB = function(str)
  words = str.split
  ns = fmap(@val, words)
  if head(ns) > last(ns) then; ns = reverse(ns); end if

  ns = stalinSort(ns)
  ns = deltas(ns)
  ns = filter(@inRange(1, 3), ns)
  
  return ns.len == words.len - 1 or ns.len == words.len - 2
end function

print "Day 02, Part B: " + fmap(@processB, fileTextLines).sum
