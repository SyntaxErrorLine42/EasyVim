return{
  "kylechui/nvim-surround",
  version = "*", -- use latest stable
  config = function()
    require("nvim-surround").setup({
      surrounds = {
        ["("] = {
          add = function()
            return { "(", ")" }
          end,
        },
        ["["] = {
          add = function()
            return { "[", "]" }
          end,
        },
        ["{"] = {
          add = function()
            return { "{", "}" }
          end,
        },
        ['"'] = {
          add = function()
            return { '"', '"' }
          end,
        },
        ["'"] = {
          add = function()
            return { "'", "'" }
          end,
        },
        ["<"] = {
          add = function()
            return { "<", ">" }
          end,
        },
      },
    })
  end
}

-- I added the surround because I don't like the native space between the braces when using the key for opening braces
-- For instance if u typed ysiw( you would get ( Hello world! ), I'on like that

-- Now this is maybe the greatest simple plugin I've ever seen
-- You might take some time to get used to it but once you do it's gonna be so satisfying
-- Here is a simple manual from the github:

-- "Hello world!"
-- cs"' to change it to
-- 'Hello world!'

-- Now press cs'<q> to change it to
-- <q>Hello world!</q>

-- To go full circle, press cst" to get
-- "Hello world!"

-- To remove the delimiters entirely, press ds".
-- Hello world!

-- Now with the cursor on "Hello", press ysiw] (iw is a text object).
-- [Hello] world!

-- Let's make that braces and add some space (use } instead of { for no space): cs]{
-- { Hello } world!

-- Now wrap the entire line in parentheses with yssb or yss).
-- ({ Hello } world!)

-- Revert to the original text: ds{ds)
-- Hello world!

-- Emphasize hello: ysiwt<em>
-- <em>Hello</em> world!

-- Finally, let's try out visual mode. Press a capital V (for linewise visual mode) followed by St<p class="important">.
-- <p class="important">
--   <em>Hello</em> world!
-- </p>
