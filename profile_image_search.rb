# -*- coding: utf-8 -*-

require 'net/http'
require 'uri'
require 'mechanize'

Plugin.create(:profile_image_search) do

    def get_profile_image_url(msg)
        agent = Mechanize.new
        agent.get("http://api.twitter.com/1/users/profile_image?screen_name=#{msg.message.user.idname}&size=normal")
        return agent.page.uri.to_s
    end


  command(:profile_image_search,
            name: 'アイコンを画像検索する(Google画像検索)',
            condition: Plugin::Command[:HasOneMessage],
            visible: true,
            role: :timeline) do |m|
                m.messages.map do |msg|
                    image_url = get_profile_image_url(msg)
                    Gtk::openurl("https://images.google.com/searchbyimage?image_url=#{image_url}")
                end
            end

end
