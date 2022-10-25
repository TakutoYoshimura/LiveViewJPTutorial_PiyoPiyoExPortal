defmodule PhoenixApp.MessagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixApp.Messages` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        deleted_at: ~N[2022-10-24 07:55:00],
        display_name: "some display_name",
        message: "some message"
      })
      |> PhoenixApp.Messages.create_message()

    message
  end
end
