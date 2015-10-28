require "csv"

datasets = CSV.table "source/data/datasets.csv"

namespace :reconstruction do
  def raw_from_reconstructed filename
    dirname = File.dirname filename
    basename = File.basename filename, ".*"
    first, last = basename.split("_").map {|f| f.tr!("S", "").to_i}
    numbers = (first..last).to_a
    numbers.map do |n|
      File.join dirname, "S#{n.to_s.rjust(5, "0")}.hdf5"
    end
  end

  def link_from_reconstructed filename
    basename = File.basename filename
    File.join "source", "data", "rawdata", basename
  end

  datasets.each do |row|
    reconstructed = row[:reconstructed]
    link = link_from_reconstructed reconstructed
    raw = raw_from_reconstructed reconstructed
    csv = link.ext "csv"
    min_pixel = row[:min_pixel]
    max_pixel = row[:max_pixel]

    file reconstructed => raw do |f|
      Dir.chdir "../dpc_reconstruction" do
        sh "flats_every.py --n_flats 1 --steps 19 --flats_every 1 #{f.prerequisites.join(" ")}"
      end
    end

    file link => reconstructed do |f|
      ln_sf reconstructed, f.name
    end

    file csv => [link, "source/data/rawdata/hdf2csv.py"] do |f|
      Dir.chdir "source/data/rawdata" do
        sh "python #{f.prerequisites.second} #{f.prerequisites.first} --crop #{min_pixel} #{max_pixel}"
      end
    end

  end
end

task :default => datasets[:reconstructed] do
end
