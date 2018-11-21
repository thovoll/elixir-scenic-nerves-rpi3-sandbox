defmodule EsnRpi3Sandbox.Scene.MovingDots do
  use Scenic.Scene
  alias Scenic.Graph
  alias Scenic.ViewPort
  import Scenic.Primitives

  @graph Graph.build()
         |> circle(20, fill: :red, id: :dot)

  @animate_ms 2

  def init(_, opts) do
    viewport = opts[:viewport]
    {:ok, %ViewPort.Status{size: {vp_width, vp_height}}} = ViewPort.info(viewport)
    position = { 30, vp_height / 2 }

    graph =
      Graph.modify(@graph, :dot, &update_opts(&1, translate: position))
      |> push_graph()

    {:ok, timer} = :timer.send_interval(@animate_ms, :animate)

    state = %{
      viewport: viewport,
      timer: timer,
      graph: graph,
      position: position,
    }

    {:ok, state}
  end

  def handle_info(:animate, %{position: p, graph: graph} = state) do
    graph =
      graph
      |> Graph.modify(:dot, &update_opts(&1, translate: p))
      |> push_graph()

    { x, y } = p
    new_x = if x > 800 do 1 else x + 1 end
    new_p = { new_x, y }

    {:noreply, %{state | graph: graph, position: new_p}}
  end

  def handle_input(_input, _context, state), do: {:noreply, state}
end
