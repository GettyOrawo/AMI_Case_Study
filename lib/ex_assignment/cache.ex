defmodule ExAssignment.Cache do
	use GenServer

	@name __MODULE__

	def start_link(_), do: GenServer.start_link(__MODULE__, [], name: @name)

	def insert() do
    GenServer.call(@name, :insert)
  end

	def init(_) do
		IO.puts("Creating ETS #{@name}")

		:ets.new(:recommendation_keep, [:set, :named_table])

		IO.puts("Inserting initial recommeded todo")
		handle_call(:insert, nil, %{})

    {:ok, "Created"}
	end

	def handle_call(:insert, _ref, state) do
		ExAssignment.Todos.list_todos(:open)
		next_todo = ExAssignment.Todos.generate_next_recommended()

    :ets.insert(:recommendation_keep, {:next_todo, next_todo})

    {:reply, :ok, state}
  end
end