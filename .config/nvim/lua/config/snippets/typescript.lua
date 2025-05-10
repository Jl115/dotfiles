local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt

-- JavaScript and Vue shared snippets
ls.add_snippets("javascript", {
  -- Console error snippet
  s("cerr", {
    t("[Error] in "),
    i(1),
    t(": "),
    t("', error);"),
  }),

  -- Try-catch server snippet
  s("trys", {
    t({"try {",
      "  "}),
    i(2),
    t({"",
      "} catch(error) {",
      "  console.error('[Error] in "}),
    i(1),
    t({"': ', error);",
      "  if (res?.headersSent) return;",
      "  return res.status(500).send({",
      "    status: false,",
      "    code: 500,",
      "    detail: `[Error] in "}),
    i(1),
    t({"`,",
      "    message: `Internal Server Error`,",
      "  });",
      "}"}),
  }),

  -- Function with try-catch snippet
  s("function", {
    t("const "),
    i(1),
    t({" = () => {",
      "  try {",
      "    "}),
    i(2),
    t({"",
      "  } catch(error) {",
      "    console.error('[Error] in "}),
    i(1),
    t({"': ', error);",
      "  }",
      "}"}),
  }),

  -- Headers sent snippet
  s("hS", {
    t("if (res?.headersSent) return;"),
  }),
})