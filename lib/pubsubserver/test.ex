defmodule TestWorker do
  def child_spec(args) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [args]}
    }
  end

  def start_link(word: word) do
    GenServer.start_link(__MODULE__, word)
  end

  def init(word) do
    for x <- 1..10000 do
      Process.sleep(1000)
      IO.puts("Started: #{word}")
    end

    {:ok, word}
  end
end
