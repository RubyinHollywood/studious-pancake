require 'sinatra/base'
require 'json'
require 'pp'
require_relative 'snake'

TAUNTS = ["This isn't your moms Ruby in Hollywood", "This isn't your dads Ruby in Hollywood", "Get outta town!", "Come and get me!", "Gotta get that food!", "I'm tired of these muther fucking snakes in the mother fucking code!"]
HEAD_TYPES = %w|bendr dead fang pixel regular safe sand-worm shades smile tongue|
TAIL_TYPES = %w|block-bum curled fat-rattle freckled pixel regular round-bum skinny small-rattle|
class BattleSnake < Sinatra::Base
  before { content_type "application/json" }

  get '/' do
    {
      "color"=> "#fff000",
      "head_url"=> "url/to/your/img/file"
    }.to_json
  end

  post '/start' do
    json_string = request.body.read
    _request = json_string ? JSON.parse(json_string) : {}

    # Get ready to start a game with the request data

    colour = "%06x" % (rand * 0xffffff)
    taunt = ["This isn't your moms Ruby in Hollywood", "This isn't your dads Ruby in Hollywood", "Get outta town!", "Come and get me!", "Gotta get that food!", "I'm tired of these muther fucking snakes in the mother fucking code!"]
    head = %w|bendr dead fang pixel regular safe sand-worm shades smile tongue|.sample
    tail = %w|block-bum curled fat-rattle freckled pixel regular round-bum skinny small-rattle|.sample
    response = {
      "taunt" => taunt.sample,
      "color" => "##{colour}",
      "head_type" => head,
      "tail_type" => tail
    }

    response.to_json
  end

  post '/move' do
    string = request.body.read
    json = string ? JSON.parse(string) : {}
    board = Board.from(json: json)

    snake = board.you

    # puts "="* 50
    # p snake.name, snake.available_moves(board), snake.body
    # puts "="* 50

    direction = snake.available_moves(board).sample
    # TODO: get some more taunts going here.
    response = {
      "move" => direction.to_s,
      "taunt" => TAUNTS.sample
    }

    p response
    response.to_json
  end

  post '/end' do
    string = request.body.read
    json = string ? JSON.parse(string) : {}

    puts "Game over:"
    p json
    # No response required
    response = {}

    response.to_json
  end
end
