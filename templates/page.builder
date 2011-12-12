def fix html
  doc = Nokogiri::HTML(html)

  # Replace relative URLS with absolute URLs
  doc.xpath('//@href|//@src').each do |url|
    url.value = @config[:url] + url.value.sub(/^\//, '') if url.value =~ /^(?!\w+:\/\/).*/
  end

  # Strip syntax highlighter metadata
  doc.xpath('//code[starts-with(text(),\':::\')]').each do |node|
    node.content = node.content.to_s.sub! /^:::\w+\s*\n/, ''
  end

  doc.at('body').inner_html
end

xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title @config[:title]
  xml.id @config[:url]
  xml.updated articles.first[:date].iso8601 unless articles.empty?
  xml.author { xml.name @config[:author] }

  articles.reverse[0...10].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => article.url
      xml.id article.url
      xml.published article[:date].iso8601
      xml.updated article[:date].iso8601
      xml.author { xml.name @config[:author] }
      # xml.summary article.summary, "type" => "html"
      xml.content fix(article.body), "type" => "html"
    end
  end
end
