module VaccinationRecordsHelper
  def format_age_from_months(total_months)
    return nil if total_months.blank?

    years = total_months / 12
    months = total_months % 12

    if years > 0
      "#{years}歳#{months}か月"
    else
      "#{months}か月"
    end
  end
end
