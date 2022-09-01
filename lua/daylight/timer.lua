




local timer = {}




timer.init = function(interval, cb)
   local t = vim.loop.new_timer()
   t:start(interval, interval, function()
      cb()
   end)
   return t
end

timer.deinit = function(t)
   t:stop()
   t:close()
end

return timer