require 'open-uri'

class ReDb
  def initialize
    return Dir.mkdir("redb") if !File.exist?("redb")
  end

  def create_table(table_name)
    return if File.exist?(table_name)
    File.open("./redb/#{table_name}", "w+"){|x| x.write(meta_data(table_name))}
  end

  def read_table(table_name)
    eval(File.open("./redb/#{table_name}", "r+").read)
  end

  def drop_table(table_name)
    File.delete("./redb/#{table_name}")
  end

  def new_data(table_name, data)
    table = read_table(table_name)
    table["#{table['0']['nextId'] += 1}"] = data
    File.open("./redb/#{table_name}", "w+"){|x| x.write(table)}
  end

  private

  def meta_data(table_name)
    {'0' => {'table_name' => "#{table_name}", 'nextId' => 1}}
  end
end
