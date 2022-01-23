defmodule DocsWeb.Utils.ListUtils do
  def first_or_nil(array) do
    if (Enum.count(array) > 0) do
      hd(array)
    else
      nil
    end
  end
end
