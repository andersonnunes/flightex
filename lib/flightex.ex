defmodule Flightex do
  alias Flightex.Bookings.Report

  def generate_report(filename \\ "report.csv", from_date, to_date) do
    Report.create(filename, from_date, to_date)

    {:ok, "Report generated successfully"}
  end
end
