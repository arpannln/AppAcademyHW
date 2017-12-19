require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |el| Play.new(el) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end
  
  def self.find_by_title(title)
   play = PlayDBConnection.instance.execute(<<-SQL, title)
     SELECT
       *
     FROM
       plays
     WHERE
       title = ?
   SQL
   return nil unless play.length > 0

   Play.new(play.first)
  end
  
  def self.find_by_playwright(name)
    playwright = Playwright.find_by_name(name)
    raise "not found in DB" if !playwright

    plays = PlayDBConnection.instance.execute(<<-SQL, playwright.id)
      SELECT
        *
      FROM
        plays
      WHERE
        playwright_id = ?
    SQL

    plays.map { |play| Play.new(play) }
  end
 
  def create
    raise "already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "not in database" if !@id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
  
  
end


#Let's add the following methods to our ORM:

# Play::find_by_title(title)
# Play::find_by_playwright(name) (returns all plays written by playwright)
# In addition, create a Playwright class and add the following methods to our ORM.

class Playwright 
  attr_accessor :name, :year 
  attr_reader :id 
  
  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map { |el| Playwright.new(el) }
  end
  

 
 def initialize(options)
   @id = options['id']
   @title = options['title']
   @year = options['year']
   @playwright_id = options['playwright_id']
 end
 
 
 def self.find_by_playwright(name)
   playwright = Playwright.find_by_name(name)
   raise "not found in DB" unless playwright

   plays = PlayDBConnection.instance.execute(<<-SQL, playwright.id)
     SELECT
       *
     FROM
       plays
     WHERE
       playwright_id = ?
   SQL

   plays.map { |play| Play.new(play) }
 end
 
 def create
    raise "already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end
  
  def update
      raise " not in database" if !@id
      PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
        UPDATE
          plays
        SET
          title = ?, year = ?, playwright_id = ?
        WHERE
          id = ?
      SQL
    end

 


  def self.find_by_name(name)
    person = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        playwrights
      WHERE
        name = ?
    SQL
    
    return nil unless person.length > 0 
    
    Playwright.new(person.first)
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create 
    raise "already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year)
      INSERT INTO
        playwrights (name, birth_year)
      VALUES 
        (?, ?) 
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update #good example on how to update database 
    raise "not in database" if !@id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year, @id)
      UPDATE 
        playwrights 
      SET 
        name = ?, birth_year = ? 
      WHERE 
        id = ? 
    SQL
  end

  def get_plays #didn't get this 
    # raise "not in database" if !@id
    # plays = PlayDBConnection.instance.execute(<<-SQL, @id)
    #   SELECT 
    #     * 
    #   FROM 
    #     plays 
    #   WHERE 
    #     playwright_id = ?
    # 
    #   SQL 
    #   plays.map { |play| Play.new(play)}
  end

end
  
# Playwright::all
# Playwright::find_by_name(name)
# Playwright#new (this is the initialize method)
# Playwright#create
# Playwright#update
# Playwright#get_plays (returns all plays written by playwright)
# Remember, our PlayDBConnection class accesses the database stored in plays.db, which includes both the plays and playwrights tables.
