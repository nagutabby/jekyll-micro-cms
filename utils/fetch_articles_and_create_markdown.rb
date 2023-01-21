require 'open-uri'
require 'json'

result = JSON.load(OpenURI.open_uri("https://jekyll-blog-nagutabby.microcms.io/api/v1/news",
  "X-MICROCMS-API-KEY" => ENV["X_MICROCMS_API_KEY"]
).read)

result["contents"].each do |content|
  updated_at =  DateTime.parse(content["revisedAt"]).strftime("%Y-%m-%d %H:%M:%S %z")
  id = content["id"]
  title = content["title"]
  body = content["body"]
  image_url = content["image"]["url"]

  file = File.open("_posts/#{Date.parse(updated_at).strftime("%Y-%m-%d")}-#{id}.md", "w")
  file.puts("---")
  file.puts("layout: post")
  file.puts("title: #{title}")
  file.puts("date: #{updated_at}")
  file.puts("---")
  file.puts("<img src='#{image_url}' width=200 >")
  file.puts("#{body}")
  file.close
end
puts 'Data fetched successfully.'
