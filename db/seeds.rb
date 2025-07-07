vaccines = [
  {
    name: "B型肝炎",
    recommended_doses: 3,
    dose_months: [2, 3, 7],
    optional: false,
    min_month: 2, max_month: 8
  },
  {
    name: "ロタリックス",
    recommended_doses: 2,
    dose_months: [2, 3],
    optional: false,
    min_month: 2, max_month: 3
  },
  {
    name: "ロタテック",
    recommended_doses: 3,
    dose_months: [2, 3, 4],
    optional: false,
    min_month: 2, max_month: 4
  },
  {
    name: "肺炎球菌",
    recommended_doses: 4,
    dose_months: [2, 3, 4, 12],
    optional: false,
    min_month: 2, max_month: 12
  },
  {
    name: "５種混合",
    recommended_doses: 4,
    dose_months: [2, 3, 4, 12],
    optional: false,
    min_month: 2, max_month: 12
  },
  {
    name: "４種混合",
    recommended_doses: 4,
    dose_months: [3, 4, 5, 12],
    optional: false,
    min_month: 2, max_month: 12
  },
  {
    name: "２種混合",
    recommended_doses: 1,
    dose_months: [132],
    optional: false,
    max_month: 132
  },
  {
    name: "3種混合（学童期以降の百日咳予防）",
    recommended_doses: 2,
    dose_months: [60, 132],
    optional: true,
    description: "百日咳の追加予防接種"
  },
  {
    name: "ポリオ（学童期以降のポリオ予防）",
    recommended_doses: 1,
    dose_months: [60],
    optional: true,
    description: "学童期以降のポリオ予防"
  },
  {
    name: "Hib（インフルエンザ菌ｂ型）",
    recommended_doses: 4,
    dose_months: [2, 3, 4, 12],
    optional: false,
    min_month: 2, max_month: 12
  },
  {
    name: "BCG",
    recommended_doses: 1,
    dose_months: [5],
    optional: false,
    min_month: 0, max_month: 5
  },
  {
    name: "麻疹・風疹混合（MR）",
    recommended_doses: 2,
    dose_months: [12, 60],
    optional: false,
    min_month: 12, max_month: 60
  },
  {
    name: "水痘",
    recommended_doses: 2,
    dose_months: [12, 18],
    optional: false,
    min_month: 12, max_month: 18
  },
  {
    name: "おたふくかぜ",
    recommended_doses: 2,
    dose_months: [12, 60],
    optional: true,
    min_month: 12,
    max_month: 60
  },
  {
    name: "日本脳炎",
    recommended_doses: 4,
    dose_months: [36, 36, 48, 108],
    optional: false,
    min_month: 3, max_month: 108
  },
  {
    name: "ヒトパピローマウイルス（HPV）",
    recommended_doses: 3,
    dose_months: [144, 145, 150],
    optional: false,
    min_month: 144, max_month: 150
  }
]

vaccines.each do |vaccine_attrs|
  vaccine = Vaccine.find_or_initialize_by(name: vaccine_attrs[:name])
  vaccine.update!(vaccine_attrs)
end