# textobj-backtick.nvim

Textobj for backtick, this plugin is better than default behavior in Neovim that it allows user to choose content in multilines.

## 1. Example

For the following sample text, users can use textobj motions to choose/yank/delete/cut content between two backticks.

```go
const SampleString = `  SELECT
  id,
  first_name,
  last_name,
  gender,
  age
from
  user
where id = $1;  `
```

### 1.1 Trim backticks and white spaces around

Keymap: `` i` ``

Complex keymap: `<Plug>(textobj-backtick-i)`

No backticks in the beginning and ending, no white spaces in the beginning and ending.

```sql
SELECT
  id,
  first_name,
  last_name,
  gender,
  age
from
  user
where id = $1;
```

### 1.2 Keep all backticks and white spaces around

Keymap: `` a` ``

Complex keymap: `<Plug>(textobj-backtick-a)`

```sql
`  SELECT
  id,
  first_name,
  last_name,
  gender,
  age
from
  user
where id = $1;  `
```

### 1.3 Trim backticks only, keep all white spaces around

This case doesn't have keymap in default, you can add keymap by yourself in config.

Complex keymap: `<Plug>(textobj-backtick-ia)`

```sql
  SELECT
  id,
  first_name,
  last_name,
  gender,
  age
from
  user
where id = $1;  (there are two tailing spaces here)
```

## 2. Install

Lazy

```lua
{
    "keaising/textobj-backtick.nvim",
    config = function()
        require("textobj-backtick").setup({})
    end,
},
```

Default config

```lua
require("textobj-backtick").setup({
    -- no backticks, no white spaces
    inner_trim_key = "i`"

    -- no backtick, keep white spaces
    -- empty content will be ignore.
    inner_all_key = "",

    -- all content, include backticks
    around_key = "a`"
})
```

## 3. Use case

Set following keymap in Neovim.

```
nnoremap <leader>vv v<Plug>(textobj-backtick-i) :!pg_format<CR>
```

By `<leader>vv`, users can visual select content in backticks and format it with `pg_format`

```go
const SampleString = `
SELECT
  id,
  first_name,
  last_name,
  gender,
  age
FROM
  user
WHERE
  id = $1;
`
```
