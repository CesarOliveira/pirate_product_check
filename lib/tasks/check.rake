namespace :check do

  task product: :environment do
    data = search_product(ARGV[1])
    if(data['paging']['total'].to_i > 0)
      sweep(data['results'])
    end
  end

  def search_product(search_product)
    default_url = 'https://api.mercadolibre.com/sites/MLB/search'

    response = HTTParty.get(URI.encode("#{default_url}/?q=#{search_product}&limit=200"))

    return JSON.parse(response.body)
  end

  def sweep(products)
    products.each do |product|
      notify(product) if product_not_notified(product['id'])
    end
  end

  def product_not_notified(id)
    Product.where(identifier: id).empty?
  end

  def notify(product)
    product_name = I18n.transliterate(product['title']).downcase

    if (product_name.include? ARGV[1])
      Product.create(name: product['title'], value: product['price'].to_f, identifier: product['id'])
      UserNotificationMailer.new_possible_pirate_product_found(product).deliver_now
    else
      puts "Titulo do produto nao bate #{product['title']}"
    end
  end
end
