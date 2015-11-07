class Admin::GifGenerator
  def self.generate(name)
    connection = Hurley::Client.new "https://api.giphy.com"
    formatted_name = name.gsub(' ', '+')
    request = "/v1/gifs/search?q=#{formatted_name}&api_key=dc6zaTOxFJmzC&limit=1"
    response = connection.get(request)
    image_path = JSON.parse(response.body)['data'].first['images']['original']['url']
    if image_path
       category = Category.find_or_create_by(name: name)
       Gif.new(image_path: image_path, category_id: category.id)
    else
      Gif.new
    end
  end
end
