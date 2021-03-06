defmodule SEDailyRT.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias SEDailyRT.Repo

  alias SEDailyRT.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user by the username.

  ## Examples

      iex> get_user_by_username('someone')
      %User{}

      iex> get_user_by_username('no_one')
      ** (Ecto.NoResultsError)

  """
  def get_user_by_username(username), do: Repo.get_by(User, username: username)

  @doc """
  Gets a single user by the account id

  ## Examples

      iex> get_user_by_account_id('5a262f7232c5f6002a6d5f11')
      %User{}

      iex> get_user_by_account_id('5a262f7232c5f6002a62244554')
      ** (Ecto.NoResultsError)

  """
  def get_user_by_account_id(id), do: Repo.get_by(User, auth_id: id)
  
  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Loads or creates a user with a given JWT

  ## Examples

      iex> create_or_load_user(%{"token" => "dfdfdfdfd"})
      %User{}
  """
  def create_or_load_user(%{"token" => token}) do
    %{"username" => username, "email" => email, "_id" => id, "name" => name} = user = SEDailyRT.JWT.decode(token)
    case get_user_by_account_id(id) do
      nil -> 
        {:ok, user} = create_user(%{"username" => username, "email" => email, "auth_id" => id, "name" => name})
        user
      user -> user
    end
  end
end
