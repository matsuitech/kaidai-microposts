module MicropostsHelper
    def render_with_hashtags(content)
        content.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/hashtags/#{word.delete("#")}/microposts"}.html_safe
    end
end