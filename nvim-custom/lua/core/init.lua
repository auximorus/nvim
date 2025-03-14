local opt = require("core.options")
local set = vim.opt
local G = vim.g
local B = vim.b
local W = vim.w
local T = vim.t


G.mapleader = " "
for k,v in pairs(opt.val) do
  set[k] = v
end

for k,v in pairs(opt.bools) do
  set[k] = v
end
