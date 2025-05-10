local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("javascript", {
  -- Print to server console
  s("logS", fmt(
    "console.log('\\x1b[33m%s\\x1b[0m', '{}--------------------', {});",
    { i(1), i(1) }
  )),

  -- Add todo comment
  s("todo", fmt(
    "/* <!-- TODO: {} --> */",
    { i(1) }
  )),

  -- Add a break
  s("break", t("throw new Error('Break');")),

  -- Promise without catch
  s("promisew", fmt([[
await new Promise(function(resolve) {{
  let promiseCount = 0;
  {}.forEach(function({}) {{
    {}
    promiseCount++;
    if (promiseCount == {}.length) {{
      resolve();
    }}
  }});
}});]], {
    i(1), i(2), i(3), i(1)
  })),

  -- Promise with catch
  s("promise", fmt([[
return new Promise(function(resolve, reject) {{
  try {{
    if (!{}.length > 0) {{
      resolve();
    }}
    let promiseCount = 0;
    {}.forEach(function({}) {{
      {}
      promiseCount++;
      if (promiseCount == {}.length) {{
        resolve();
      }}
    }});
  }} catch (error) {{
    reject(new Error(`[Error] in {} {}: ${{error}}`));
  }}
}});]], {
    i(1), i(1), i(2), i(3), i(1),
    f(function() return vim.fn.expand("%:t:r") end),
    i(4)
  })),

  -- Sort array of objects
  s(".sortArrayOfObjects", t('.sort(function(a, b) { return a.order > b.order ? 1 : -1; });')),

  -- forEach
  s(".each", fmt([[
.forEach(function({}) {{
  {}
}});]], {
    i(1), i(2)
  })),

  -- Unbind
  s("unbind", fmt(
    "JSON.parse(JSON.stringify({}))",
    { i(1) }
  )),

  -- Sleep
  s("sleep", t("await new Promise(function(resolve) { setTimeout(resolve, 1000); });")),

  -- Error log
  s("error", fmt(
    "console.error('[Error] in {}: ', error);",
    { i(1) }
  )),

  -- Try catch with server response
  s("try", {
    t({"try {",
      "  "}),
    i(2),
    t({"",
      "} catch(error) {",
      "  console.error('[Error] in "}),
    i(1),
    t({"': ', error);",
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

  -- Headers sent check
  s("hS", t("if (res?.headersSent) return;")),

  -- Two Promises
  s("promises", fmt([[
await new Promise(function(resolve) {{
  let promiseCount = 0;
  {}.forEach(function({}) {{
    await new Promise(function(secondResolve) {{
      let secondPromiseCount = 0;
      {}.forEach(function({}) {{
        {}
        secondPromiseCount++;
        if (secondPromiseCount == {}.length) {{
          secondResolve();
        }}
      }});
    }});
    promiseCount++;
    if (promiseCount == {}.length) {{
      resolve();
    }}
  }});
}});]], {
    i(1), i(1), i(2), i(2), i(3), i(2), i(1)
  })),

  -- Migration
  s("migration", fmt([[
  if (process.env.NODE_ENV === 'local' || process.env.NODE_ENV === 'development') {{
    return;
  }}
  
  const transaction = await queryInterface.sequelize.transaction();
  
  try {{
    {}
    return transaction.commit();
  }} catch (error) {{
    await transaction.rollback();
    throw error;
  }}]], {
    i(1, "// Add migration code here")
  })),
  -- Loading Component
  s("loadingComponent", t([[
<LoadingComponent :displayLoading='displayLoading' />
import LoadingComponent from '@/components/LoadingComponent';]])),

  -- Toast Component
  s("toastComponent", t([[
<ToastComponent @toastConfirmed='onToastConfirm' />
const ToastComponent = defineAsyncComponent(() => import('@/components/ToastComponent'));
import { useToast } from 'primevue/usetoast';
const toast = useToast();]]))
})
