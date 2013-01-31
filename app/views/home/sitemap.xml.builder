xml.instruct! :xml, :version => "1.0" 
xml.urlset(:xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9") do
  xml.url do
		xml.loc "http://www.geschenkeheld.de"
		xml.changefreq "daily"
		xml.priority "1.0"
	end
	
	@categories.each do |category|
		xml.url do
			xml.loc "http://www.geschenkeheld.de/#{category.slug}"
			xml.changefreq "daily"
			xml.priority "0.95"
		end
	end
	
	@products.each do |product|
		xml.url do
			xml.loc "http://www.geschenkeheld.de/geschenk/#{product.slug}"
			xml.changefreq "weekly"
			xml.priority "0.5"
		end
	end

	xml.url do
		xml.loc "http://www.geschenkeheld.de/impressum"
		xml.changefreq "never"
		xml.priority "0.05"
	end
end