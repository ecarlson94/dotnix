{ theme }:
let
  radius = "${builtins.toString theme.radius}px";
in
with theme.colors; ''
  * {
    border: none;
    border-radius: ${radius};
    font-family: "Fira Code";
    font-size: 13px;
  }

  #clock,
  #cpu,
  #memory,
  #disk,
  #network,
  #battery,
  #pulseaudio,
  #window,
  #tray {
    padding: 5px 15px;
    border-radius: ${radius};
    background: ${base};
    color: ${primaryAccent};
    margin: 5px 2px;
    transition: all 0.3s ease;
    font-weight: bold;
  }

  #clock {
    color: ${tertiaryAccent};
  }

  #cpu {
    color: ${secondaryAccent}
  }

  #memory {
    color: ${yellow}
  }

  #pulseaudio {
    color: ${rosewater}
  }

  #network {
    color: ${lavender}
  }

  #window {
    background-color: transparent;
    box-shadow: none;
  }

  window#waybar {
    background-color: rgba(0, 0, 0, 0.096);
    border-radius: ${radius};
  }

  window * {
    background-color: transparent;
    border-radius: 0px;
  }

  #workspaces button label {
    color: ${secondaryAccent};
  }

  #workspaces button.active label {
    color: ${base};
    font-weight: bolder;
  }

  #workspaces button:hover {
    box-shadow: ${secondaryAccent} 0 0 0 1.5px;
    background-color: ${base};
    min-width: 50px;
  }

  #workspaces {
    background-color: transparent;
    border-radius: ${radius};
    padding: 5px 0px;
    margin-top: 3px;
  }

  #workspaces button {
    background-color: ${base};
    border-radius: ${radius};
    margin-left: 10px;

    transition: all 0.3s ease;
  }

  #workspaces button.active {
    min-width: 50px;
    box-shadow: rgba(0, 0, 0, 0.288) 2 2 5 2px;
    background-color: ${primaryAccent};
    background-size: 400% 400%;
    transition: all 0.3s ease-in-out;
    background-size: 300% 300%;
  }
''
