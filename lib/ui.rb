require 'gosu'

class UI < Gosu::Window
  attr_reader :game, :scale

  def initialize(game, scale: 15)
    @scale = scale
    @game = game
    super(game.width * scale, game.height * scale)
    self.update_interval = 150
  end

  def caption
    ""
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
    game.up if id == Gosu::KB_UP
    game.down if id == Gosu::KB_DOWN
    game.left if id == Gosu::KB_LEFT
    game.right if id == Gosu::KB_RIGHT

    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end
