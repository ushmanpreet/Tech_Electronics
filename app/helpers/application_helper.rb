module ApplicationHelper
  def random_shoe_image_url
    response = HTTParty.get('https://picsum.photos/200/300/?random&category=fashion')
    response.headers['Location']
  end
end
