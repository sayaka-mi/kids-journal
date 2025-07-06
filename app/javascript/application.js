// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "preview"
import "tag_search"
import "chart.js"
import "chartjs-adapter-date-fns"
import "chartkick"
import { ja as dateFnsJa } from "date-fns/locale/ja"
  
document.addEventListener("DOMContentLoaded", () => {
  const adapters = window.Chart?._adapters
  if (adapters?._date?.override) {
    adapters._date.override({ locale: dateFnsJa })
  }
  
  window.Chart.defaults.datasets ??= {}
  window.Chart.defaults.datasets.line ??= {}
  window.Chart.defaults.datasets.line.spanGaps = true
  
  window.Chartkick.Chart = window.Chart
})