require 'erb'

$app_name = 'MyApp'
$app_version = '0.1'

task :exe do
  sh %{ ocra applaunch.rb app --output #{$app_name}.exe }
end

task :installer => :inno_iss_file do
  sh %{ ocra applaunch.rb app --output #{$app_name}.exe --chdir-first --no-lzma --innosetup #{$app_name}.iss }
end

task :inno_iss_file do
  File.open("#{$app_name}.iss", "w") do |f|
    f.write(ERB.new(File.read("template.iss.erb")).result(binding))
  end
end
