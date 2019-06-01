require 'test_helper'

class ChapterTest < ActiveSupport::TestCase
  test "maze is valid" do
    edges = {
              1 => [ 2, 3, 6 ],
              2 => [ 1 ],
              3 => [ 6 ],
              4 => [ 7, 8 ],
              5 => [ 4, 6 ],
              6 => [ 7 ],
              7 => [ 5 ],
              8 => []
            }
    assert Maze.valid?(edges)
  end

  test "maze is invalid when any room has no child" do
    edges = {
              1 => [ 2, 3, 6 ],
              2 => [ ],
              3 => [ 6 ],
              4 => [ 7, 8 ],
              5 => [ 4, 6 ],
              6 => [ 7 ],
              7 => [ 5 ],
              8 => []
            }
    assert_not Maze.valid?(edges)
  end

  test "maze is invalid when there is no way out" do
    edges = {
              1 => [ 2, 3, 6 ],
              2 => [ 1 ],
              3 => [ 6 ],
              4 => [ 7 ],
              5 => [ 4, 6 ],
              6 => [ 7 ],
              7 => [ 5 ],
              8 => []
            }
    assert_not Maze.valid?(edges)
  end

  test "generate valid maze" do
    assert Maze.valid?(Maze.generate 2)
    assert Maze.valid?(Maze.generate 3)
    assert Maze.valid?(Maze.generate 30)
    assert Maze.valid?(Maze.generate 45)
  end
end
