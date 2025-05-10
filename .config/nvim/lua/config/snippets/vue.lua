local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("vue", {
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
await new Promise((resolve) => {{
  let promiseCount = 0;
  {}.forEach(({}) => {{
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
return new Promise((resolve, reject) => {{
  try {{
    if (!{}.length > 0) {{
      resolve();
    }}
    let promiseCount = 0;
    {}.forEach(({}) => {{
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
  s(".sortArrayOfObjects", t(".sort((a, b) => (a.order > b.order ? 1 : -1));")),

  -- forEach
  s(".each", fmt([[
.forEach({} => {{
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
  s("sleep", t("await new Promise((resolve) => setTimeout(resolve, 1000));")),

  -- Error log
  s("error", fmt(
    "console.error('[Error] in {}: ', error);",
    { i(1) }
  )),

  -- Try catch
  s("try", fmt([[
try {{
  {}
}} catch(error) {{
  console.error('[Error] in {} {}: ', error);
}}]], {
    i(2),
    f(function() return vim.fn.expand("%:t:r") end),
    i(1)
  })),

  -- Headers sent check
  s("hS", t("if (res?.headersSent) return;")),

  -- Vue 3 base template
  s({
    trig = "setup",
    name = "Vue 3 Setup",
    dscr = "Create a full Vue 3 setup"
  },
  fmt(
    [[
<template>
<div>
<MainButton
v-if="systemViewActive"
class="btn-wide btn-back mt-3 ml-3"
:label="$t('general.button.back')"
@click="backToOrganizations"></MainButton>
</div>
</template>

<script setup>
//* VUE
/* import {{ ref }} from 'vue'; */

//* COMPOSABLES
import {{ getVariables }} from '@/composables/mainVariables'

//* GRAPHQL

//* VUELIDATE

//* CUSTOM
import {{ useRouter }} from 'vue-router'

//* COMPONENTS

//* CONTROLLERS

//* LOAD INITIAL
const {{ systemViewActive, getLocale }} = getVariables()
const router = useRouter()

//* VARIABLES

//* QUERYS

//* COMPUTED

//* METHODS
const backToOrganizations = () => router.push(`/${{getLocale()}}/admin/organization`)

//* MOUNTED

//* CREATED

</script>

<style lang='scss' scoped>
@import '@/assets/styles/views/$TM_FILENAME_BASE.scss';
</style>
    ]],
    {}
  )),
})
