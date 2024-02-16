{
  keymaps = [
    # Saving
    { mode = [ "i" "x" "n" "s" "v" ]; key = "<C-s>"; action = "<cmd>wa<cr><esc>"; options.desc = "Save all files"; }
    { mode = [ "x" "n" "s" "v" ]; key = "<leader>fs"; action = "<cmd>wa<cr><esc>"; options.desc = "Save all files"; }

    # Better up/down
    { mode = [ "x" "n" ]; key = "j"; action = "v:count == 0 ? 'gj' : 'j'"; options = { expr = true; silent = true; }; }
    { mode = [ "x" "n" ]; key = "<Down>"; action = "v:count == 0 ? 'gj' : 'j'"; options = { expr = true; silent = true; }; }
    { mode = [ "x" "n" ]; key = "k"; action = "v:count == 0 ? 'gk' : 'k'"; options = { expr = true; silent = true; }; }
    { mode = [ "x" "n" ]; key = "<Up>"; action = "v:count == 0 ? 'gk' : 'k'"; options = { expr = true; silent = true; }; }

    # Move to window using the hjkl keys
    { mode = [ "n" ]; key = "<C-h>"; action = "<C-w>h"; options = { desc = "Go to left window"; remap = true; }; }
    { mode = [ "n" ]; key = "<C-j>"; action = "<C-w>j"; options = { desc = "Go to lower window"; remap = true; }; }
    { mode = [ "n" ]; key = "<C-k>"; action = "<C-w>k"; options = { desc = "Go to upper window"; remap = true; }; }
    { mode = [ "n" ]; key = "<C-l>"; action = "<C-w>l"; options = { desc = "Go to right window"; remap = true; }; }

    # Resize window using HJKL keys
    # Vim cannot differentiate between hjkl and HJKL for bindings, find a new binding for these that doesn't use arrow keys
    # { mode = [ "n" ]; key = "<C-J>"; action = "<cmd>resize -2<cr>"; options.desc = "Decrease window height"; }
    # { mode = [ "n" ]; key = "<C-K>"; action = "<cmd>resize +2<cr>"; options.desc = "Increase window height"; }
    # { mode = [ "n" ]; key = "<C-H>"; action = "<cmd>vertical resize -2<cr>"; options.desc = "Decrease window width"; }
    # { mode = [ "n" ]; key = "<C-L>"; action = "<cmd>vertical resize +2<cr>"; options.desc = "Increase window width"; }

    # Move lines
    { mode = [ "n" ]; key = "<A-j>"; action = "<cmd>m .+1<cr>=="; options.desc = "Move down"; }
    { mode = [ "n" ]; key = "<A-k>"; action = "<cmd>m .-2<cr>=="; options.desc = "Move up"; }
    { mode = [ "i" ]; key = "<A-j>"; action = "<esc><cmd>m .+1<cr>==gi"; options.desc = "Move down"; }
    { mode = [ "i" ]; key = "<A-k>"; action = "<esc><cmd>m .-2<cr>==gi"; options.desc = "Move up"; }
    { mode = [ "v" ]; key = "<A-j>"; action = ":m '>+1<cr>gv=gv"; options.desc = "Move down"; }
    { mode = [ "v" ]; key = "<A-k>"; action = ":m '<-2<cr>gv=gv"; options.desc = "Move up"; }

    # Buffers
    { mode = [ "n" "v" ]; key = "<leader>bd"; action = "<cmd>bd<cr>"; options.desc = "Delete current buffer"; }
    { mode = [ "n" ]; key = "<S-h>"; action = "<cmd>bprevious<cr>"; options.desc = "Prev buffer"; }
    { mode = [ "n" ]; key = "<S-l>"; action = "<cmd>bnext<cr>"; options.desc = "Next buffer"; }
    { mode = [ "n" ]; key = "[b"; action = "<cmd>bprevious<cr>"; options.desc = "Prev buffer"; }
    { mode = [ "n" ]; key = "]b"; action = "<cmd>bnext<cr>"; options.desc = "Next buffer"; }

    # Clear search with <esc>
    { mode = [ "i" "n" ]; key = "<esc>"; action = "<cmd>noh<cr><esc>"; options.desc = "Escape and clear hlsearch"; }

    # Saner behovior of n and N
    { mode = [ "n" ]; key = "n"; action = "'Nn'[v:searchforward].'zv'"; options = { desc = "Next search result"; expr = true; }; }
    { mode = [ "x" "o" ]; key = "n"; action = "'Nn'[v:searchforward]"; options = { desc = "Next search result"; expr = true; }; }
    { mode = [ "n" ]; key = "N"; action = "'nN'[v:searchforward].'zv'"; options = { desc = "Prev search result"; expr = true; }; }
    { mode = [ "x" "o" ]; key = "N"; action = "'nN'[v:searchforward]"; options = { desc = "Prev search result"; expr = true; }; }

    # Better indenting
    { mode = [ "v" ]; key = ">"; action = ">gv"; }
    { mode = [ "v" ]; key = "<"; action = "<gv"; }

    # New file
    { mode = [ "n" ]; key = "<leader>fn"; action = "<cmd>enew<cr>"; options.desc = "New file"; }

    # Location/Quickfix
    { mode = [ "n" ]; key = "<leader>xl"; action = "<cmd>lopen<cr>"; options.desc = "Location list"; }
    { mode = [ "n" ]; key = "<leader>xq"; action = "<cmd>copen<cr>"; options.desc = "Quickfix list"; }
    { mode = [ "n" ]; key = "[q"; action = "vim.cmd.cprev"; lua = true; options.desc = "Prev quickfix"; }
    { mode = [ "n" ]; key = "]q"; action = "vim.cmd.cnext"; lua = true; options.desc = "Next quickfix"; }

    # Quit
    { mode = [ "n" ]; key = "<leader>qq"; action = "<cmd>qa<cr>"; options.desc = "Quit all"; }

    # Highlights under cursor
    { mode = [ "n" ]; key = "<leader>ui"; action = "vim.show_pos"; lua = true; options.desc = "Quit all"; }

    # Windows
    { mode = [ "n" ]; key = "<leader>ww"; action = "<C-W>p"; options = { desc = "Other window"; remap = true; }; }
    { mode = [ "n" ]; key = "<leader>wd"; action = "<C-W>c"; options = { desc = "Delet window"; remap = true; }; }
    { mode = [ "n" ]; key = "<leader>w-"; action = "<C-W>s"; options = { desc = "Split window below"; remap = true; }; }
    { mode = [ "n" ]; key = "<leader>w|"; action = "<C-W>v"; options = { desc = "Split window right"; remap = true; }; }
    { mode = [ "n" ]; key = "<leader>-"; action = "<C-W>s"; options = { desc = "Split window below"; remap = true; }; }
    { mode = [ "n" ]; key = "<leader>|"; action = "<C-W>v"; options = { desc = "Split window right"; remap = true; }; }
  ];
}