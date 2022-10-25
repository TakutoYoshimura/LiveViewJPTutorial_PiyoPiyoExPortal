defmodule PhoenixAppWeb.MessageLive.Index do
  use PhoenixAppWeb, :live_view

  alias PhoenixApp.Messages
  alias PhoenixApp.Messages.Message

  @impl true
  def mount(params, _session, socket) do
    {:ok, assign(socket, :messages, list_messages(params))} # <-- modify here
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Message")
    |> assign(:message, Messages.get_message!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Message")
    |> assign(:message, %Message{})
  end

  defp apply_action(socket, :index, _params) do
    socket
#    |> assign(:page_title, "Listing Messages") # <-- delete here
    |> assign(:message, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    message = Messages.get_message!(id)
    {:ok, _} = Messages.delete_message(message)

    {:noreply, assign(socket, :messages, list_messages())}
  end

  # delete default function
  #defp list_messages do
  #  Messages.list_messages()
  #end

  # add list_messges/1 function
  defp list_messages(%{"mode" => mode}) do
    Messages.list_messages(mode)
  end
  defp list_messages(_ \\ %{}) do
    Messages.list_messages()
  end
end
