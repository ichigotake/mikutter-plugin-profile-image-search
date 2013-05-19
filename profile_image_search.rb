# -*- coding: utf-8 -*-

require 'net/http'
require 'uri'
require 'mechanize'
require 'nokogiri'

Plugin.create(:profile_image_search) do

    def get_profile_image_url(msg)
        agent = Mechanize.new
        agent.get("http://api.twitter.com/1/users/profile_image?screen_name=#{msg.message.user.idname}&size=normal")
        return agent.page.uri.to_s
    end

    def _search_ascii2d(msg)
        agent = Mechanize.new;
        agent.user_agent = 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)';
        
        search = agent.get('http://www.ascii2d.net/imagesearch')
        result = search.form_with(:name => 'webform') do |form|
            image_url = get_profile_image_url(msg)
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
                    image_url = get_profile_image_url(msg)
                    Gtk::openurl("https://images.google.com/searchbyimage?image_url=#{image_url}")
                end
            end

  #二次元画像詳細検索
  command(:profile_image_search_acsii2d,
            name: 'アイコンを画像検索する(二次元詳細画像検索)',
            condition: Plugin::Command[:HasOneMessage],
            visible: true,
            role: :timeline) do |m|
                m.messages.map do |msg|
                    url = _search_ascii2d(msg)
                    Gtk::openurl(url)
                end
            end

end
