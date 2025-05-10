local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("dart", {
  -- Stateless Widget
  s("stless", fmt([[
import 'package:flutter/material.dart';

class {} extends StatelessWidget {{
  @override
  Widget build(BuildContext context) {{
    return Scaffold(
      appBar: AppBar(
        title: Text('{}'),
      ),
      body: Center(
        child: Text('Hello, Flutter!'),
      ),
    );
  }}
}}]], {
    i(1, "MyWidget"),
    f(function(args) return args[1][1] end, {1})
  })),

  -- Stateful Widget
  s("stful", fmt([[
import 'package:flutter/material.dart';

class {} extends StatefulWidget {{
  @override
  _{}_State createState() => _{}_State();
}}

class _{}_State extends State<{}> {{
  int _counter = 0;

  void _incrementCounter() {{
    setState(() {{
      _counter++;
    }});
  }}

  @override
  Widget build(BuildContext context) {{
    return Scaffold(
      appBar: AppBar(
        title: Text('{}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }}
}}]], {
    i(1, "MyStatefulWidget"),
    f(function(args) return args[1][1] end, {1}),
    f(function(args) return args[1][1] end, {1}),
    f(function(args) return args[1][1] end, {1}),
    f(function(args) return args[1][1] end, {1}),
    f(function(args) return args[1][1] end, {1})
  })),

  -- Container with padding
  s("containerpad", fmt([[
Container(
  padding: const EdgeInsets.all({}),
  margin: const EdgeInsets.all({}),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.black),
    borderRadius: BorderRadius.circular({}),
  ),
  child: {},
)]], {
    i(1, "8.0"),
    i(2, "10.0"),
    i(3, "10"),
    i(4, "Text('Hello Container')")
  })),

  -- Print with green color
  s("printS", fmt(
    "print('\\x1B[32m{} -------------------- ${{{}}}\\x1B[0m');",
    { i(1), f(function(args) return args[1][1] end, {1}) }
  )),

  -- Print with red color
  s("printSr", fmt(
    "print('\\x1B[31m{} -------------------- ${{{}}}\\x1B[0m');",
    { i(1), f(function(args) return args[1][1] end, {1}) }
  )),

  -- Try catch with debug
  s("dtry", fmt([[
try {{
  {}
}} catch(error) {{
  debugPrint('[Error] in {} {}: $error');
  if (dotenv.env['ENVIRONMENT'] == 'development') {{
    _api.fpDebug(null,'[Error] in {} {}: $error');
  }}
}}]], {
    i(2),
    f(function() return vim.fn.expand("%:t:r") end),
    i(1),
    f(function() return vim.fn.expand("%:t:r") end),
    i(1)
  })),
})

-- Extend flutter filetype with dart snippets
ls.filetype_extend("flutter", { "dart" })
