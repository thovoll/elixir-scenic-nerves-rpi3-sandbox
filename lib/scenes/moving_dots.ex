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
         |> circle(@dot_size, fill: :red, id: :dot)

  def init(_, opts) do
    viewport = opts[:viewport]
    {:ok, %ViewPort.Status{size: {vp_width, vp_height}}} = ViewPort.info(viewport)
    position = { @x_start, vp_height / 2 }

    graph =
      Graph.modify(@graph, :dot, &update_opts(&1, translate: position))
      |> push_graph()

    state = %{
      viewport: viewport,
      graph: graph,
      position: position,
      vp_width: vp_width
    }

    Process.send_after(self(), :animate, @animate_ms)

    {:ok, state}
  end

  def handle_info(:animate, %{position: p, graph: graph, vp_width: vp_width} = state) do
    graph =
      graph
      |> Graph.modify(:dot, &update_opts(&1, translate: p))
      |> push_graph()

    { x, y } = p
    new_x = if x > vp_width do 1 else x + @x_speed end
    new_p = { new_x, y }

    Process.send_after(self(), :animate, @animate_ms)

    {:noreply, %{state | graph: graph, position: new_p}}
  end

  def handle_input(_input, _context, state), do: {:noreply, state}
end
