class GeneratePhotoBigThumbnail < ActiveRecord::Migration
  def up
    say_with_time("Generting big thumbnails...") do
      Photo.all.each do |p|
        say "#{p.id}: p.image"
        (p.image.reprocess! if p.image) Errno::ENOENT
      end
    end
  end

  def down
  end
end
