# textobj-backtick.nvim

Textobj for backtick, it is better than default behavior in Neovim that it can choose content in multilines.

For the following sample text, users can use textobj motions to choose/yank/delete/cut content between two backticks.

```go
const SampleString = `  Before this sentence, there

are two white spaces.

And after this sentence, there are three white spaces    `
```

### i` / \<Plug\>(textobj-backtick-i)

No backticks in the beginning and ending, no white spaces in the beginning and ending.

```
Before this sentence, there

are two white spaces.

And after this sentence, there are three white spaces
```

### a` / \<Plug\>(textobj-backtick-a)

All content, include backticks in the beginning and ending.

```
`  Before this sentence, there

are two white spaces.

And after this sentence, there are three white spaces    `
```

### \<Plug\>(textobj-backtick-ia)

No backticks in the beginning and ending, keep white spaces in the beginning and ending.

```
  Before this sentence, there

are two white spaces.

And after this sentence, there are three white spaces  (there are two spaces here, but markdown formatter will trim them automatically)
```

## Install

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
