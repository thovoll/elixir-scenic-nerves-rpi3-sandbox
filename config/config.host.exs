use Mix.Config

config :esn_rpi3_sandbox, :viewport, %{
  name: :main_viewport,
  # default_scene: {EsnRpi3Sandbox.Scene.Crosshair, nil},
  default_scene: {EsnRpi3Sandbox.Scene.SysInfo, nil},
  size: {800, 480},
  opts: [scale: 1.0],
  drivers: [
    %{
      module: Scenic.Driver.Glfw,
      opts: [title: "MIX_TARGET=host, app = :esn_rpi3_sandbox"]
    }
  ]
}
