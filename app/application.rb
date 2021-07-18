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
            if cart_item == nil
                resp.write "Item not found"
                resp.status = 400
            else
                resp.write cart_item.price
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        


        resp.finish
    end


end