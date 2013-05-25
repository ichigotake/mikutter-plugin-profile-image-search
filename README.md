# NAME

profile\_image\_search - プロフィール画像検索プラグイン for mikutter

# DESCRIPTION

mikutterのタイムライン上のツイートの右クリックメニューから、発言者のプロフィール画像を画像検索します

# SEARCH ENGINE

- [Google画像検索](https://images.google.com/)

- [二次元画像詳細建策](http://www.ascii2d.net/)

Twitterアイコンの検索精度は *Google画像検索 > 二次元画像詳細検索*

(作者はその人を調べるとっかかりとして利用したり、よくわからない検索結果を見る事を楽しんでます)

# INSTALL

プラグインディレクトリに *profile_image_search/* というディレクトリ名でダウンロードします

    $ git clone https://github.com/ichigotake/mikutter-plugin-profile-image-search ~/.mikutter/plugin/profile_image_search

このプラグインは *mechanize* と *nokogiri* を利用しているので、依存モジュールをインストールする

    $ cd ~/.mikutter/plugin/profile_image_search && bundle install
    
    # or

    $ gem install nokogiri mechanize

# SEE ALSO

[mikutter](http://mikutter.hachune.net/)

# AUTHOR

[@ichigotake](https://twitter.com/ichigotake)

