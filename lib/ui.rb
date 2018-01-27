require 'gosu'

class UI < Gosu::Window
  attr_reader :game, :scale

  def initialize(game, scale: 15)
    @scale = scale
    @game = game
    super(game.width * scale, game.height * scale)
    self.update_interval = 150
  end

  def update
    if game.over?
      self.caption = "Snake score: #{game.score}; GAME OVER!"
    else
      game.tick!
      self.caption = "Snake score: #{game.score}"
    end
  end

  def draw
    game.snake.each do |(x, y)|
      Gosu.draw_rect(x * scale, y * scale, scale, scale, Gosu::Color::WHITE)
    end

    Gosu.draw_rect(game.apple[0] * scale, game.apple[1] * scale, scale, scale, Gosu::Color::RED)
  end

  def button_down(id)
    case id
    when Gosu::KB_UP
      game.up
    when Gosu::KB_DOWN
      game.down
    when Gosu::KB_LEFT
      game.left
    when Gosu::KB_RIGHT
      game.right
    when Gosu::KB_RETURN, Gosu::KB_SPACE
      game.restart
    when Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end
