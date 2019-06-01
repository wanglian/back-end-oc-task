class Chapter < ApplicationRecord

  attribute :rooms_count, :integer

  has_many :rooms, dependent: :delete_all
  has_many :edges, dependent: :delete_all

  validate :uniq_active, :check_rooms_count

  before_create :set_active
  after_create :generate_rooms_and_edges

  scope :active, -> { where(active: true).first }

  def self.active
    where(active: true).last
  end

  private
  def set_active
    self.active = true
  end

  def generate_rooms_and_edges
    maze = Maze.generate self.rooms_count

    # generate rooms
    maze.keys.each do |room_number|
      final = room_number == self.rooms_count
      self.rooms.create number: room_number, final: final
    end

    # generate edges
    maze.each do |r_number, values|
      values.each do |r_child|
        room_parent = Room.active(self.id).where(number: r_number).first
        room_child  = Room.active(self.id).where(number: r_child).first

        self.edges.create room_parent_id: room_parent.id, room_child_id: room_child.id
      end
    end
  end

  def uniq_active
    if self.active && Chapter.where(active: true).first
      errors.add(:active, 'only 1 active chapter may exists in the system')
    end
  end

  def check_rooms_count
    if self.rooms_count < 2 || self.rooms_count > 45
      errors.add(:rooms_count, 'must less than 45 and not less than 2')
    end
  end

end

class Maze

  MAX_CHILDREN = 5

  def self.generate(size)
    @@size = size
    route = self.random_route
    self.random_edges route
  end

  # validate the maze
  def self.valid?(edges)
    size = edges.size
    keys = edges.keys.sort
    return false unless keys.last == size

    # every room has at least one available room
    keys.each_with_index do |key, index|
      if index == (keys.length - 1)
        return false unless edges[key].empty?
      else
        return false if edges[key].empty?
      end
    end

    # there is at least one way out
    last = keys.last
    level = 0
    rooms = [keys.first]
    while level < size
      tmp = []
      rooms.each do |room|
        edges[room].each do |child|
          return true if child == last
          tmp << child
        end
      end
      rooms = tmp.uniq
      level += 1
    end
    false
  end

  private
  def self.random_route
    route = []
    room_no = @@size
    while room_no > 1
      route.unshift room_no
      room_no = Random.rand(room_no - 1) + 1 # range 1..room_no-1
    end
    route.unshift 1
    route
  end

  def self.random_edges(route)
    route_no = route.shift
    edges = (1..@@size).map do |n|
      children = []
      if route_no == n
        route_no = route.first
        children << route.shift if route_no
      end
      if @@size > 2 && n < @@size
        MAX_CHILDREN.times do
          loop do
            r = Random.rand(@@size - 1) + 1
            unless r == n
              children << r
              break
            end
          end
        end
      end
      [n, children.uniq]
    end.to_h
  end

end
