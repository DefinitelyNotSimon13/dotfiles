{ ... }:
{
  # Install neovim as a plain package so HM never writes ~/.config/nvim/*.
  # All nvim config lives in ~/.dotfiles/nvim/ (symlinked by dotfiles.nix).
  flake.modules.home.neovim = { pkgs, ... }: {
    home.packages = with pkgs; [
      neovim
      # LSP + formatters (must be in PATH for nvim plugins to find them)
      nixd
      lua-language-server
      nixfmt
      stylua
      # tree-sitter CLI + C compiler for nvim-treesitter parser compilation
      tree-sitter
      gcc
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    programs.zsh.shellAliases = {
      vi  = "nvim";
      vim = "nvim";
    };
  };
}
