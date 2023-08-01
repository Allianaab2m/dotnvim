return {
  "sainnhe/edge",
  lazy = false,
  config = function ()
    vim.g["edge_style"] = "aura"
    vim.g["edge_dim_foreground"] = 1
    vim.g["edge_dim_inactive_windows"] = 1
    vim.g["edge_better_performance"] = 1
    vim.cmd[[ colorscheme edge ]]
  end
}
