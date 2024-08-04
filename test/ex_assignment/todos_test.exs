defmodule ExAssignment.TodosTest do
  use ExAssignment.DataCase

  alias ExAssignment.Todos

  describe "todos" do
    alias ExAssignment.Todos.Todo

    import ExAssignment.TodosFixtures

    @invalid_attrs %{done: nil, priority: nil, title: nil}

    setup do
      #Add a recommended todo to avoid failures for 
      todo_fixture(%{title: "recommended"})
      ExAssignment.Cache.insert()
      :ok
    end

    test "list_todos/0 returns all todos" do
      assert length(Todos.list_todos()) == 1
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert Todos.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      valid_attrs = %{done: true, priority: 42, title: "some title"}

      assert {:ok, %Todo{} = todo} = Todos.create_todo(valid_attrs)
      assert todo.done == true
      assert todo.priority == 42
      assert todo.title == "some title"
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todos.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      update_attrs = %{done: false, priority: 43, title: "some updated title"}

      assert {:ok, %Todo{} = todo} = Todos.update_todo(todo, update_attrs)
      assert todo.done == false
      assert todo.priority == 43
      assert todo.title == "some updated title"
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_todo(todo, @invalid_attrs)
      assert todo == Todos.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()

      assert {:ok, %Todo{}} = Todos.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = Todos.change_todo(todo)
    end

    test "get_recommended/0 returns persisted todo" do
      current_recommended_todo = Todos.get_recommended()

      #complete a different todo
      todo = todo_fixture()
      Todos.check("#{todo.id}")

      assert Todos.get_recommended() == current_recommended_todo
    end

    test "get_recommended/0 returns different todo once current is complete" do
      current_recommended_todo = Todos.get_recommended()

      #complete the currentlt recommended todo
      Todos.check(current_recommended_todo.id)

      refute Todos.get_recommended() == current_recommended_todo
    end

    test "get_recommended/0 returns different todo once current is deleted" do
      current_recommended_todo = Todos.get_recommended()

      #complete the currentlt recommended todo
      Todos.delete_todo(current_recommended_todo)

      refute Todos.get_recommended() == current_recommended_todo
    end
  end
end
