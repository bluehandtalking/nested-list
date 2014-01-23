class AddArtistIdToTune < ActiveRecord::Migration
  def change
    add_column :tunes, :artist_id, :integer
  end
end
