Gem::Specification.new do |gem|
  gem.name = "githuby"
  gem.version = "0.0.1"
  gem.date = "2011-02-06"
  gem.summary = "Ruby bindings for the GitHub API."
  gem.email = "hugomaiavieira@gmail.com"
  gem.homepage = "http://github.com/hugomaiavieira/githuby"
  gem.description = "GitHuby is a Ruby bindings for the GitHub API."
  gem.has_rdoc = true
  gem.authors = ["Hugo Maia Vieira"]
  gem.files = ["README.rdoc", "Rakefile", "githuby.gemspec", "lib/**/*"]
  gem.rdoc_options = ["--main", "README.rdoc"]
  gem.extra_rdoc_files = ["README.rdoc"]
  gem.add_dependency("hashie", [">= 1.0.0"])
end
