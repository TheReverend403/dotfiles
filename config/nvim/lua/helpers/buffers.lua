local M = {}

local close_buffers = require("close_buffers")

M.delete_this = function()
  close_buffers.delete({ type = "this", force = true })
end

M.delete_all = function()
  close_buffers.delete({ type = "all", force = true })
end

M.delete_others = function()
  close_buffers.delete({ type = "other", force = true })
end

return M
