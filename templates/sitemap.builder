xml.instruct!
xml.urlset("xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9") do
  # Static paths
  [
    ["/",         "weekly"],
    ["/archives", "weekly"],
    ["/2012",     "weekly"],
    ["/2011",     "yearly"],
    ["/2010",     "yearly"],
    ["/2009",     "yearly"],
    ["/2008",     "yearly"],
  ].each do |path, changefreq|
    xml.url do
      xml.loc "http://#{[@config[:url].sub("http://", ''), path].join('/').squeeze('/')}"
      xml.changefreq changefreq
    end
  end

  # Articles
  articles.each do |article|
    xml.url do
      xml.loc article.url
      xml.changefreq "yearly"
    end
  end
end
