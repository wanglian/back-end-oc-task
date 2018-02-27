# Take home assignment - Maze
  Hello! 👋

  Congratulations on making it to the second round! 

## What is the Maze application?
1. Maze is a rooted directed graph with only 1 dead end(exit) ( example: https://docs.google.com/drawings/d/1suDDN-C7Nb2s09yZcrEYmA6xuo4kcVScJuPsZf3jQWw/edit?usp=sharing )
2. Graph should start with room number 1 
3. Graph should end at the maximum room number within the chapter
4. Maximum number of vertices (room) is 45
5. Minimum number of vertices (room) is 2
6. Chapter can be created by anyone
7. After new chapter is created, it becomes active 
8. Only 1 active chapter shoud exisit within the system
9. After new chapter has been created, you will need to generate rooms and edges
10. After a new room is created, a new door should be automatically assigned to it
11. Each vertices (room) within the chapter should be assigned to a unique door id

## How to setup initial application
```sh
1. bundle install 
2. check config/database.yml username for postgres and change it if required
3. setup db and pass migrations
4. run bundle exec rake test_task:seed_doors and bundle exec rake test_task:g_init_chapter
5. rails s to start application 
```

## DB structure
1. Chapter - is a parent object of rooms and edges. 
2. Room - consider room like a vertex in a graph. Room belongs to chapter. There might be up to 45 rooms in 1 chapter. 
3. Edge - consider edge as a path between rooms (room_parent_id -> room from which path starts, room_child_id -> room the path navigates to).
4. Door - model to store door images.
 
## TODO 
1. Write code for generate_rooms_and_edges method in chapter.rb
2. Improve/optimize exisiting backend code where you think it's necessary
3. Also assume this little application could be accessed by millions of users, therefore, please prepare for high load useage/traffic on the backend as well. 
 
      
    
