




local timer = {}




timer.init = function(interval, cb)
   local t = vim.loop.new_timer()
   t:start(interval, interval, vim.schedule_wrap(cb))
   return t
end

timer.deinit = function(t)
   t:stop()
   t:close()
end

return timer