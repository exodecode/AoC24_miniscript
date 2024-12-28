import "funcy"; import "stringUtil";
fmap=@funcy.fmap; C=@funcy.C;
zipWith=@funcy.zipWith; curry=@funcy.curry; transpose=@funcy.transpose;
subtract=@funcy.subtract; multiply=@funcy.multiply;

filePath = shellArgs[1]
if filePath then
commands = ["cat " + filePath, "sed 's/[[:blank:]]\{1,\}/ /g'"].join(" | ")
lines = (exec(commands).output).splitLines
lines = C(@fmap, @split).A(lines)
lines = C(@fmap, @C(@fmap, @val).unwrap).A(lines)
transposed = transpose(lines)

// PART A //
sorted = C(@fmap, @sort).A(transposed)
totalA = C(@fmap, @abs).A(zipWith(@subtract, sorted[0], sorted[1])).sum

print "Solution A: " + totalA
// ****** //

// PART B //
count = function(lst, n)
  counter=0
  for i in range(0, lst.len-1)
    if lst[i] == n then
      counter += 1
    end if
  end for
  return counter
end function

left=transposed[0]
right=transposed[1]
countNOnRight = @curry(@count, right)
occurences=fmap(@countNOnRight, left)
totalB=zipWith(@multiply, occurences, left).sum

print "Solution B: " + totalB
// ****** //
else
	print "Please provide a file path"
end if
