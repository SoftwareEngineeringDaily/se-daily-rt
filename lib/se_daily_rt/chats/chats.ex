defmodule SEDailyRT.Chats do
  @moduledoc """
  The Chats context.
  """

  import Ecto.Query, warn: false
  alias SEDailyRT.Repo
  alias SEDailyRT.Accounts.User  

  alias SEDailyRT.Chats.Channels

  @doc """
  Returns the list of channels.

  ## Examples

      iex> list_channels()
      [%Channels{}, ...]

  """
  def list_channels do
    Repo.all(Channels)
  end

  @doc """
  Gets a single channels.

  Raises `Ecto.NoResultsError` if the Channels does not exist.

  ## Examples

      iex> get_channels!(123)
      %Channels{}

      iex> get_channels!(456)
      ** (Ecto.NoResultsError)

  """
  def get_channels!(id), do: Repo.get!(Channels, id)

  @doc """
  Creates a channels.

  ## Examples

      iex> create_channels(%{field: value})
      {:ok, %Channels{}}

      iex> create_channels(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_channels(attrs \\ %{}) do
    %Channels{}
    |> Channels.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a channels.

  ## Examples

      iex> update_channels(channels, %{field: new_value})
      {:ok, %Channels{}}

      iex> update_channels(channels, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_channels(%Channels{} = channels, attrs) do
    channels
    |> Channels.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Channels.

  ## Examples

      iex> delete_channels(channels)
      {:ok, %Channels{}}

      iex> delete_channels(channels)
      {:error, %Ecto.Changeset{}}

  """
  def delete_channels(%Channels{} = channels) do
    Repo.delete(channels)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking channels changes.

  ## Examples

      iex> change_channels(channels)
      %Ecto.Changeset{source: %Channels{}}

  """
  def change_channels(%Channels{} = channels) do
    Channels.changeset(channels, %{})
  end

  alias SEDailyRT.Chats.Messages

  @doc """
  Returns the list of messages.

  ## Examples

      iex> list_messages()
      [%Messages{}, ...]

  """
  def list_messages do
    Repo.all(Messages)
  end

  @doc """
  Returns the list of messages for a given channel.

  ## Examples

      iex> list_channel_messages("best_channel")
      [%Messages{}, ...]

  """
  def list_channel_messages(channel) do 
    Repo.all(
        from m in Messages,
        limit: 100, 
        order_by: [asc: m.id],
        where: m.channel == ^channel,
        preload: [:user]
    )
  end

  @doc """
  Gets a single messages.

  Raises `Ecto.NoResultsError` if the Messages does not exist.

  ## Examples

      iex> get_messages!(123)
      %Messages{}

      iex> get_messages!(456)
      ** (Ecto.NoResultsError)

  """
  def get_messages!(id), do: Repo.get!(Messages, id)

  @doc """
  Creates a user message.

  ## Examples

      iex> create_user_message(%User{},%{field: value})
      {:ok, %Messages{}}

      iex> create_user_message(%User{},%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_message(%User{} = user, attrs \\ %{}) do
    attrs =  %{attrs | body: HtmlSanitizeEx.strip_tags(attrs.body)}
    
    user
    |> Ecto.build_assoc(:messages)
    |> Messages.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a messages.

  ## Examples

      iex> update_messages(messages, %{field: new_value})
      {:ok, %Messages{}}

      iex> update_messages(messages, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_messages(%Messages{} = messages, attrs) do
    messages
    |> Messages.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Messages.

  ## Examples

      iex> delete_messages(messages)
      {:ok, %Messages{}}

      iex> delete_messages(messages)
      {:error, %Ecto.Changeset{}}

  """
  def delete_messages(%Messages{} = messages) do
    Repo.delete(messages)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking messages changes.

  ## Examples

      iex> change_messages(messages)
      %Ecto.Changeset{source: %Messages{}}

  """
  def change_messages(%Messages{} = messages) do
    Messages.changeset(messages, %{})
  end
end
