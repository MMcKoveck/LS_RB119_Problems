#### Problem 1

Create a method that takes an array of numbers as an argument. For each number, determine how many numbers in the array are smaller than it, and place the answer in an array. Return the resulting array.

When counting numbers, only count unique values. That is, if a number occurs multiple times in the array, it should only be counted once.

Examples


p smaller_numbers_tha
n_current([8, 1, 2, 2, 3]) == [3, 0, 1, 1, 2]
p smaller_numbers_than_current([7, 7, 7, 7]) == [0, 0, 0, 0]
p smaller_numbers_than_current([6, 5, 4, 8]) == [2, 1, 0, 3]
p smaller_numbers_than_current([1]) == [0]

my_array = [1, 4, 6, 8, 13, 2, 4, 5, 4]
result   = [0, 2, 4, 5, 6, 1, 2, 3, 2]
p smaller_numbers_than_current(my_array) == result


check against a unique array, counting how many elements are less than current number
map it to return the right number of elements


01 def smaller_numbers_than_current(array)
02   array.map {|num1| array.uniq.count {|num2| num1 > num2 }}
03 end

Line `01` the method is defined with one parameter
Line `02` The `map` method is called on the input `array` with a block with a single parameter `num1`.
   Every array element will in turn be bound to that parameter in turn, and eventually an array representing the block's' return value for each array element will be returned.
   Within that block, the input `array` is again called with two chained methods and a block. The `uniq` method is first called on that array to pare the array down to the unique elements in the array. Then the `count` method is called which will return the number of times the passed block returns a `truthy` value. The block in question has a single parameter, `num2` which will be bound to each unique array element in turn. Within the body of the block, there is a comparison between the current value of `num1`, which is the current input `array` element, and `num2` which in turn represents each unique element of the input `array` using the greater than `>` comparison operator.
   Each time the first array element is larger than each unique array element the count increases and these counts are returned as array elements in the intitial `map` call.
Line `03` ends the method definition

#### Problem 2

Create a method that takes an array of integers as an argument. 
The method should return the minimum sum of 5 consecutive numbers in the array.
If the array contains fewer than 5 elements, the method should return `nil`.

Examples


p minimum_sum([1, 2, 3, 4]) == nil
p minimum_sum([1, 2, 3, 4, 5, -5]) == 9
p minimum_sum([1, 2, 3, 4, 5, 6]) == 15
p minimum_sum([55, 2, 6, 5, 1, 2, 9, 3, 5, 100]) == 16
p minimum_sum([-1, -5, -3, 0, -1, 2, -4]) == -10


Find all 5 element substrings
sum them all
return the minimum


01 def minimum_sum(array)
02   substrings = []
03   (0..(array.size)).each do |starting_index|
04     (starting_index...(array.size)).each do |ending_index|
05       substrings << array[starting_index..ending_index]
06     end
07   end
08   substrings.select! {|sub| sub.size == 5}
09   substrings.map {|sub| sub.sum}.min
10 end

Line `01` defines the method with one parameter `array`
Line `02` `substrings` is initialized to the value of an empty array using `=` and `[]`.
Line `03` an inclusive range `..` is created from `0` up to and including the value of `array.size`. 
   The `each` method is called on that range with a `do..end` block with a parameter `starting_index`.
   Each integer starting at `0` up until the `size` of the input `array` will be bound in turn to the `starting_index` parameter. 
Line `04` within the block begun on line `03` starts with an exclusive range `...` from the current value
   of block variable `starting_index` up to but not including the value of `array.size`. This is like `(value - 1)` but `prettier <3`for the end of an inclusive range.  This range has the `each` method called on it with another `do..end` block with the parameter `ending_index`.
Line `05` the method variable `array` is `slice`d via the direct access method `[]`. Within those square     brackets, an inclusive range beginning with the array index at the value of `starting_index`, up to
   and including array index at the value of `ending_index`. Those array elements are pushed to the array represented by method variable `substrings` using the shovel operator `<<`. This creates substrings starting at index `0` and incrementing higher until it reaches the full length. Then it starts with the next index, `1`, making substrings incrementally larger until reaching the end. This goes until it starts and ends with the last element.  
   if `array` were to have the value `[1, 2, 3, 4]`, the `substrings` would be :
   `[[1], [1, 2], [1, 2, 3], [1, 2, 3, 4], [2], [2, 3], [2, 3, 4], [3], [3, 4], [4]]`
Line `06` ends the block from `Line 04`
Line `07` ends the block from `Line 03`
Line `08` the mutating method `select!` is called on the `substrings` array with a block that has the
   parameter `sub`. Within the block, any `sub` array element of subarrays with `5` array elements will be returned. This comparison is found by checking to see if the value of the `size` method called on block variable `sub` evaluates to the value of integer `5` using the `==` operator. The mutating nature of this `select!` method changes the value of the `substrings` array to include only those substrings that have `5` elements. If there are no substrings with 5 elements, an empty array will be returned.
Line `09` the `map` method is called on the `substrings` array with a block and a parameter `sub`.
   Within the block, the `sub` substring elements are added together using the `sum` method. Instead of returning a new array containing the transformed values of each sub array's' sum, the `min` method is called on the block, returning only the minimum value possibly returned by the block. In the case of an empty array, `nil` is returned.

#### Problem 3

Create a method that takes a string argument and returns a copy of the string with every second character in every third word converted to uppercase. Other characters should remain the same.

Examples


