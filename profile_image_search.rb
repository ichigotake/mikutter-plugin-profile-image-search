# -*- coding: utf-8 -*-

require 'net/http'
require 'uri'
require 'mechanize'
require 'nokogiri'

Plugin.create(:profile_image_search) do
    
    SEARCH_ENGINE_GOOGLE = "google"
    SEARCH_ENGINE_ASCII2D = "ascii2d"

    def profile_image_search(msg, engine)
      (Service.primary.twitter/'users/show').json(:screen_name =>msg.message.user.idname).next { |result|

        url = false
        image_url = result[:profile_image_url]
        case engine
        when SEARCH_ENGINE_GOOGLE then url = "https://images.google.com/searchbyimage?image_url=#{image_url}"
        when SEARCH_ENGINE_ASCII2D then url = search_ascii2d(image_url)
        end

        return unless url

        Gtk::openurl(url)
      }
    end

    def search_ascii2d(image_url)
      agent = Mechanize.new;
      agent.user_agent = 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)';
        
      search = agent.get('http://www.ascii2d.net/imagesearch')
      result = search.form_with(:name => 'webform') do |form|
        form.uri = image_url;
      end.submit

      hash = result.root.search('.detailbox .md5')[0].text
        
      return 'http://www.ascii2d.net/imagesearch/similar/' + hash
    end


  #Google画像検索
  command(:profile_image_search_google,
            name: 'アイコンを画像検索する(Google画像検索)',
            condition: Plugin::Command[:HasOneMessage],
            visible: true,
            role: :timeline) do |m|
              m.messages.map do |msg|
                profile_image_search(msg, SEARCH_ENGINE_GOOGLE)
              end
            end

  #二次元画像詳細検索
  command(:profile_image_search_acsii2d,
            name: 'アイコンを画像検索する(二次元詳細画像検索)',
            condition: Plugin::Command[:HasOneMessage],
            visible: true,
            role: :timeline) do |m|
              m.messages.map do |msg|
                profile_image_search(msg, SEARCH_ENGINE_ASCII2D)
              end
            end

end
