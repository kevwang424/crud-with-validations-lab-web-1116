class Song < ActiveRecord::Base
  validates :title, presence: true
  validate :unique_title
  # validates :release_year, presence: true, inclusion: {maximum: Date.today.year}
  validates :release_year, presence: true, if: :released?, numericality: {less_than_or_equal_to: Date.today.year}
  validates :artist_name, presence: true

  private

  def unique_title
    @songs = Song.where(title: self.title)

    @songs.each do |song|
      if song.artist_name == self.artist_name && song.release_year == self.release_year
        errors.add(:title, "Artist already wrote this song this year")
      end
    end

  end

end
