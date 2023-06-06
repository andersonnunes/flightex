defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users
  alias Users.Agent, as: UserAgent
  alias Users.User

  def call(%{name: name, email: email, cpf: cpf}) do
    User.build(name, email, cpf)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)

    {:ok, user}
  end

  defp save_user({:error, _reason} = error), do: error
end
