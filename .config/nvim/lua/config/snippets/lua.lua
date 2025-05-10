local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("lua", {
  -- Basic utilities
  s("req", fmt(
    "local {} = require('{}')",
    { i(1), i(2) }
  )),

  s("loc", fmt(
    "local {} = {}",
    { i(1), i(2) }
  )),

  s("ret", fmt(
    "return {}",
    { i(1) }
  )),

  -- Functions and modules
  s("fun", fmt([[
local function {}({})
  {}
end]], {
    i(1),
    i(2),
    i(3)
  })),

  s("mod", fmt([[
local M = {{}}

function M.{}({})
  {}
end

return M]], {
    i(1),
    i(2),
    i(3)
  })),

  -- Control structures
  s("if", fmt([[
if {} then
  {}
end]], {
    i(1),
    i(2)
  })),

  s("for", fmt([[
for {}, {} in pairs({}) do
  {}
end]], {
    i(1),
    i(2),
    i(3),
    i(4)
  })),

  -- Debug/print
  s("print", fmt(
    'print("[{}] ", {})',
    { i(1, "label"), i(2) }
  )),
})