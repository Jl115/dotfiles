local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("rust", {
  -- Struct with implementation
  s("rcs", fmt([[
pub struct {} {{
    {}: {},
}}

impl {} {{
    pub fn new({}: {}) -> Self {{
        Self {{ {} }}
    }}

    pub fn run(&self) {{
        {}
    }}
}}]], {
    i(1),
    i(2), i(3),
    f(function(args) return args[1][1] end, {1}),
    f(function(args) return args[2][1] end, {2}),
    f(function(args) return args[3][1] end, {3}),
    f(function(args) return args[2][1] end, {2}),
    i(0)
  })),

  -- Enum with variants
  s("renum", fmt([[
pub enum {} {{
    {},
    {},
}}

impl {} {{
    pub fn run(&self) {{
        match self {{
            Self::{} => println!("{} variant"),
            Self::{} => println!("{} variant"),
            _ => {{}},
        }}
    }}
}}]], {
    i(1),
    i(2), i(3),
    f(function(args) return args[1][1] end, {1}),
    f(function(args) return args[2][1] end, {2}),
    f(function(args) return args[2][1] end, {2}),
    f(function(args) return args[3][1] end, {3}),
    f(function(args) return args[3][1] end, {3})
  })),

  -- Trait definition
  s("rtrait", fmt([[
pub trait {} {{
    fn {}(&self);
}}

impl {} for {} {{
    fn {}(&self) {{
        {}
    }}
}}]], {
    i(1),
    i(2),
    f(function(args) return args[1][1] end, {1}),
    i(3),
    f(function(args) return args[2][1] end, {2}),
    i(0)
  })),

  -- Test function
  s("rtest", fmt([[
#[cfg(test)]
mod tests {{
    use super::*;

    #[test]
    fn {}() {{
        assert_eq!({}, {});
    }}
}}]], {
    i(1),
    i(2), i(3)
  })),

  -- Main function
  s("rmain", fmt([[
fn main() {{
    {}
}}]], {
    i(1)
  })),
})