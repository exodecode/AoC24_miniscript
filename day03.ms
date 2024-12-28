import "funcy"; import "stringUtil";
fmap=@funcy.fmap; filter=@funcy.filter;
C=@funcy.C; B=@funcy.B;
isEven=@funcy.isEven; isOdd=@funcy.isOdd;
zip=@funcy.zip; zipWith=@funcy.zipWith;
multiply=@funcy.multiply;
fst=@funcy.fst; snd=@funcy.snd;

filePath = shellArgs[1]
lines = []

// :example of expected output for commands:
// function params should be on separate lines
// in: "[][][][mul(2,3)xyzmul(5,5)123mul(4,2)"
// out: "2\n3\n5\n5\n4\n2\n"
process = function(commands)
  lines = exec(commands).output.splitLines
  lines = fmap(@val, lines)
  lines = zip(lines, range(0, lines.len))

  evens = C(@fmap, @fst).A(C(@filter, @B(@isEven, @snd).unwrap).A(lines))
  odds = C(@fmap, @fst).A(C(@filter, @B(@isOdd, @snd).unwrap).A(lines))
  res = zipWith(@multiply, evens, odds).sum
  return res
end function


if filePath then
// Part A //
	commandsA = [
		"cat " + filePath,
		"grep -Po 'mul\([0-9]{1,3},[0-9]{1,3}\)'",
		"sed ':a;N;$!ba;s/\n//g'",
		"sed 's/)/),/g'",
		"sed 's/,$//g'",
		"sed 's/[^0-9,]//g'",
		"sed 's/,/\n/g'"].join(" | ")

    res = process(commandsA)
    print "Solution A: " + res
// ****** //

// Part B //
	commandsB = [
		"cat " + filePath,
		"grep -Po 'mul\([0-9]{1,3},[0-9]{1,3}\)|don'\''t\(\)|do\(\)'",
		"sed ':a;N;$!ba;s/\n//g'",
		"sed 's/do()/\n/g'",
		"sed 's/don'\''t().*//g'",
		"sed ':a;N;$!ba;s/\n//g'",
		"sed 's/)/),/g'",
		"sed ':a;N;$!ba;s/\n$//'",
		"sed 's/,$//g'",
		"sed 's/[^0-9,]//g'",
		"sed 's/,/\n/g'"].join(" | ")

    res = process(commandsB)
    print "Solution B: " + res
// ****** //
else
  print "Please provide a file path"
end if