original = 'Lorem Ipsum is simply dummy text of the printing world'
expected = 'Lorem Ipsum iS simply dummy tExT of the pRiNtInG world'
p to_weird_case(original) == expected

original = 'It is a long established fact that a reader will be distracted'
expected = 'It is a long established fAcT that a rEaDeR will be dIsTrAcTeD'
p to_weird_case(original) == expected

p to_weird_case('aaA bB c') == 'aaA bB c'

original = "Mary Poppins' favorite word is supercalifragilisticexpialidocious"
expected = "Mary Poppins' fAvOrItE word is sUpErCaLiFrAgIlIsTiCeXpIaLiDoCiOuS"
p to_weird_case(original) == expected


Iterate over string find every third word
iterate over found word, find every second char, 
upcase that char
what to mutate, and how to access?
Maybe string to array, |ele| every 3rd |ele|[2].upcase!
rejoin array(' ')

maybe loop (size times?) with a counter
push array element and += counter unless counter == 3
  push |ele|[2].upcase (can't' just push that char, have to transform the element)
  reset counter to 0
  rejoin array(' ')


def to_weird_case(string)
  result = []
  array = string.split
  counter = 0
  until array.empty? do 
    if counter <= 1
      result << array.shift
      counter += 1
    else 
      holder = array.shift.chars
      holder.map!.with_index do |char, idx|
        if !(idx % 2 == 0)
          char.upcase
        else
          char
        end
      end  
      result << holder.join('')
      counter = 0
    end
  end  
  result.join(' ')
end

Ugh. That's' UGLY.
Try using `step`! 
step 3 and then step 2 
maybe I can create 2 arrays of needed indices to check against?
[2, 5, 8] and then [1, 3, 5, 7] # Don't need the second array because it's just odds.

def to_weird_case(string)
  array = string.split
  indices = 2.step(string.split.size, 3).to_a
  array.map!.with_index do |word, index|
    if indices.include?(index)
      word.chars.map!.with_index do |char, idx|
        idx.odd? ? char.upcase : char
      end.join('')
    else
      word
    end
  end
  array.join(' ')
end

This is much nicer. I didn't' need 2 index arrays, 
so nesting and accessing them didn't' need to happen.(watch your extra square brackets!) 
`step` is an interesting method. 
It is not an iterator per se, 
but it starts with the number value of the caller 
and in the argument you can either pass a single value, 
which it will increment up to and including. 
Passing a block with a parameter, 
it executes the block for each 'step' and assigns the current value to the parameter. 
You can also initially pass two values separated by a comma, 
the first value being the ending argument as with a single, 
and the second being the size of the increments or 'steps'. 
It returns the caller so:

irb(main):217:0> 3.step(9, 4){|x| p x}
3
7
=> 3

So I `map!`ped the `array` into `word`s `with_index`es. 
If the `index` was `include?`d in the `indices` array, 
I further `map!`ped the `word` into a `chars` array `with_index`. 
Then, using a ternary expression, I checked if the `idx` was `odd?` and if so, 
returned the bound `char` as an `upcase` version of itself, 
otherwise I returned the `char` itself.
 All those `char`s were then `join` ed with no spaces `('')` 
 back into the original (more or less) `word`. 
 Otherwise, I just returned the unchanged `word`. 
 Finally I `join`ed the `array` back into a spaced string `(' ')` which was implicitly returned.
#### Problem 4

Create a method that takes an array of integers as an argument 
and returns an array of two numbers that are closest together in value. 
If there are multiple pairs that are equally close, 
return the pair that occurs first in the array.

Examples


p closest_numbers([5, 25, 15, 11, 20]) == [15, 11]
p closest_numbers([19, 25, 32, 4, 27, 16]) == [25, 27]
p closest_numbers([12, 22, 7, 17]) == [12, 7]

create 2 element sub arrays [ [5, 25], [5, 15], [5, 15], [5, 11], [5, 20], [25, 15], [25, 11], [25, 20], [15, 11], [15, 20], [11, 20] ]
select find minimum absolute value of difference, return that array

def closest_numbers(array)
  sub_arrays = []
  array.size.each do |start_index|
    array.size.each do |end_index|
      sub_arrays << [array[start_index], array[end_index]]
    end
  end
  sub_arrays.reject! {|a, b| a == b}
  differences = sub_arrays.map {|sub| (sub[0] - sub[1]).abs}
  sub_arrays[differences.index(differences.min)]
end  


#### Problem 5

Create a method that takes a string argument and returns 
the character that occurs most often in the string. 
If there are multiple characters with the same greatest frequency, 
return the one that appears first in the string. 
When counting characters, consider uppercase and lowercase versions to be the same.

Examples


p most_common_char('Hello World') == 'l'
p most_common_char('Mississippi') == 'i'
p most_common_char('Happy birthday!') == 'h'
p most_common_char('aaaaaAAAA') == 'a'

my_str = 'Peter Piper picked a peck of pickled peppers.'
p most_common_char(my_str) == 'p'

my_str = 'Peter Piper repicked a peck of repickled peppers. He did!'
p most_common_char(my_str) == 'e'


input string 
output character (lowercase)
maybe make a lower case occurence hash, and return the highest valued key


def most_common_char(string)
  hash = Hash.new(0)
  array = string.downcase.chars
  array.each {|char| hash[char] += 1}
  hash.max_by {|_k, v| v}[0]
end

the `v` is sorting by value, finding the maximum to `sort_by` and returning that kvp.
the `[0]` is there because `max_by` is returning a 2 element array of the KVP. 
I am accessing the 1st element of that directly

