defmodule PhoenixAppWeb.Router do
  use PhoenixAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PhoenixAppWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PhoenixAppWeb.AllowReplit
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixAppWeb do
    pipe_through :browser

    # modify root endpoint
    # get "/", PageController, :index
    live "/", MessageLive.Index, :index

    # add message default routing
    live "/messages", MessageLive.Index, :index
    live "/messages/new", MessageLive.Index, :new
    live "/messages/:id/edit", MessageLive.Index, :edit

    live "/messages/:id", MessageLive.Show, :show
    live "/messages/:id/show/edit", MessageLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixAppWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PhoenixAppWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
