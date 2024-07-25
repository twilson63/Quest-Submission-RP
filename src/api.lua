local api = { _version = "0.0.1" }
local world = require('@reality/World')
local template = require('@reality/WorldTemplate')

function api.createWorld(name)
  -- create World
  world()
  print('World Created!')
  template(name)
  print('World Template Created!')
  
  return {
    addChat = function () 
      require('@reality/Chat')
      print('Chat Loaded!')
    end,
    addAgent = function ()
      print('TODO: Add Agent')
    end,
    printLink = function ()
      print('https://reality-viewer.g8way.io/#/' .. ao.id)
    end
  }
end

-- function api.createAgent()
--   return {
--     getChat = function() 
    
--     end,
--     move = function ()

--     end
--   }
-- end


return api