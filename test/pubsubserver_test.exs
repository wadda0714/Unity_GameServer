defmodule PubsubserverTest do
  use ExUnit.Case
  doctest Pubsubserver

  test "greets the world" do
    assert Pubsubserver.hello() == :world
  end
end
