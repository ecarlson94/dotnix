{
  programs.nixvim.autoCmd = [
    # Automatically trim all whitespace an save
    {
      event = ["BufWritePre"];
      pattern = ["*"];
      command = ":%s/\\s\\+$//e";
    }
  ];
}