#### Problem 6

Create a method that takes a string argument and returns a hash in which 
the keys represent the lowercase letters in the string, 
and the values represent how often the corresponding letter occurs in the string.

Examples


expected = {'w' => 1, 'o' => 2, 'e' => 3, 'b' => 1, 'g' => 1, 'n' => 1}
p count_letters('woebegone') == expected

expected = {'l' => 1, 'o' => 1, 'w' => 1, 'e' => 4, 'r' => 2,
            'c' => 2, 'a' => 2, 's' => 2, 'u' => 1, 'p' => 2}
p count_letters('lowercase/uppercase') == expected

expected = {'u' => 1, 'o' => 1, 'i' => 1, 's' => 1}
p count_letters('W. E. B. Du Bois') == expected

p count_letters('x') == {'x' => 1}
p count_letters('') == {}
p count_letters('!!!') == {}

input string
output hash 
need an alphabet array to check against


def count_letters(string)
  alplabet = ('a'..'z').to_a
  array = string.chars
  hash = Hash.new(0)
  array.each { |char| hash[char] += 1 if alphabet.include?(char) }
  hash
end


#### Problem 7

Create a method that takes an array of integers as an argument and 
returns the number of identical pairs of integers in that array. 
For instance, the number of identical pairs in `[1, 2, 3, 2, 1]` is 2:
 there are two occurrences each of both `2` and `1`.

If the array is empty or contains exactly one value, return 0.

If a certain number occurs more than twice, count each complete pair once. 
For instance, for `[1, 1, 1, 1]` and `[2, 2, 2, 2, 2]`, the method should return 2. 
The first array contains two complete pairs while the second has 
an extra `2` that isn't' part of the other two pairs.

Examples


p pairs([3, 1, 4, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7]) == 3
p pairs([2, 7, 1, 8, 2, 8, 1, 8, 2, 8, 4]) == 4
p pairs([]) == 0
p pairs([23]) == 0
p pairs([997, 997]) == 1
p pairs([32, 32, 32]) == 1
p pairs([7, 7, 7, 7, 7, 7, 7]) == 3

for each unique element in the array, divide the count by 2, add that result to a tally variable

def pairs(array)
  array.uniq.map {|num| array.count(num) / 2 }.sum
end


understanding,
algorithm
implementation

# Write a function called longestConsecutiveAscendingWords that takes a sentence as input and finds all consecutive word where the succeeding word is longer than the previous. -- Michael

  

# Test cases

puts longest_consecutive_ascending_words("The quick brown fox jumps over the lazy dog").inspect # [ 'The', 'quick' ]

puts longest_consecutive_ascending_words("A journey of a thousand miles begins with a single step").inspect # [ 'A', 'journey' ]

puts longest_consecutive_ascending_words("Easy come easy go").inspect # [ 'Easy' ]

puts longest_consecutive_ascending_words("A tiny bird flew over the peaceful countryside").inspect # [ 'the', 'peaceful', 'countryside' ]

Problem 
Find the longest group of words with ascending lengths, 
Examples
  all the same the string is just 4
  use the last one, 1, 4,4,4,4,3, 8, 10 => 3,8,10 (1,4 was first but it got changed)
Data structures
  String 
  Array of string elements
Algorithm
  Split string into array of strings
  create 2 holder variables
    longest array of strings
     current array of strings
  Rules examine current string length
   add the first string element to begin comparison
     compare next element length
     if bigger, add to current array
     if smaller, check current array size with longest array size, make longest longest
   put current string into current array (reassign to start over)
   make sure you go through the whole input string and make sure longest is longest
   return the longest g.o.w. w.a.l.
Code

def longest_consecutive_ascending_words(string)
  input_array = string.split
  longest_array = []
  working_array = []
  working_array << input_array.shift
  until input_array.empty? do
    if working_array[-1].length < input_array[0].length
      working_array << input_array.shift
    else
      if working_array.size > longest_array.size
        longest_array = working_array
        working_array = []
        working_array << input_array.shift
      else
        working_array = [input_array.shift]
      end
    end
  end
  if working_array.size > longest_array.size
    longest_array = working_array
  end
  longest_array
end


#### Problem 8
Create a method that takes a non-empty string as an argument. The string consists entirely of lowercase alphabetic characters. The method should return the length of the longest vowel substring. The vowels of interest are "a", "e", "i", "o", and "u".

ExamplesCopy Code

p longest_vowel_substring('cwm') == 0
p longest_vowel_substring('many') == 1
p longest_vowel_substring('launchschoolstudents') == 2
p longest_vowel_substring('eau') == 3
p longest_vowel_substring('beauteous') == 3
p longest_vowel_substring('sequoia') == 4
p longest_vowel_substring('miaoued') == 5
The above tests should each print true.

P   Find all substrings, return the length of the longest one that is only vowels
E   'bb' => 0, 'bob' => 1, 'boob' => 2, 'booboo' => 2, 'booboooboo' => 3
D   INput: string
    OUTput: Integer
A    define method with one argument
    Create list of vowels
     create empty substrings array
     create only vowels array with an empty string to guard against 0
     find all substrings
     filter substring array to vowels only
     return the size of the highest vowel only substring
C

