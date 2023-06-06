defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def create(filename, from_date, to_date) do
    booking_list = build_booking_list(from_date, to_date)

    File.write(filename, booking_list)
  end

  defp build_booking_list(%NaiveDateTime{} = from_date, %NaiveDateTime{} = to_date) do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.filter(fn %Booking{complete_date: complete_date} ->
      from = NaiveDateTime.compare(complete_date, from_date)
      to = NaiveDateTime.compare(complete_date, to_date)

      (from == :eq or from == :gt) and (to == :eq or to == :lt)
    end)
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp booking_string(%Booking{
         complete_date: complete_date,
         local_destination: local_destination,
         local_origin: local_origin,
         user_id: user_id
       }) do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end
end
