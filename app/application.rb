require 'pry'

class Application

    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        
        # binding.pry
        if req.path.match(/items/)
            item = req.path.split("/items/")[1]
            cart_item = @@items.find do |store_item|
                store_item.name == item
            end
            if cart_item == nil  #Returns an error and 400 if the item is not there
                resp.write "Item not found"
                resp.status = 400
            else
                resp.write cart_item.price #Returns item price if it is in @@item
            end
        else
            resp.write "Route not found"
            resp.status = 404  #Returns 404 for a bad route
        end



        resp.finish
    end


end