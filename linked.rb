# my code, despite it being very confusing absolutely rocks because for each new node, I have established both the previous and next node relationships upon every append
# 5:40 - 7:17 on 6.7.23 ended at 9pm on 6.7.23 (no git history)
class LinkedList
  def initialize(listname='NEW LIST')
    @listname = listname
    # no head at initialization
    @head = nil
    @tail = nil
    puts "Linked list of #{@listname} initialized!"
    @counter = 0
  end
# recursion
  def at(index, node = @head, counter = 0)
    return node.value if index == counter
    # nothing (nil) is spit out if index doesnt correspond with a node
    return nil if node.nextnode.nil?
    at(index, node.nextnode, counter + 1)
  end
# recursion again
def contains?(value, node = @head)
  return "A node with a value of '#{node.value}' exists." if node.value == value
  # nothing (nil) is spit out if index doesnt correspond with a node
  return "No results for '#{value}'." if node.nextnode.nil?
  contains?(value, node.nextnode)
end
# recursion again again
def find(value, node = @head, index = 0)
  # show recursion index if the value matches otherwise keep searching...
  return index if node.value == value
  # nothing (nil) is spit out if index doesnt correspond with a node
  return "No index results for '#{value}'." if node.nextnode.nil?
  find(value, node.nextnode, index + 1)
end
# okay last recursion 
def to_s(node = @head, string = '')
  return string += "( #{node.value} ) -> nil" if node.nextnode.nil?
  string += "( #{node.value} ) -> "
  to_s(node.nextnode, string)
end
# all recursion credit to (scheals on github Antoni Sobolewski) The rest is mine...
def size()
  puts @counter
end
def head()
  puts @head.value
end
def tail()
  puts @tail.value
end

  def append(input)
    @counter += 1
    # befor continuing, a head is created with the input if it doesn't exist yet
    #if head dne then make one before continuing on (this method is called within other methods in order to work properly)
    if @head.nil?
      @head = Node.new("#{input}")  
    # check that @head.value works and is equal to the input variable
      puts "HEAD IS SET TO '#{@head.value}'."
      @current_node = @head
    else
    # check to see head is reassigned on the append method once prepend kicks in
      # puts "head isssssssss #{@head.value}"
    # else, if head exists already then...
    # set ref point (must specify the readable attribute 'value' of the head instance variable which stored the whole new node object)
    # create new node that has gets assigned a text value of whatever the input is (must be a string input)
    new_node = Node.new("#{input}") 
    # append by attaching the new node
    # then define the relationship so that the previous node's next node is the input, and that the input's previous node is the previous node
    if @head.nextnode.nil?
    #if the head node doesn't have a pointer then the new node gets pointed to. Otherwise move on.
      @head.nextnode = new_node
    end
    puts "before appending, the current node var is '#{@current_node.value}'."
    puts "appending..."
    # assign the new node to the previous node's "nextnode" attribute
    @current_node.nextnode = new_node
    # assign the previous node to the new node's "previousnode" attribute unless the temp current_node holder is nil (will be nil on first call of append)
    new_node.previousnode = @current_node unless @current_node.nil?
    # then reassign the current node to the current input
    # (tip: to get the object's value you do .value at the end so either current_node.value or new_node.value)
    @current_node = new_node
    # assign @tail to this most recent node (if pop happens, then tail needs to be reassigned to the deleted node's previous note btw)
    @tail = new_node
    # check that both current node value appears
    puts "the previous node is now '#{new_node.previousnode.value}' and added node is '#{@current_node.value}'."
    puts "another check: previous node ('#{new_node.previousnode.value}') has next node of #{new_node.previousnode.nextnode.value}"
    end
  end

  def prepend(input)
    # dont forget to do -= 1 when popping
    @counter += 1
    if @head.nil?
      @head = Node.new("#{input}")  
    # check that @head.value works and is equal to the input variable
      puts "HEAD IS SET TO '#{@head.value}'."
      @current_node = @head
    else
      # create the new node
      temp_var = Node.new("#{input}") 
      # store the new node into the head's "previous node" attribute
      @head.previousnode = temp_var
      # then store the current head into the temp_var's "next node" attribute
      temp_var.nextnode = @head
      #quick check it is still nil
      puts "prev of head should always be nil: #{temp_var.previousnode}"
      # then finally make the temp_var the new @head
      @head = temp_var
      puts "HEAD IS SET TO '#{@head.value}'."
    end
  end

  def pop()
    if @head == nil
      puts "can't work on empty list"
    else
      @counter -= 1
      puts "current tail nextnode must be nil '#{@tail.nextnode}'"
      new_tail = @tail.previousnode 
      # detatch the new tail's nextnode so that recursion inside the index at method will HALT. By definition, the tail must always have a nextnode value of NIL     
      new_tail.nextnode = nil
      puts "#{new_tail.value} is new node"
      @tail = new_tail
      @current_node = new_tail
    end
  end
end

class Node
  attr_reader :value
  # assign prev and next
  attr_accessor :nextnode, :previousnode
  # make a node but make it so that the pointers are set to nil and cant be manually set on initialization from CMD.
  def initialize(value=nil)
    @value = value
    @nextnode = nil
    @previousnode = nil
    # create / test that value is stored then nil is stored for both previous and next node by default
    # puts "value of '#{@value}' initialized."
  end
end

########################################## actions ##########################################
list = LinkedList.new("LIST")
# the first time the list runs, "one" becomes the head and nothing else is done.
list.append("one")
# the second time the list runs, "one" is still the head and and "two" is properly appended.
list.append("two")
# the third time the list runs, "one" is still the head and and "three" is properly appended.
list.append("three")
# not sure why it's blue
list.prepend("zero")
list.append("four")
list.append("five")
list.pop()

########################################## analysis ##########################################
list.size()
list.head()
list.tail()
puts "the list is"
puts list.at(0)
puts list.at(1)
puts list.at(2)
puts list.at(3)
puts list.at(4)
puts list.at(5)
puts list.at(6)

puts list.contains?('one')
puts list.contains?('onsdfsde')
puts list.find('five')
puts list.to_s