def longest_vowel_substring(string)
  vowels = %w(a e i o u)
  substrings = []
  only_vowels = ['']
  (0..string.length).each do |start_index|
    (start_index...string.length).each do |end_index|
      substrings << string[start_index..end_index]
    end
  end  

  substrings.each do |sub|
    if sub.chars.all? {|letter| vowels.include?(letter)}
      only_vowels << sub
    end
  end
  only_vowels.max_by{|ele| ele.length}.length
end


#### Problem 9
Create a method that takes two string arguments and returns 
the number of times that the second string occurs in the first string. 
Note that overlapping strings don't' count: 'babab' contains 1 instance of 'bab', not 2.

You may assume that the second argument is never an empty string.

p count_substrings('babab', 'bab') == 1
p count_substrings('babab', 'ba') == 2
p count_substrings('babab', 'b') == 3
p count_substrings('babab', 'x') == 0
p count_substrings('babab', 'x') == 0
p count_substrings('', 'x') == 0
p count_substrings('bbbaabbbbaab', 'baab') == 2
p count_substrings('bbbaabbbbaab', 'bbaab') == 2
p count_substrings('bbbaabbbbaabb', 'bbbaabb') == 1

Use `gsub` changing string 2 into `*` and then return count of those

def count_substrings(string1, string2)
    string1.gsub(string2, '*').count('*')
end


#### Problem 10
Create a method that takes a string of digits as an argument and 
returns the number of even-numbered substrings that can be formed. 
For example, in the case of '1432', 
the even-numbered substrings are '14', '1432', '4', '432', '32', 
and '2', for a total of 6 substrings.

If a substring occurs more than once, 
you should count each occurrence as a separate substring.

ExamplesCopy Code
p even_substrings('1432') == 6
p even_substrings('3145926') == 16
p even_substrings('2718281') == 16
p even_substrings('13579') == 0
p even_substrings('143232') == 12
The above tests should each print true.

P find count of all substrings that % 2 == 0
E see above
D      input : number string
    output : integer count of all even strings
    intermediate : array of substrings
A  Define method with one string argument
    create empty sub array 
     make all sub arrays
     count all even elements (convert to I in check)
 C
 
def even_substrings(string)
  sub_arrays = []
  (0..string.length).each do |start_index|
    (start_index...string.length).each do |end_index|
      sub_arrays << string[start_index..end_index]
    end
  end
  sub_arrays.count {|sub| sub.to_i % 2 == 0}
end

`Line 1` begins the method definition with a single argument `string`.
`Line 2` method variable `sub_arrays` is initialized `=` to the value of an empty array `[]`.
`Line 3` An inclusive range `..` between `0` up to and including the value of `string.length`, surrounded by parentheses has the `each` method called on it. A `do end` block is passed to that method with a single parameter `start_index`. Each value in the range is bound in turn to the block variable `start_index`. Within the block, another range is presented within parentheses, this time it is exclusive, with `...` beginning with the current value of `start_index` up to but not including the value of `string.length`. The `each` method is again called on that range with another `do end` block with the parameter `end_index`. 
Within this block, starting on `Line 5` method variable `string` is directly referenced using square brackets, and a range of the string elements are created with a changing inclusive range beginning with the current value of `start_index` up to and including the value of `end_index`. These slices of the original `string` value are pushed into the `sub_arrays` array. 
`Line 6` ends the inner block. `Line 7` ends the outer block.
`Line 8` the `sub_arrays` method has the `count` method called upon it with a block indicated by curly braces, rather than the `do end` keywords. It has a single parameter, `sub`, representing each array element in `sub_arrays` in turn. Within the block, the `to_i` method is called on the current value  of the block parameter. That numerical value is modulo `%``2` is compared to the value of `0` using `==`. This will return a truthy value and therefore increase the final `count` return value for each instance of an even sub array. This is the final evaluation of the method and the implicit return value.

#### Problem 11
Create a method that takes a nonempty string as an argument and 
returns an array consisting of a string and an integer. 
If we call the string argument s, the string component of the returned array t, 
and the integer component of the returned array k, then s, t, and k must 
be related to each other such that s == t * k. 
The values of t and k should be the shortest possible substring and 
the largest possible repeat count that satisfies this equation.

You may assume that the string argument consists entirely of lowercase alphabetic letters.

p repeated_substring('xyzxyzxyz') == ['xyz', 3]
p repeated_substring('xyxy') == ['xy', 2]
p repeated_substring('xyz') == ['xyz', 1]
p repeated_substring('aaaaaaaa') == ['a', 8]
p repeated_substring('superduper') == ['superduper', 1]
The above tests should each print true.

p repeated_substring('xyxyxyxy') == ['xy', 4]
p repeated_substring('xyxyxyxyxyxyxyxy') == ['xy', 8]
p repeated_substring('xyxyxyxyxyxyxyxyz') == ['xyxyxyxyxyxyxyxyz', 1]

P Return a 2 element array with the shortest substring and the highest number of its iterations
E see line 8 'xy', 'xyxy', 'xyxyxyxy'
D Input : 1 string
   Output : (See: P)
   Intermediate : arrays
Find half down substrings, Find minimum length that == input
   maybe min count of substrings
   ex 3 and 5 would be excluded so find all substrings
     so select all the substrings that balance out
     select the shortest, 
     divide the input length by the shortest's' length
     select substring if input length % substring length == 0
       that can select right length but wrong characters
       string length / sub length = current num
       current num * sub  == input string?
       (I can combine values and use their returns to minimize the code)
   or maybe still only do half the substrings but use a guard clause so if nothing fits the bill, 
     it's' [input string and 1].
  Woah, what if I just start moving string elements over until that new string times a number 
     is == the input string? 
     That'll' keep it minimum substring length
     Try using that code minimizing to generate the number
