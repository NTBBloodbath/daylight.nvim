-- ┌                                                          ┐
-- │  Copyright (c) 2022 NTBBloodbath. All rights reserved.   │
-- │  Use of this source code is governed by a GPL3 license   │
-- │          that can be found in the LICENSE file.          │
-- └                                                          ┘
local record timer
  init: function(interval: number, cb: function): vim.loop.Timer
  deinit: function(t: vim.loop.Timer)
end

timer.init = function(interval: number, cb: function): vim.loop.Timer
  local t = vim.loop.new_timer() as vim.loop.Timer
  t:start(interval, interval, function()
    cb()
  end)
  return t
end

timer.deinit = function(t: vim.loop.Timer)
  t:stop()
  t:close()
end

return timer
