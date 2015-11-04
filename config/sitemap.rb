require 'rubygems'
require 'sitemap_generator'
# Set the host name for URL creation
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  SitemapGenerator::Sitemap.default_host = "http://www.holy-land-herbs.com"
  SitemapGenerator::Sitemap.public_path = 'tmp/'
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  SitemapGenerator::Sitemap.create do
    add '/medicinal_herbs', :priority => 0.3
    add '/categories/medicinal-food', :priority => 0.75
    add '/crystals', :priority => 0.1
    add '/clinics', :priority => 0.2
    add '/essential_oils', :priority => 0.5
    add '/categories/cosmetics', :priority => 0.4    
  end

  SitemapGenerator::Sitemap.ping_search_engines
