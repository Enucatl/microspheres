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

  FileList[datasets[:reconstructed]].each do |reconstructed|
    file reconstructed => raw_from_reconstructed(reconstructed) do |f|
      p f.prerequisites
    end
  end
end

task :default => datasets[:reconstructed] do
end
