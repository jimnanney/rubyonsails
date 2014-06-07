folders = Rails.root.join("app/{extends,monkies,railties}/**/*.rb")
Dir[folders].each do |f|
  require f
end

%W(validators decorators errors workers sidekiqs presenters).each do |f|
  ActiveSupport::Dependencies.autoload_paths << \
    Rails.root.join("app/#{f}")
end