A   define method with single string argument
     duplicate input string to working variable [array of characters]
     create empty holder string variable
     loop up to string length times (lots of ways to do this, or just use first break)
       shift first array element to holder string
       break if (input string length / holder string length) * holder string == input string ?
       can't' just use break unless I add another break
         maybe I can because once it's' all over ( 1 / 1 )* 1 == 1
     just call array of holder string and (input string length / holder string length)
C

def repeated_substring(string)
  characters = string.chars
  working_string = ''
  loop do
    working_string << characters.shift
    break if working_string * 
      (string.length / working_string.length) == string   
  end
  [working_string, (string.length / working_string.length)]
end


#### Problem 12
Create a method that takes a string as an argument and 
returns true if the string is a pangram, false if it is not.

Pangrams are sentences that contain every letter of the alphabet at least once. 
For example, the sentence "Five quacking zephyrs jolt my wax bed." 
is a pangram since it uses every letter at least once. 
Note that case is irrelevant.

p is_pangram('The quick, brown fox jumps over the lazy god!') == true
p is_pangram('The slow, brown fox jumps over the lazy dog!') == false
p is_pangram("A wizard’s job is to vex chumps quickly in fog.") == true
p is_pangram("A wizard’s task is to vex chumps quickly in fog.") == false
p is_pangram("A wizard’s job is to vex chumps quickly in golf.") == true

fnord = 'SPHINX OF BLACK QUARTZ, JUDGE MY VOW!'
my_str = 'Sixty zippers were quickly picked from the woven jute bag.'
p is_pangram(my_str) == true
p is_pangram(fnord) == true

P Return a boolean if the provided string contains every letter of the alphabet at least once. 
E 'SPHINX OF BLACK QUARTZ, JUDGE MY VOW!'
D  Input : string
   Output : boolean
   Intermediate arrays
     maybe a tally hash for comparison?
A  Define method with one argument
    Create alphabet array
     break string into array of downcase characters
     check if all of the alphabet array elements are in the broken array
     implicitly returns boolean
C

def is_pangram(string)
  alphabet = ('a'..'z').to_a
  character_array = string.downcase.chars
  alphabet.all?{|char| character_array.include?(char)}
end


#### Problem 13
Create a method that takes two strings as arguments and returns true if 
some portion of the characters in the first string can be rearranged to
 match the characters in the second. Otherwise, the method should return false.

You may assume that both string arguments only contain lowercase alphabetic characters.
 Neither string will be empty.
 
 ExamplesCopy Code
p unscramble('ansucchlohlo', 'launchschool') == true
p unscramble('ansucchlohlo', 'launchschooll') == false
p unscramble('phyarunstole', 'pythonrules') == true
p unscramble('phyarunstola', 'pythonrules') == false
p unscramble('boldface', 'coal') == true
The above tests should each print true.

'phyarunstola', 'pythonrules'

Ostensibly this checks if all of the 2nd element chars are present in the 1st, returns boolean
But what if the count were different? What if it were 'ansucchlohlo' and 'launchschooll'
what if I remove like elements? but to what end.
  check each char of 2nd string (shift to remove)
  if it doesn't' exist in 1st, return false
  if it does, replace (only!) it with empty string char ''
  if the whole second string is gone, it's' true
A define method with 2 arguments
   dup string1
   initialize a string2 array (doesn't' need to be downcased or anything)
   loop until string2 array is empty
   force return false if shifted array element is not in string1 (shift to variable?)
   otherwise, replace that value in string1 with '' 
   call true
   end method
C

def unscramble(str1, str2)
  main_string = str1.dup
  check_array = str2.chars
  until check_array.empty?
    check_char = check_array.shift
    if main_string.include?(check_char)
      main_string.sub!(check_char, '')
    else
      return false
    end
  end
  true    
end


#### Problem 14
Create a method that takes a single integer argument and returns 
the sum of all the multiples of 7 or 11 that are less than the argument. 
If a number is a multiple of both 7 and 11, count it just once.

For example, the multiples of 7 and 11 that are below 25 are 7, 11, 14, 21, and 22. 
The sum of these multiples is 75.

If the argument is negative, return 0.

ExamplesCopy Code
p seven_eleven(10) == 7
p seven_eleven(11) == 7
p seven_eleven(12) == 18
p seven_eleven(25) == 75
p seven_eleven(100) == 1153
p seven_eleven(0) == 0
p seven_eleven(-100) == 0
The above tests should each print true.

Less than the argument is important. Can use an exclusive range for numbers to work on.
find any numbers that are mod 7 or mod 11 and sum them 
if mod both, only count it once, so if pushing results to an array, make sure they're' unique.
if argument <= 0 return 0 (anything up to and including 7, actually) (free up computing?)
D input : integer (up to but not including)
   output : integer (sum of unique multiples of 7 & 11)
   intermediate : range, holder array 
A  define method with one argument
     guard clause, return 0 if argument <= 7
    create holder array
     make an exclusive range from 7...input
         check if each is mod 7 or mod 11
         if so, add it to holder array
    sum  holder array (I might be able to chain all this and dispense with the holder)
C

def seven_eleven(number)
  return 0 if number <= 7
  multiples = []
  (7...number).each do |num|
  multiples << num if num % 7 == 0 || num % 11 == 0
  end
  multiples.sum
end

