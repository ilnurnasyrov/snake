class SnakeGame
  attr_reader :width, :height, :snake, :apple

  def initialize(width:, height:)
    @direction = :right
    @width = width
    @height = height
    @apple = [width / 2 - 1, height / 2 - 1]
    @snake = [
      [3, 0],
      [2, 0],
      [1, 0],
      [0, 0]
    ]
  end

  def score
    snake.size - 4
  end

  def up
    @direction = :up unless @direction == :down
  end

  def down
    @direction = :down unless @direction == :up
  end

  def left
    @direction = :left unless @direction == :right
  end

  def right
    @direction = :right unless @direction == :left
  end

  def over?
    @over
  end

  def tick!
    x, y = snake.first
    next_head =
      case @direction
      when :up
        [x, y - 1]
      when :down
        [x, y + 1]
      when :left
        [x - 1, y]
      when :right
        [x + 1, y]
      end

    next_head[0] = width - 1 if next_head[0] < 0
    next_head[0] = 0 if next_head[0] == width
    next_head[1] = height - 1 if next_head[1] < 0
    next_head[1] = 0 if next_head[1] == height

    if snake.include?(next_head)
      @over = true
      return
    end

    snake.prepend(next_head)

    if next_head == apple
      @apple = [rand(width), rand(height)] while snake.include?(apple)
    else
      snake.pop
    end
  end
end
