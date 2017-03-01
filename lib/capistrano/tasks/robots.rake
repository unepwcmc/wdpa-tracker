desc "Uploads a robots.txt that mandates the site as off-limits to crawlers"
task :block_robots do
  content = [
    '# This is a staging site. Do not index.',
    'User-agent: *',
    'Disallow: /'
  ].join($/)
  on roles(:all) do
    within release_path do
      puts "Uploading blocking robots.txt"
      execute(:echo, "\"#{content}\" > public/robots.txt")
    end
  end
end
