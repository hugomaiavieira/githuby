task :default => [:isolated]

task :isolated do
  sh 'rspec test/isolated'
end

task :integration do
  sh 'rspec test/integration'
end

task :all => [:isolated, :integration]

