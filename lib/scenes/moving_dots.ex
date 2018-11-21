defmodule EsnRpi3Sandbox.Scene.MovingDots do
  use Scenic.Scene
  alias Scenic.Graph
  alias Scenic.ViewPort
  import Scenic.Primitives

  @animate_ms 15
  @x_speed 10
  @x_start 1
  @dot_size 20

  @graph Graph.build()
         |> circle(@dot_size, fill: :red, id: :dot1)
         |> circle(@dot_size, fill: :red, id: :dot2)
         |> circle(@dot_size, fill: :red, id: :dot3)
         |> circle(@dot_size, fill: :red, id: :dot4)
         |> circle(@dot_size, fill: :red, id: :dot5)

  def init(_, opts) do
    viewport = opts[:viewport]
    {:ok, %ViewPort.Status{size: {vp_width, vp_height}}} = ViewPort.info(viewport)

    state = %{
      viewport: viewport,
      graph: @graph,
      vp_width: vp_width,
      vp_height: vp_height,
      x_pos: @x_start,
    }

    Process.send_after(self(), :animate, @animate_ms)

    {:ok, state}
  end

  def handle_info(:animate, %{graph: graph, vp_width: vp_width, vp_height: vp_height, x_pos: x_pos} = state) do
    y_pos = vp_height / 2 - 80
    
    graph =
      graph
      |> Graph.modify(:dot1, &update_opts(&1, translate: { x_pos, y_pos}))
      |> Graph.modify(:dot2, &update_opts(&1, translate: { x_pos - 40, y_pos + 40}))
      |> Graph.modify(:dot3, &update_opts(&1, translate: { x_pos - 80, y_pos + 80}))
      |> Graph.modify(:dot4, &update_opts(&1, translate: { x_pos - 120, y_pos + 120}))
      |> Graph.modify(:dot5, &update_opts(&1, translate: { x_pos - 160, y_pos + 160}))
      |> push_graph()

    new_x_pos = if x_pos > vp_width + 160 do 1 else x_pos + @x_speed end

    Process.send_after(self(), :animate, @animate_ms)

    {:noreply, %{state | graph: graph, x_pos: new_x_pos}}
  end

  def handle_input(_input, _context, state), do: {:noreply, state}
end
