require "csv"

datasets = CSV.table "source/data/datasets.csv"
summary = []


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

  def csv_from_reconstructed filename
    link_from_reconstructed(filename).ext("csv")
  end

  datasets.each do |row|
    reconstructed = row[:reconstructed]
    link = link_from_reconstructed reconstructed
    raw = raw_from_reconstructed reconstructed
    csv = csv_from_reconstructed reconstructed
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
      sh "python #{f.prerequisites[1]} #{f.prerequisites[0]} --crop #{min_pixel} #{max_pixel}"
    end
  end

end


namespace :summary do

  file "data/build_summary.csv" => datasets[:reconstructed].map {|reconstructed| csv_from_reconstructed(reconstructed)} do |f|
    datasets.each do |row|
      row[:csv] = csv_from_reconstructed(row[:reconstructed])
      summary << row
    end
    CSV.open(f.name, "w", write_headers: true, headers: datasets.headers) do |csv|
      summary.each do |row|
        csv.puts row
      end
    end
  end

  file "data/build_summary.csv" => "source/data/datasets.csv"

  file "data/summary.json" => ["data/build_summary.R", "data/build_summary.csv"] do |f|
    sh "./#{f.prerequisites[0]} #{f.prerequisites[1]} #{f.name}"
  end

  task :all => "data/summary.json"

end


namespace :fit do

  file "data/fit.rds" => [
    "data/fit.R",
    "data/summary.json",
    "data/model.R"
  ] do |f|
    sh "./#{f.prerequisites[0]} #{f.prerequisites[1]} #{f.name}"
  end

  file "data/fit_prediction.json" => [
    "data/print_prediction.R",
    "data/fit.rds",
    "data/model.R",
  ] do |f|
    sh "./#{f.prerequisites[0]} #{f.prerequisites[1]} #{f.name}"
  end

  task :fit => "data/fit.rds"
  task :print => ["data/fit12_full_spectrum.rds", "data/fit45_full_spectrum.rds", "data/fit12_Cu1mm.rds"]
  task :prediction => "data/fit_prediction.json"

end


namespace :theory do

  task :all => [
    "source/data/theory/12-full-spectrum.csv",
    "source/data/theory/45-full-spectrum.csv",
    "source/data/theory/12-copper.csv",
  ]

  file "source/data/theory/12-full-spectrum.csv" => [
    "source/data/theory/theoretical_curves.py",
    "source/data/spectra/U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa.csv",
  ] do |f|
    sh "python #{f.prerequisites[0]} #{f.prerequisites[1]} --thickness 12 --output #{f.name}"
  end

  file "source/data/theory/45-full-spectrum.csv" => [
    "source/data/theory/theoretical_curves.py",
    "source/data/spectra/U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa.csv",
  ] do |f|
    sh "python #{f.prerequisites[0]} #{f.prerequisites[1]} --thickness 45 --output #{f.name}"
  end

  file "source/data/theory/12-copper.csv" => [
    "source/data/theory/theoretical_curves.py",
    "source/data/spectra/U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa.csv",
  ] do |f|
    sh "python #{f.prerequisites[0]} #{f.prerequisites[1]} --thickness 12 --additional_filter_material Cu --additional_filter_density 8.92 --additional_filter_thickness 0.1 --output #{f.name}"
  end

end
