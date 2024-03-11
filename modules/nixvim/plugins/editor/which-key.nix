{
  plugins.which-key = {
    enable = true;

    plugins.spelling.enabled = true;

    registrations = {
      "g" = "+goto";
      "gs" = "+surround";
      "]" = "+next";
      "[" = "+previous";
      "<leader><tab>" = "+tabs";
      "<leader>b" = "+buffers";
      "<leader>c" = "+code";
      "<leader>f" = "+file/find";
      "<leader>g" = "+git";
      "<leader>gh" = "+hunks";
      "<leader>q" = "+quit/session";
      "<leader>s" = "+search";
      "<leader>u" = "+ui";
      "<leader>w" = "+windows";
      "<leader>x" = "+diagnostics/quickfix";
      "<leader>t" = "+test/terminal";
    };
  };
}
