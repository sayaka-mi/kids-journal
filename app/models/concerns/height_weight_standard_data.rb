module HeightWeightStandardData
  MALE_HEIGHT_PERCENTILES = {
    0 => { p3: 46.0, p10: 47.5, p25: 48.7, p50: 50.0, p75: 51.2, p90: 52.5, p97: 54.0 },
    1 => { p3: 50.9, p10: 52.6, p25: 54.1, p50: 55.5, p75: 56.9, p90: 58.4, p97: 59.9 },
    2 => { p3: 54.4, p10: 56.2, p25: 57.9, p50: 59.4, p75: 60.9, p90: 62.6, p97: 64.2 },
    3 => { p3: 57.0, p10: 58.9, p25: 60.6, p50: 62.1, p75: 63.7, p90: 65.5, p97: 67.2 },
    6 => { p3: 63.6, p10: 65.7, p25: 67.4, p50: 69.1, p75: 70.9, p90: 72.8, p97: 74.7 },
    12 => { p3: 71.4, p10: 73.8, p25: 75.8, p50: 77.8, p75: 79.8, p90: 82.0, p97: 84.3 },
    18 => { p3: 77.1, p10: 79.7, p25: 81.9, p50: 84.1, p75: 86.4, p90: 88.8, p97: 91.3 },
    24 => { p3: 81.7, p10: 84.6, p25: 87.0, p50: 89.4, p75: 91.9, p90: 94.6, p97: 97.4 },
    36 => { p3: 89.0, p10: 92.3, p25: 95.0, p50: 97.8, p75: 100.6, p90: 103.7, p97: 106.9 },
    48 => { p3: 95.4, p10: 99.0, p25: 102.0, p50: 105.0, p75: 108.1, p90: 111.5, p97: 115.1 },
    60 => { p3: 101.2, p10: 105.1, p25: 108.4, p50: 111.8, p75: 115.2, p90: 119.0, p97: 122.9 }
  }.freeze

  FEMALE_HEIGHT_PERCENTILES = {
    0 => { p3: 45.4, p10: 47.0, p25: 48.2, p50: 49.5, p75: 50.7, p90: 52.0, p97: 53.4 },
    1 => { p3: 50.2, p10: 51.9, p25: 53.4, p50: 54.8, p75: 56.2, p90: 57.7, p97: 59.2 },
    2 => { p3: 53.6, p10: 55.4, p25: 57.1, p50: 58.6, p75: 60.1, p90: 61.8, p97: 63.4 },
    3 => { p3: 56.2, p10: 58.1, p25: 59.8, p50: 61.4, p75: 63.0, p90: 64.8, p97: 66.5 },
    6 => { p3: 62.7, p10: 64.8, p25: 66.5, p50: 68.2, p75: 70.0, p90: 71.9, p97: 73.8 },
    12 => { p3: 70.3, p10: 72.8, p25: 74.8, p50: 76.8, p75: 78.9, p90: 81.1, p97: 83.4 },
    18 => { p3: 76.0, p10: 78.7, p25: 80.9, p50: 83.2, p75: 85.5, p90: 88.0, p97: 90.6 },
    24 => { p3: 80.6, p10: 83.5, p25: 86.0, p50: 88.5, p75: 91.0, p90: 93.8, p97: 96.7 },
    36 => { p3: 88.0, p10: 91.4, p25: 94.1, p50: 97.0, p75: 99.9, p90: 103.1, p97: 106.4 },
    48 => { p3: 94.5, p10: 98.2, p25: 101.2, p50: 104.3, p75: 107.4, p90: 110.9, p97: 114.6 },
    60 => { p3: 100.4, p10: 104.4, p25: 107.6, p50: 110.9, p75: 114.2, p90: 118.0, p97: 122.0 }
  }.freeze

  MALE_WEIGHT_PERCENTILES = {
    0 => { p3: 2.13, p10: 2.47, p25: 2.78, p50: 3.18, p75: 3.58, p90: 4.01, p97: 4.47 },
    1 => { p3: 3.00, p10: 3.43, p25: 3.84, p50: 4.35, p75: 4.87, p90: 5.42, p97: 6.00 },
    2 => { p3: 3.53, p10: 4.05, p25: 4.53, p50: 5.17, p75: 5.83, p90: 6.53, p97: 7.28 },
    3 => { p3: 4.41, p10: 5.12, p25: 5.73, p50: 6.44, p75: 7.18, p90: 7.95, p97: 8.78 },
    6 => { p3: 6.10, p10: 6.96, p25: 7.73, p50: 8.59, p75: 9.48, p90: 10.41, p97: 11.42 },
    12 => { p3: 7.68, p10: 8.73, p25: 9.65, p50: 10.69, p75: 11.78, p90: 12.93, p97: 14.20 },
    18 => { p3: 8.83, p10: 10.02, p25: 11.04, p50: 12.23, p75: 13.50, p90: 14.86, p97: 16.37 },
    24 => { p3: 9.80, p10: 11.11, p25: 12.24, p50: 13.56, p75: 14.97, p90: 16.49, p97: 18.19 },
    36 => { p3: 11.38, p10: 12.84, p25: 14.10, p50: 15.59, p75: 17.21, p90: 18.98, p97: 20.95 },
    48 => { p3: 12.73, p10: 14.33, p25: 15.67, p50: 17.32, p75: 19.16, p90: 21.20, p97: 23.49 },
    60 => { p3: 14.02, p10: 15.78, p25: 17.22, p50: 19.06, p75: 21.12, p90: 23.40, p97: 25.96 }
  }.freeze

  FEMALE_WEIGHT_PERCENTILES = {
    0 => { p3: 2.05, p10: 2.38, p25: 2.67, p50: 3.05, p75: 3.44, p90: 3.84, p97: 4.28 },
    1 => { p3: 2.90, p10: 3.32, p25: 3.71, p50: 4.19, p75: 4.68, p90: 5.20, p97: 5.76 },
    2 => { p3: 3.39, p10: 3.90, p25: 4.36, p50: 4.94, p75: 5.54, p90: 6.18, p97: 6.87 },
    3 => { p3: 4.19, p10: 4.84, p25: 5.42, p50: 6.09, p75: 6.78, p90: 7.52, p97: 8.31 },
    6 => { p3: 5.79, p10: 6.53, p25: 7.22, p50: 7.99, p75: 8.81, p90: 9.69, p97: 10.63 },
    12 => { p3: 7.16, p10: 8.11, p25: 8.95, p50: 9.87, p75: 10.85, p90: 11.89, p97: 13.05 },
    18 => { p3: 8.25, p10: 9.34, p25: 10.31, p50: 11.39, p75: 12.55, p90: 13.80, p97: 15.20 },
    24 => { p3: 9.23, p10: 10.44, p25: 11.51, p50: 12.72, p75: 14.02, p90: 15.43, p97: 17.02 },
    36 => { p3: 10.95, p10: 12.32, p25: 13.52, p50: 14.90, p75: 16.40, p90: 18.04, p97: 19.88 },
    48 => { p3: 12.41, p10: 13.93, p25: 15.27, p50: 16.84, p75: 18.55, p90: 20.44, p97: 22.56 },
    60 => { p3: 13.75, p10: 15.43, p25: 16.89, p50: 18.65, p75: 20.59, p90: 22.73, p97: 25.15 }
  }.freeze

  module_function
  def get_percentile_data(gender, measurement_type, age_in_months)
    data = case [gender, measurement_type]
           when ['male',   'height'] then MALE_HEIGHT_PERCENTILES
           when ['female', 'height'] then FEMALE_HEIGHT_PERCENTILES
           when ['male',   'weight'] then MALE_WEIGHT_PERCENTILES
           when ['female', 'weight'] then FEMALE_WEIGHT_PERCENTILES
           else return {}
           end

    closest_month = data.keys.min_by { |m| (m - age_in_months).abs }
    data[closest_month] || {}
  end

  def series_for(child, measurement_type, percentiles: %w[p3 p50 p97])
    gender = child.gender
    series = Hash.new { |h, k| h[k] = [] }
    
    # 実際にデータが存在する月齢のみを使用
    available_months = case [gender, measurement_type]
                      when ['male', 'height'] then MALE_HEIGHT_PERCENTILES.keys
                      when ['female', 'height'] then FEMALE_HEIGHT_PERCENTILES.keys
                      when ['male', 'weight'] then MALE_WEIGHT_PERCENTILES.keys
                      when ['female', 'weight'] then FEMALE_WEIGHT_PERCENTILES.keys
                      else []
                      end
    
    max_age_months = ((Date.current.year - child.birthday.year) * 12 + 
                    (Date.current.month - child.birthday.month))
    
    available_months.each do |age_mo|
      next if age_mo > max_age_months
      
      pct = get_percentile_data(gender, measurement_type, age_mo)
      next if pct.empty?
      
      plot_date = child.birthday + age_mo.months
      percentiles.each { |p| series[p] << [plot_date, pct[p.to_sym]] }
    end
    
    series
  end
end