class SnakeGame
  attr_reader :width, :height, :snake, :apple

  OPPOSITE = {
    up: :down,
    down: :up,
    left: :right,
    right: :left
  }.freeze

  def initialize(width:, height:)
    @width = width
    @height = height
    restart
  end

  def restart
    @over = false
    @direction = :right
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
    return if @blocked_direction == :up
    @direction = :up
  end

  def down
    return if @blocked_direction == :down
    @direction = :down
  end

  def left
    return if @blocked_direction == :left
    @direction = :left
  end

  def right
    return if @blocked_direction == :right
    @direction = :right
  end

  def over?
    @over
  end

  def tick!
    return if over?

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

    @blocked_direction = OPPOSITE[@direction]
  end
end
