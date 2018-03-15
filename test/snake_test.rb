require_relative 'test_helper'


class TestSnake < Minitest::Test
  MOVE_REQUEST = {"you"=>
  {"taunt"=>nil,
   "object"=>"snake",
   "name"=>"Not Jake",
   "length"=>3,
   "id"=>"fbf01ebe-af26-4b99-beb5-b432b0ecb530",
   "health"=>100,
   "body"=>
    {"object"=>"list",
     "data"=>
      [{"y"=>3, "x"=>6, "object"=>"point"},
       {"y"=>2, "x"=>6, "object"=>"point"},
       {"y"=>2, "x"=>6, "object"=>"point"}]}},
 "width"=>10,
 "turn"=>1,
 "snakes"=>
  {"object"=>"list",
   "data"=>
    [{"taunt"=>nil,
      "object"=>"snake",
      "name"=>"Not Jake",
      "length"=>3,
      "id"=>"fbf01ebe-af26-4b99-beb5-b432b0ecb530",
      "health"=>100,
      "body"=>
       {"object"=>"list",
        "data"=>
         [{"y"=>3, "x"=>6, "object"=>"point"},
          {"y"=>2, "x"=>6, "object"=>"point"},
          {"y"=>2, "x"=>6, "object"=>"point"}]}},
     {"taunt"=>nil,
      "object"=>"snake",
      "name"=>"Jake",
      "length"=>3,
      "id"=>"50159bd2-9a7e-4268-b6b0-8d72e3c8d29b",
      "health"=>100,
      "body"=>
       {"object"=>"list",
        "data"=>
         [{"y"=>1, "x"=>7, "object"=>"point"},
          {"y"=>1, "x"=>8, "object"=>"point"},
          {"y"=>1, "x"=>8, "object"=>"point"}]}}]},
 "object"=>"world",
 "id"=>1,
 "height"=>10,
 "food"=>
  {"object"=>"list",
   "data"=>
    [{"y"=>7, "x"=>1, "object"=>"point"},
     {"y"=>7, "x"=>3, "object"=>"point"},
     {"y"=>2, "x"=>3, "object"=>"point"}]}}

  def setup
    @snake = Snake.new(MOVE_REQUEST['you'])
  end

  def test_attrs
    assert_equal 3, @snake.length
    assert_equal 'Not Jake', @snake.name
    assert_equal 100, @snake.health
    assert_instance_of Array, @snake.body
  end

  def test_calculate_up
    next_c = @snake.calculate(:up)
    assert_equal @snake.head['y'] + 1, next_c['y']
    assert_equal @snake.head['x'], next_c['x']
  end

  def test_calculate_down
    next_c = @snake.calculate(:down)
    assert_equal @snake.head['y'] - 1, next_c['y']
    assert_equal @snake.head['x'], next_c['x']
  end

  def test_calculate_left
    next_c = @snake.calculate(:left)
    assert_equal @snake.head['x'] - 1, next_c['x']
    assert_equal @snake.head['y'], next_c['y']
  end

  def test_calculate_right
    next_c = @snake.calculate(:right)
    assert_equal @snake.head['x'] + 1, next_c['x']
    assert_equal @snake.head['y'], next_c['y']
  end

  def test_available_moves
    p @snake.available_moves
  end

end

