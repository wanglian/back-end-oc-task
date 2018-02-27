namespace :test_task do
  desc 'Generate init chapter and rooms'
  task :g_init_chapter => :environment do
    chapter = Chapter.first_or_create number: 1, active: true
    edges   = {
                '1' => [ 2, 3, 6 ],
                '2' => [ 1 ],
                '3' => [ 6 ],
                '4' => [ 7, 8 ],
                '5' => [ 4, 6 ],
                '6' => [ 7 ],
                '7' => [ 5 ],
                '8' => []
              }

    # generate rooms
    edges.keys.each do |room_number|
      final = room_number == '8'
      Room.create number: room_number, final: final
    end

    # generate edges
    edges.each do |r_number, values|
      values.each do |r_child|
        room_parent = Room.active(chapter.id).where(number: r_number).first
        room_child  = Room.active(chapter.id).where(number: r_child).first

        Edge.create room_parent_id: room_parent.id,
                    room_child_id: room_child.id
      end
    end

  end
end