def seven_eleven(number)
  return 0 if number <= 7
  (7...number).select {|num| num if num % 7 == 0 || num % 11 == 0}.sum
end


#### Problem 15
Create a method that takes a string argument that consists entirely of numeric digits 
and computes the greatest product of four consecutive digits in the string. 
The argument will always have more than 4 digits.

ExamplesCopy Code
p greatest_product('23456') == 360      # 3 * 4 * 5 * 6
p greatest_product('234567') == 840     # 4 * 5 * 6 * 7
p greatest_product('3145926') == 540    # 5 * 9 * 2 * 6
p greatest_product('1828172') == 128    # 1 * 8 * 2 * 8
p greatest_product('123987654') == 3024 # 9 * 8 * 7 * 6
The above tests should each print true.

P get all 4 digit substrings and return the largest product of the digits
E see above 2345, 3456 / 2345, 3456, 4567 / 3145, 1459, 4592, 5926
    string length - 4 == leftover digits 
     leftover digits + 1 == how many slices to make
     there are no ZEROs (is that an issue?) sort/reverse to deal with but not necessary I think.
     nothing shorter than 4 digits
D input : number string
   output : integer (maximum sum of 4 consecutive digits)
   intermediate : digits array for functions
A define method with one numeric string argument
    create array for slices
     slice input string leftover digits + 1 times 
     inc range, 0..leftover digits for starting element, 4 characters long.
     convert to integer and individual digits
     multiply each 
     return maximum
     maybe can all be chained
C

def greatest_product(number)
  slices = []
  (0..(number.length - 4)).select do |index|
    slices << number.slice(index, 4)
  end
  slices.map {|sub| sub.to_i.digits.inject(:*)}.max
end


#### Problem 16
Create a method that returns the count of distinct case-insensitive 
alphabetic characters and numeric digits that occur more than once in the input string. 
You may assume that the input string contains only alphanumeric characters.

ExamplesCopy Code
p distinct_multiples('xyz') == 0               # (none
p distinct_multiples('xxyypzzr') == 3          # x, y, z
p distinct_multiples('xXyYpzZr') == 3          # x, y, z
p distinct_multiples('unununium') == 2         # u, n
p distinct_multiples('multiplicity') == 3      # l, t, i
p distinct_multiples('7657') == 1              # 7
p distinct_multiples('3141592653589793') == 4  # 3, 1, 5, 9
p distinct_multiples('2718281828459045') == 5  # 2, 1, 8, 4, 5
The above tests should each print true.

P return a count of all the case insensitive letters/numbers that occur more than once
E see above nothing hinky
D input : string
   output : integer (P)
   intermediate : hash to tally
A define method with one string argument
     initialize a counter to 0 (necessary?)
    split input string into characters and tally that array to get counts
     anything with a value > 1 add to count 
         maybe just count that instead of adding to counter
    return count
C

def distinct_multiples(string)
  letters_hash = string.downcase.chars.tally
  letters_hash.count {|_, v| v > 1}
end
# DON'T NEED TO INITIALIZE A VARIABLE
def distinct_multiples(string)
  string.downcase.chars.tally.count {|_, v| v > 1}
end


#### Problem 17
Create a method that takes an array of integers as an argument. 
The method should determine the minimum integer value that can be 
appended to the array so the sum of all the elements equal the 
closest prime number that is greater than the current sum of the numbers. 
For example, the numbers in [1, 2, 3] sum to 6. 
The nearest prime number greater than 6 is 7. 
Thus, we can add 1 to the array to sum to 7.

The array will always contain at least 2 integers.
All values in the array must be positive (> 0).
There may be multiple occurrences of the various numbers in the array.

ExamplesCopy Code
p nearest_prime_sum([1, 2, 3]) == 1        # Nearest prime to 6 is 7
p nearest_prime_sum([5, 2]) == 4           # Nearest prime to 7 is 11
p nearest_prime_sum([1, 1, 1]) == 2        # Nearest prime to 3 is 5
p nearest_prime_sum([2, 12, 8, 4, 6]) == 5 # Nearest prime to 32 is 37

# Nearest prime to 163 is 167
p nearest_prime_sum([50, 39, 49, 6, 17, 2]) == 4
The above tests should each print true.

find the sum of the array and keep adding until next prime, return what was added
   So how do you determine a prime number?
   Prime is only divisible by itself and one

def prime?(number)
  return false if number <= 1 # GUARD 
  (2..Math.sqrt(number)).each do |i|
    return false if number % i == 0
  end
  true
end

D input : array
   output : integer dif of array sum and next highest prime
   intermediate : counter 
              helper method
A make a prime helper method that takes a number
     guard clause if number <= 1
     make a range from 2 to the square root of the input number
     for each instance of that range, check to see if it goes into the input number evenly
     if it does, return false
     if you make it through all instances, return true
   define method with one array argument
     find the sum of the array
     create a variable with that sum's' value
     start checking numbers += 1 until you get to a prime,
     return the difference between the prime and the initial sum
 C
 
def prime?(number)
  return false if number <= 1
  (2..Math.sqrt(number)).each do |i|
    return false if number % i == 0
  end
  true
end

def nearest_prime_sum(array)
  array_sum = array.sum
  counter = 1 # to make sure NEXT highest prime, in case already prime
  until prime?(array_sum + counter)
    counter += 1
  end
  counter
end

#### Problem 18
Create a method that takes an array of integers as an argument. 
Determine and return the index N for which all numbers with an index less than N 
sum to the same value as the numbers with an index greater than N. 
If there is no index that would make this happen, return -1.

