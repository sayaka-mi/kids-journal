# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "preview", to: "preview.js"
pin "tag_search", to: "tag_search.js"
pin "chartkick", to: "chartkick.js"
pin "chart.js", to: "chartjs/chart.umd.js"
pin "chartjs-adapter-date-fns", to: "chartjs/chartjs-adapter-date-fns.js"
pin "date-fns" # @4.1.0
pin "date-fns/locale/ja", to: "https://ga.jspm.io/npm:date-fns@4.1.0/locale/ja.js"
pin "locales/ja", to: "locales/ja.js"