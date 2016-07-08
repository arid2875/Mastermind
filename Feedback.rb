class Feedback
  attr_accessor :spaces

  def initialize(first=" ", second=" ", third=" ", fourth=" ")
    @spaces = {0 => first, 1 => second, 2 => third, 3 => fourth}
  end

  def set_spaces(space_1, space_2, space_3, space_4)
  	@spaces[0] = space_1
  	@spaces[1] = space_2
  	@spaces[2] = space_3
  	@spaces[3] = space_4
  end
end