If you are given an array with multiple answers, return the index with the smallest value.

The sum of the numbers to the left of index 0 is 0. 
Likewise, the sum of the numbers to the right of the last element is 0.

ExamplesCopy Code
p equal_sum_index([1, 2, 4, 4, 2, 3, 2]) == 3
p equal_sum_index([7, 99, 51, -48, 0, 4]) == 1
p equal_sum_index([17, 20, 5, -60, 10, 25]) == 0

# The following test case could return 0 or 3. Since we're
# supposed to return the smallest correct index, the correct
# return value is 0.
p equal_sum_index([0, 20, 10, -60, 5, 25]) == 0
p equal_sum_index([7, 99, 51, -48, 0, 9]) == -1
p equal_sum_index([1, 2, 3, -3, -2, -1, 100]) == 6
The above tests should each print true.

doesn't' count value of current index
start with a 0 variable for left value
sum everything to the right of the current index for right value and compare
return index if both sides are equal
cycle through all indices, if none match, return -1
slices are , 0...current + (current + 1)..-1

def equal_sum_index(array)
  left_value = 0
  (0..(array.size - 1).each do |current|
    left_value = array[0...current].sum if array[0...current]
      return current if left_value == array[(current + 1)..-1].sum
  end
  -1
end


#### Problem 19
Create a method that takes an array of integers as an argument and 
returns the integer that appears an odd number of times. 
There will always be exactly one such integer in the input array.

ExamplesCopy Code
p odd_fellow([4]) == 4
p odd_fellow([7, 99, 7, 51, 99]) == 51
p odd_fellow([7, 99, 7, 51, 99, 7, 51]) == 7
p odd_fellow([25, 10, -6, 10, 25, 10, -6, 10, -6]) == -6
p odd_fellow([0, 0, 0]) == 0
The above tests should each print true.


tally, select the key with the odd value

def odd_fellow(array)
  hash = array.tally
  hash.select {|_k, v| v.odd? }.keys[0]
end


#### Problem 20
Create a method that takes an array of numbers, all of which are the same except one. 
Find and return the number in the array that differs from all the rest.

The array will always contain at least 3 numbers, 
and there will always be exactly one number that is different.

ExamplesCopy Code
p what_is_different([0, 1, 0]) == 1
p what_is_different([7, 7, 7, 7.7, 7]) == 7.7
p what_is_different([1, 1, 1, 1, 1, 1, 1, 11, 1, 1, 1, 1]) == 11
p what_is_different([3, 4, 4, 4]) == 3
p what_is_different([4, 4, 4, 3]) == 3
The above tests should each print true.

same as 19 but v == 1

def what_is_different(array)
  hash = array.tally
  hash.select {|_k, v| v == 1 }.keys[0]
end



#### FROM CODERPAD



def count_substrings(string1, string2)
  until !string1.include?(string2)
    string1.sub!(string2, '*')
  end
  string1.count('*')
end

p count_substrings('babab', 'bab') == 1
p count_substrings('babab', 'ba') == 2
p count_substrings('babab', 'b') == 3
p count_substrings('babab', 'x') == 0
p count_substrings('babab', 'x') == 0
p count_substrings('', 'x') == 0
p count_substrings('bbbaabbbbaab', 'baab') == 2
p count_substrings('bbbaabbbbaab', 'bbaab') == 2
p count_substrings('bbbaabbbbaabb', 'bbbaabb') == 1

def even_substrings(string)
  sub_arrays = []
  (0..string.length).each do |start_index|
    (start_index...string.length).each do |end_index|
      sub_arrays << string[start_index..end_index]
    end
  end
  sub_arrays.count {|sub| sub.to_i % 2 == 0}
end

p even_substrings('1432') == 6
p even_substrings('3145926') == 16
p even_substrings('2718281') == 16
p even_substrings('13579') == 0
p even_substrings('143232') == 12

def repeated_substring(string)
  characters = string.chars
  working_string = ''
  loop do
    working_string << characters.shift
    break if working_string * 
    (string.length / working_string.length) == string
  end
  [working_string, (string.length / working_string.length)]
end

p repeated_substring('xyzxyzxyz') == ['xyz', 3]
p repeated_substring('xyxy') == ['xy', 2]
p repeated_substring('xyz') == ['xyz', 1]
p repeated_substring('aaaaaaaa') == ['a', 8]
p repeated_substring('superduper') == ['superduper', 1]
# The above tests should each print true.

p repeated_substring('xyxyxyxy') == ['xy', 4]
p repeated_substring('xyxyxyxyxyxyxyxy') == ['xy', 8]
p repeated_substring('xyxyxyxyxyxyxyxyz') == ['xyxyxyxyxyxyxyxyz', 1]

def is_pangram(string)
  alphabet = ('a'..'z').to_a
  character_array = string.downcase.chars
  alphabet.all?{|char| character_array.include?(char)}
end

p is_pangram('The quick, brown fox jumps over the lazy god!') == true
p is_pangram('The slow, brown fox jumps over the lazy dog!') == false
p is_pangram("A wizard’s job is to vex chumps quickly in fog.") == true
p is_pangram("A wizard’s task is to vex chumps quickly in fog.") == false
p is_pangram("A wizard’s job is to vex chumps quickly in golf.") == true

fnord = 'SPHINX OF BLACK QUARTZ, JUDGE MY VOW!'
my_str = 'Sixty zippers were quickly picked from the woven jute bag.'
p is_pangram(my_str) == true
p is_pangram(fnord) == true

def unscramble(str1, str2)
  main_string = str1.dup
  check_array = str2.chars
  until check_array.empty?
    check_char = check_array.shift
    if main_string.include?(check_char)
      main_string.sub!(check_char, '')
    else
      return false
    end
  end
  true    
end

def unscramble(str1, str2)
  main_string = str1.dup
  check_array = str2.chars
  until check_array.empty?
    check_char = check_array.shift
    main_string.include?(check_char) ? main_string.sub!(check_char, '') : return false
  end
  true
end

p unscramble('ansucchlohlo', 'launchschool') == true
p unscramble('ansucchlohlo', 'launchschooll') == false
p unscramble('phyarunstole', 'pythonrules') == true
p unscramble('phyarunstola', 'pythonrules') == false
p unscramble('boldface', 'coal') == true

def seven_eleven(number)
  return 0 if number <= 7
  multiples = []
  (7...number).each do |num|
  multiples << num if num % 7 == 0 || num % 11 == 0
  end
  multiples.sum
end

def seven_eleven(number)
  return 0 if number <= 7
  (7...number).select {|num| num if num % 7 == 0 || num % 11 == 0}.sum
end

p seven_eleven(10) == 7
p seven_eleven(11) == 7
p seven_eleven(12) == 18
p seven_eleven(25) == 75
p seven_eleven(100) == 1153
p seven_eleven(0) == 0
p seven_eleven(-100) == 0

def greatest_product(number)
  slices = []
  (0..(number.length - 4)).select do |index|
    slices << number.slice(index, 4)
  end
  slices.map {|sub| sub.to_i.digits.inject(:*)}.max
end

p greatest_product('23456') #== 360      # 3 * 4 * 5 * 6
p greatest_product('234567') #== 840     # 4 * 5 * 6 * 7
p greatest_product('3145926') #== 540    # 5 * 9 * 2 * 6
p greatest_product('1828172') #== 128    # 1 * 8 * 2 * 8
p greatest_product('123987654') #== 3024 # 9 * 8 * 7 * 6

def distinct_multiples(string)
  letters_hash = string.downcase.chars.tally
  letters_hash.count {|_, v| v > 1}
end

def distinct_multiples(string)
  string.downcase.chars.tally.count {|_, v| v > 1}
end

p distinct_multiples('xyz') == 0               # (none
p distinct_multiples('xxyypzzr') == 3          # x, y, z
p distinct_multiples('xXyYpzZr') == 3          # x, y, z
p distinct_multiples('unununium') == 2         # u, n
p distinct_multiples('multiplicity') == 3      # l, t, i
p distinct_multiples('7657') == 1              # 7
p distinct_multiples('3141592653589793') == 4  # 3, 1, 5, 9
p distinct_multiples('2718281828459045') == 5  # 2, 1, 8, 4, 5

def prime?(number)
  return false if number <= 1

  (2..Math.sqrt(number)).each do |i|
    return false if number % i == 0
  end
  true
end

def nearest_prime_sum(array)
  array_sum = array.sum
  counter = 1
  until prime?(array_sum + counter)
    counter += 1
  end
  counter
end

p nearest_prime_sum([1, 2, 3]) == 1        # Nearest prime to 6 is 7
p nearest_prime_sum([5, 2]) == 4           # Nearest prime to 7 is 11
p nearest_prime_sum([1, 1, 1]) == 2        # Nearest prime to 3 is 5
p nearest_prime_sum([2, 12, 8, 4, 6]) == 5 # Nearest prime to 32 is 37

# Nearest prime to 163 is 167
p nearest_prime_sum([50, 39, 49, 6, 17, 2]) == 4

def equal_sum_index(array)
  left_value = 0
  (0..(array.size - 1)).each do |current|
    left_value = array[0...current].sum if array[0...current]
    return current if left_value == array[(current + 1)..-1].sum
  end
  -1
end

p equal_sum_index([1, 2, 4, 4, 2, 3, 2]) == 3
p equal_sum_index([7, 99, 51, -48, 0, 4]) == 1
p equal_sum_index([17, 20, 5, -60, 10, 25]) == 0

# The following test case could return 0 or 3. Since we're
# supposed to return the smallest correct index, the correct
# return value is 0.
p equal_sum_index([0, 20, 10, -60, 5, 25]) == 0
p equal_sum_index([7, 99, 51, -48, 0, 9]) == -1
p equal_sum_index([1, 2, 3, -3, -2, -1, 100]) == 6

def odd_fellow(array)
  hash = array.tally
  hash.select {|_k, v| v.odd? }.keys[0]
end

p odd_fellow([4]) == 4
p odd_fellow([7, 99, 7, 51, 99]) == 51
p odd_fellow([7, 99, 7, 51, 99, 7, 51]) == 7
p odd_fellow([25, 10, -6, 10, 25, 10, -6, 10, -6]) == -6
p odd_fellow([0, 0, 0]) == 0

def what_is_different(array)
  hash = array.tally
  hash.select {|_k, v| v == 1 }.keys[0]
end

p what_is_different([0, 1, 0]) == 1
p what_is_different([7, 7, 7, 7.7, 7]) == 7.7
p what_is_different([1, 1, 1, 1, 1, 1, 1, 11, 1, 1, 1, 1]) == 11
p what_is_different([3, 4, 4, 4]) == 3
p what_is_different([4, 4, 4, 3]) == 3
