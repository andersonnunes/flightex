defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case

  alias Flightex.Bookings.Agent, as: BookingAgent

  import Flightex.Factory

  describe "generate_report/3" do
    test "creates the report file" do
      BookingAgent.start_link(%{})

      :booking
      |> build()
      |> BookingAgent.save()

      :booking
      |> build()
      |> BookingAgent.save()

      expected_response =
        "12345678900,Brasilia,Bananeiras,2001-05-07 03:05:00\n" <>
          "12345678900,Brasilia,Bananeiras,2001-05-07 03:05:00\n"

      Flightex.generate_report(
        "report_test.csv",
        ~N[2001-05-07 00:00:00],
        ~N[2001-05-07 23:59:00]
      )

      response = File.read!("report_test.csv")

      assert response == expected_response
    end

    test "creates the report file empty" do
      BookingAgent.start_link(%{})

      :booking
      |> build()
      |> BookingAgent.save()

      :booking
      |> build()
      |> BookingAgent.save()

      expected_response = ""

      Flightex.generate_report(
        "report_test.csv",
        ~N[2001-05-06 00:00:00],
        ~N[2001-05-06 23:59:00]
      )

      response = File.read!("report_test.csv")

      assert response == expected_response
    end
  end
end
