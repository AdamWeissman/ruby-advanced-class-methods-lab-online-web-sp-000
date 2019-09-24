class Song
  
  attr_accessor :name, :artist_name
  @@all = []
 
  def self.all
    @@all
  end
 
  def save
    self.class.all << self
  end
  
  def self.create
    song = Song.new
    song.save
    song
  end
  
  def self.new_by_name(a_string)
    song = self.new
    song.name = a_string
    song
  end
  
  def self.create_by_name(a_string)
    song = self.new
    song.name = a_string
    song.save
    song
  end
  
  def self.find_by_name(this_name)
    Song.all.find {|a_song| a_song.name == this_name}
  end

  def self.find_or_create_by_name(this_name)
    find_by_name(this_name) || create_by_name(this_name)
  end

#the above code -- very interesting... something to remember:
#if create_by_name is the first part of the || statement then the test will fail

  def self.alphabetical
    Song.all.sort_by {|i| i.name}
  end
  
  def self.new_from_filename(string_to_manipulate)
    parts = string_to_manipulate.split(" - ")
    artist = string_to_manipulate[0]
    song_name = string_to_manipulate[1].gsub(".mp3", "")
    
    song = self.create
    song.artist_name = artist
    song.name = song_name
    song.save
  end

end
  


=begin
describe "Song Class Methods" do
  describe '.create' do
    it 'instantiates and saves the song, and it returns the new song that was created' do
      song = Song.create
      expect(song).to be_a(Song)
      expect(Song.all).to include(song)
    end
  end

  describe '.new_by_name' do
    it 'instantiates a song with a name property' do
      song = Song.new_by_name("Blank Space")

      expect(song.name).to eq("Blank Space")
    end
  end

  describe '.create_by_name' do
    it 'instantiates and saves a song with a name property' do
      song = Song.create_by_name("Blank Space")

      expect(song.name).to eq("Blank Space")
      expect(Song.all).to include(song)
    end
  end

  describe '.find_by_name' do
    it 'can find a song present in @@all by name' do
      song_1 = Song.create_by_name("Blank Space")
      song_2 = Song.create_by_name("Hello")
      song_3 = Song.create_by_name("Hotline Bling")

      expect(Song.find_by_name("Hello")).to eq(song_2)
    end

    it 'returns falsey when a song name is not present in @@all' do
      expect(Song.find_by_name("Just The Way You Are")).to be_falsey
    end
  end

  describe '.find_or_create_by_name' do
    it 'invokes .find_by_name and .create_by_name instead of repeating code' do
      expect(Song).to receive(:find_by_name).at_least(1).times
      expect(Song).to receive(:create_by_name).at_least(1).times

      Song.find_or_create_by_name("Alison")
    end

    it 'returns the existing Song object (doesn\'t create a new one) when provided the title of an existing Song' do
      song_1 = Song.find_or_create_by_name("Sometimes")
      song_2 = Song.find_or_create_by_name("Sometimes")

      expect(song_1).to eq(song_2)
    end
    
    it 'creates a new Song object with the provided title if one doesn\'t already exist' do
      blank_space = Song.find_by_name("Blank Space")
      expect(blank_space).to be(nil)

      blank_space = Song.find_or_create_by_name("Blank Space")
      expect(blank_space.name).to eq("Blank Space")
    end
  end

  describe '.alphabetical' do
    it 'returns all the song instances in alphabetical order by song name' do
      song_1 = Song.create_by_name("Thriller")
      song_2 = Song.create_by_name("Blank Space")
      song_3 = Song.create_by_name("Call Me Maybe")

      expect(Song.alphabetical).to eq([song_2, song_3, song_1])
    end
  end

  describe '.new_from_filename' do
    it 'initializes a song and artist_name based on the filename format' do
      song = Song.new_from_filename("Thundercat - For Love I Come.mp3")

      expect(song.name).to eq("For Love I Come")
      expect(song.artist_name).to eq("Thundercat")
    end
  end

  describe '.create_from_filename' do
    it 'initializes and saves a song and artist_name based on the filename format' do
      song = Song.create_from_filename("Thundercat - For Love I Come.mp3")
      song_match = Song.find_by_name("For Love I Come")
      expect(song_match.name).to eq("For Love I Come")
      expect(song_match.artist_name).to eq("Thundercat")
    end
  end

  describe '.destroy_all' do
    it 'clears all the song instances from the @@all array' do
      Song.destroy_all
      expect(Song.all).to eq([])
    end
  end
end
=end