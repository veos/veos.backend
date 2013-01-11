class GeneratePhotoBigThumbnail < ActiveRecord::Migration
  def up
    Photo.all.each {|p| p.image.reprocess! if p.image }
  end

  def down
  end
end
