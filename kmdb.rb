# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!
# - Note rubric explanation for appropriate use of external resources.

# Rubric
#
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)
# - You are welcome to use external resources for help with the assignment (including
#   colleagues, AI, internet search, etc). However, the solution you submit must
#   utilize the skills and strategies covered in class. Alternate solutions which
#   do not demonstrate an understanding of the approaches used in class will receive
#   significant deductions. Any concern should be raised with faculty prior to the due date.

# Submission
#
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======
# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========
# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Represented by agent
# ====================
# Christian Bale

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
# TODO!

Role.destroy_all
Movie.destroy_all
Actor.destroy_all
Studio.destroy_all
Agent.destroy_all

# Generate models and tables, according to the domain model.
# TODO!
# rails generate model Studio name:string
# rails generate model Movie title:string year_released:integer rated:string studio:references
# rails generate model Actor name:string agent:references
# rails generate model Role character_name:string movie:references actor:references
# rails generate model Agent name:string

# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
# TODO!

warner_bros = Studio.create(name: "Warner Bros.")

agent = Agent.create(name: "agent")

bale = Actor.create(name: "Christian Bale", agent: agent)
caine = Actor.create(name: "Michael Caine")
neeson = Actor.create(name: "Liam Neeson")
holmes = Actor.create(name:"Katie Holmes")
oldman = Actor.create(name:"Gary Oldman")
ledger = Actor.create(name:"Heath Ledger")
eckhart = Actor.create(name:"Aaron Eckhart")
gyllenhaal = Actor.create(name:"Maggie Gyllenhaal")
hardy = Actor.create(name:"Tom Hardy")
gordon = Actor.create(name:"Joseph Gordon-Levitt")
hathaway = Actor.create(name:"Anne Hathaway")

batman_begins = Movie.create(title:"Batman Begins", year_released: 2005, rated: "PG-13", studio: warner_bros)
dark_knight = Movie.create(title:"The Dark Knight", year_released:2008, rated: "PG-13", studio: warner_bros)
dark_knight_rises = Movie.create(title:"The Dark Knight Rises", year_released: 2012, rated: "PG-13", studio: warner_bros)

wayne_BB = Role.create(character_name:"Bruce Wayne", movie:batman_begins, actor:bale)
alfred = Role.create(character_name:"Alfred",movie:batman_begins, actor:caine)
ghul = Role.create(character_name: "Ra's Al Ghul", movie:batman_begins, actor:neeson)
dawes = Role.create(character_name: "Rachel Dawes", movie: batman_begins, actor: holmes)
gordon_BB = Role.create(character_name: "Commissioner Gordon", movie: batman_begins, actor: oldman)
wayne_DK = Role.create(character_name:"Bruce Wayne",movie: dark_knight, actor: bale)
joker = Role.create(character_name: "Joker", movie: dark_knight, actor: ledger)
dent = Role.create(character_name: "Harvey Dent", movie: dark_knight, actor: eckhart)
alfred_DK = Role.create(character_name: "Alfred", movie: dark_knight, actor: caine)
dawes_DK = Role.create(character_name: "Rachel Dawes", movie: dark_knight, actor: gyllenhaal)
wayne_DKR = Role.create(character_name: "Bruce Wayne", movie: dark_knight_rises, actor: bale)
gordon_DKR = Role.create(character_name: "Commissioner Gordon", movie: dark_knight_rises, actor: oldman)
bane = Role.create(character_name: "Bane", movie: dark_knight_rises, actor: hardy)
blake = Role.create(character_name: "John Blake", movie: dark_knight_rises, actor: gordon)
kyle = Role.create(character_name: "Selina Kyle", movie: dark_knight_rises, actor: hathaway)


# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
# TODO!
movies = Movie.all

movies.each do |movie|
puts "#{movie.title}  #{movie.year_released}  #{movie.rated}  #{movie.studio.name}"
end

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!

roles = Role.all
roles.each do |role|
  puts "#{role.movie.title}  #{role.actor.name}  #{role.character_name}" 
end

# Prints a header for the agent's list of represented actors output
puts ""
puts "Represented by agent"
puts "===================="
puts ""

# Query the actor data and loop through the results to display the agent's list of represented actors output.
# TODO!
actors = Actor.all
actors.each do |actor|
  if actor.agent== nil
  else
    puts "#{actor.name}"
end
end
