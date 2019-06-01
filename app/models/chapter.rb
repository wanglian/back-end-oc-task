class Chapter < ApplicationRecord

  attribute :rooms_count, :integer

  has_many :rooms, dependent: :delete_all
  has_many :edges, dependent: :delete_all

  validate :uniq_active
  validate :check_rooms_count, on: :create

  before_create :ensure_uniq_active
  after_create :generate_rooms_and_edges

  def self.active
    where(active: true).last
  end

  private
  def ensure_uniq_active
    self.active = true
    active_chapter = Chapter.active
    if active_chapter
      active_chapter.update_column :active, false
    end
  end

  def generate_rooms_and_edges
    maze = Maze.generate self.rooms_count

    # generate rooms
    rooms_hash = {}
    maze.keys.each do |room_number|
      final = room_number == self.rooms_count
      rooms_hash[room_number] = self.rooms.create number: room_number, final: final
    end

    # generate edges
    maze.each do |r_number, values|
      values.each do |r_child|
        self.edges.create parent_room: rooms_hash[r_number], child_room: rooms_hash[r_child]
      end
    end
  end

  def uniq_active
    if self.active && Chapter.active
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
    room_numbers = [keys.first]
    while level < size
      tmp = []
      room_numbers.each do |room_number|
        edges[room_number].each do |child|
          return true if child == last
          tmp << child
        end
      end
      room_numbers = tmp.uniq
      level += 1
    end
    false
  end

  private
  def self.random_route
    route = []
    room_number = @@size
    while room_number > 1
      route.unshift room_number
      room_number = Random.rand(room_number - 1) + 1 # range 1..room_number-1
    end
    route.unshift 1
    route
  end

  def self.random_edges(route)
    route_room_number = route.shift
    (1..@@size).map do |room_number|
      room_children = []
      if route_room_number == room_number
        route_room_number = route.first
        room_children << route.shift if route_room_number
      end
      if @@size > 2 && room_number < @@size
        MAX_CHILDREN.times do
          loop do
            r = Random.rand(@@size - 1) + 1
            unless r == room_number
              room_children << r
              break
            end
          end
        end
      end
      [room_number, room_children.uniq]
    end.to_h
  end

end
