class Game
  MOVES = %i|up down left right|
  MOVE_APPLICATIONS = {
    up: [:y, -1],
    down: [:y, 1],
    left: [:x, -1],
    right: [:x, 1],
  }
end

class Board
  def self.from(json:)
    you = json.delete("you")
    food = json.delete("food")["data"]
    snakes = json.delete("snakes")["data"].select {|s| s["id"] != you["id"]}
    new(json, you: you, food: food, snakes: snakes)
  end

  attr_reader :height, :width, :you, :snakes, :food

  def initialize(board, you:, food:, snakes:)
    @height, @width = board["height"], board["width"]
    @you, @snakes, @food = Snake.new(you), snakes.map {|s| Snake.new(s)}, food
  end

  def closest_food(snake)
    head_x, head_y = snake.head["x"], snake.head["y"]

    food.sort do |hsh|
      sqrt( (hsh["x"]-head_x)^2 + (hsh["y"]-head_y)^2 )
    end.last
  end
end

class Snake
  attr_reader :name, :length, :health, :id, :body

  def initialize(object)
    @name, @length, @health = object["name"], object["length"], object["health"]
    @id = object["id"]
    @body = if object["body"]["object"] == "list"
      object["body"]["data"]
    else
      object["body"]
    end
  end

  def eat(board)
    closest_food = find_closest_food(board)
  end

  def available_moves(board)
    Game::MOVES.select do |direction|
      can_move?(direction, board)
    end
  end

  # TODO: this needs some work
  #  - check within board bound
  #  - needs to know dimensions of board
  def can_move?(direction, board)
    coordinates_would_be = calculate(direction)
    # puts "checking for #{direction}, #{coordinates_would_be}"
    return false if out_of_bounds?(coordinates_would_be, board)
    !body.include?(coordinates_would_be)
  end

  def head
    @body.first
  end

  def calculate(direction)
    axis, application = Game::MOVE_APPLICATIONS[direction]
    next_coords = head.clone
    next_coords[axis.to_s] = next_coords[axis.to_s] + application
    next_coords
  end

  def out_of_bounds?(coords, board)
    return true unless (0..(board.height - 1)).include?(coords['x']) && (0..(board.width - 1)).include?(coords['y'])
    false
  end

  private

end

