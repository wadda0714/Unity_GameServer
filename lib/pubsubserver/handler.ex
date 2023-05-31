defmodule Pubsubserver.Handler do
  use ThousandIsland.Handler

  def send_message(pid, from, msg) do
    GenServer.cast(pid, {:send, from, msg})
  end

  @impl ThousandIsland.Handler
  def handle_connection(socket, state) do
    # 接続して来たホストのIPを表示する
    IO.puts("New connection established ")
    Registry.register(Pubsubserver.Registry, "clients", socket)
    {:continue, state}
  end

  @impl ThousandIsland.Handler
  def handle_data(msg, socket, state) do
    send_message(self(), socket, msg)
    {:continue, [socket | state]}
  end

  @impl GenServer
  def handle_cast({:send, from, msg}, {socket, state}) do
    Registry.lookup(Pubsubserver.Registry, "clients")
    |> Enum.filter(fn {_pid, socket} ->
      socket != from
    end)
    |> Enum.each(fn {_pid, socket} ->
      ThousandIsland.Socket.send(socket, msg)
    end)

    IO.puts("sended message " <> msg)

    {:noreply, {socket, state}}
  end
end
