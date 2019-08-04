class Application

  @@items = ["Apples","Carrots","Pears"]
  
  @@cart = []
  
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    #mine 
    elsif req.path.match(/cart/)
      if @@cart.length < 1 
      resp.write "Your cart is empty"
     else 
      @@cart.each do |cart_item|
        resp.write "#{cart_item}\n"
      end 
    end 
    #mine
    elsif req.path.match(/add/)
      search_term = req.params["item"]
      resp.write add_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end
  
  def add_search(search_term)
   if @@items.include?(search_term)
     @@cart << search_term 
     return "added #{search_term}"
   else 
     return "We don't have that item"
   end 
  end 
     
  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
