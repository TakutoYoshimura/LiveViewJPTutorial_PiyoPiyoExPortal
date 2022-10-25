{ pkgs }: {
	deps = [
		pkgs.nodejs-16_x
  pkgs.elixir
        pkgs.elixir_ls
        pkgs.sqlite
        pkgs.inotify-tools
	];
}