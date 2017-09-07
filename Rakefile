require "csv"
require "rake/clean"

datasets = CSV.table "source/data/datasets.csv"

def reconstructed_from_raw sample, flat
  file1 = File.basename(sample, ".*")
  file2 = File.basename(flat, ".*")
  dir = File.dirname(sample)
  File.join(dir, "#{file1}_#{file2}.h5")
end

datasets[:reconstructed] = datasets[:sample].zip(
  datasets[:flat]).map {|s, f| reconstructed_from_raw(s, f)}

def roi_from_reconstructed reconstructed
    File.join(["source/data/roi", File.basename(reconstructed, ".h5") + ".roi"])
end

def csv_from_reconstructed reconstructed
    File.join(["source/data/csv", File.basename(reconstructed, ".h5") + ".csv"])             
end
datasets[:csv] = datasets[:reconstructed].map {|f| csv_from_reconstructed(f)}
datasets[:roi] = datasets[:reconstructed].map {|f| roi_from_reconstructed(f)}


namespace :reconstruction do

  datasets.each do |row|
    reconstructed = row[:reconstructed]
    CLEAN.include(reconstructed)

    desc "dpc_reconstruction of #{reconstructed}"
    file reconstructed => [row[:sample], row[:flat]] do |f|
      Dir.chdir "../dpc_reconstruction" do
        sh "dpc_radiography --drop_last --group /entry/data #{f.prerequisites.join(' ')}"
      end
    end
  end

  desc "csv with reconstructed datasets"
  file "source/data/reconstructed.csv" => datasets[:reconstructed] do |f|
    File.open(f.name, "w") do |file|
      file.write(datasets.to_csv)
    end
  end
  CLOBBER.include("source/data/reconstructed.csv")

end


namespace :rectangle_selection do

  datasets.each do |row|

    desc "select the roi for #{row[:reconstructed]}"
    file row[:roi] => ["source/data/rectangle_selection.py", row[:reconstructed]] do |f|
      sh "python #{f.prerequisites[0]} #{f.prerequisites[1]} #{f.name}"
    end

    desc "export selection to #{row[:csv]}"
    file row[:csv] => ["source/data/rectangle_data.py", row[:reconstructed], row[:roi]] do |f|
      sh "python #{f.prerequisites[0]} #{f.prerequisites[1]} #{f.prerequisites[2]} #{f.name}"
    end

    CLOBBER.include(row[:roi])
    CLEAN.include(row[:csv])

  end

end

namespace :summary do

  desc "merge the csv datasets into one table"
  file "data/pixels.rds" => ["data/merge_datasets.R", "source/data/reconstructed.csv"] + datasets[:csv] do |f|
    sh "./#{f.prerequisites[0]} -f #{f.prerequisites[1]} -o #{f.name}"
  end

  desc "build summary"
  file "data/summary.rds" => ["data/build_summary.R", "data/pixels.rds"] do |f|
    sh "./#{f.prerequisites[0]} #{f.prerequisites[1]} #{f.name}"
  end

  desc "single dataset plots"
  file "data/ratio.png" => ["data/single_dataset_histogram.R", "data/summary.rds"] do |f|
    sh "./#{f.prerequisites[0]} #{f.prerequisites[1]} #{f.name}"
  end
  CLOBBER.include("data/ratio.png")

  task :all => "data/ratio.png"

end


namespace :theory do

  desc "calculate theoretical dfec"
  file "data/dfec_structure_factor.csv" => [
    "data/build_dfec_structure_factor.py",
  ] do |f|
    sh "python #{f.prerequisites[0]} --output #{f.name}"
  end

  file "source/data/theory/12-full-spectrum.csv" => [
    "source/data/theory/theoretical_curves.py",
    "source/data/spectra/U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa.csv",
  ] do |f|
    sh "python #{f.prerequisites[0]} #{f.prerequisites[1]} --thickness 1.2 --output #{f.name}"
  end

  file "source/data/theory/45-full-spectrum.csv" => [
    "source/data/theory/theoretical_curves.py",
    "source/data/spectra/U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa.csv",
  ] do |f|
    sh "python #{f.prerequisites[0]} #{f.prerequisites[1]} --thickness 4.5 --output #{f.name}"
  end

  file "source/data/theory/12-copper.csv" => [
    "source/data/theory/theoretical_curves.py",
    "source/data/spectra/U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa.csv",
  ] do |f|
    sh "python #{f.prerequisites[0]} #{f.prerequisites[1]} --thickness 1.2 --additional_filter_material Cu --additional_filter_density 8.92 --additional_filter_thickness 0.1 --output #{f.name}"
  end

  task :all => [
    "source/data/theory/12-full-spectrum.csv",
    "source/data/theory/45-full-spectrum.csv",
    "source/data/theory/12-copper.csv",
  ]
  CLOBBER.include([
    "source/data/theory/12-full-spectrum.csv",
    "source/data/theory/45-full-spectrum.csv",
    "source/data/theory/12-copper.csv",
  ])

end


namespace :fit do

  file "data/fit.rds" => [
    "data/fit.R",
    "data/summary.rds",
    "data/model.R",
    "data/dfec_structure_factor.csv"
  ] do |f|
    sh "./#{f.prerequisites[0]} #{f.prerequisites[1]} #{f.name}"
  end
  CLEAN.include("data/fit.rds")

  desc "print pars"
  file "data/fit_pars.json" => ["data/print_pars.R", "data/fit.rds"] do |f|
    sh "./#{f.prerequisites[0]} #{f.prerequisites[1]} #{f.name}"
  end

  file "data/fit_prediction.rds" => [
    "data/print_prediction.R",
    "data/fit.rds",
    "data/model.R",
  ] do |f|
    sh "./#{f.prerequisites[0]} #{f.prerequisites[1]} #{f.name}"
  end

  file "data/fit.rds" => Rake::Task["theory:all"].prerequisites
  task :fit => "data/fit.rds"
  task :pars => "data/fit_pars.json"
  task :prediction => "data/fit_prediction.json"
  task :all => [:fit, :pars, :prediction]
  CLOBBER.include([
    "data/fit.rds",
    "data/fit_pars.json",
    "data/fit_prediction.json"
  ])

end


namespace :ggplot do

  desc "summary with fit"
  file "data/summary.png" => ["data/plot.R", "data/summary.rds", "data/fit_prediction.rds"] do |f|
    sh "#{f.prerequisites.join(" ")} #{f.name} data/full_summary.png"
  end

  file "data/structure.factor.influence.png" => ["data/plot_structure_factor_influence.R", "data/summary.json", "data/fit_prediction.json"] do |f|
    sh "#{f.prerequisites.join(" ")} #{f.name} data/summary.structure.factor.png"
  end

  file "data/summary.structure.factor.png" => "data/structure.factor.influence.png"

  file "data/variance.png" => ["data/plot_variance.R", "data/build_summary.csv"] do |f|
    sh "#{f.prerequisites.join(" ")} #{f.name}"
  end

  task :all => [
    "data/summary.png",
    "data/structure.factor.influence.png",
    "data/summary.structure.factor.png",
    "data/variance.png"
  ]
  CLOBBER.include([
    "data/summary.png",
    "data/structure.factor.influence.png",
    "data/summary.structure.factor.png",
    "data/variance.png"
  ])

end

task :default => ["theory:all", "fit:all", "ggplot:all"]
