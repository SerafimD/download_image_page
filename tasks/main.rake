require 'pry'
require 'pry-byebug'
require_relative '../downloader/downloader'

desc 'Решение тестовых задач'

namespace :tasks do
  desc '1) Выкачивание изображений. ' \
  ' Пример : rake tasks:download_image"[http://hamster.ru]"'
  task :download_image, [:url] do |t, args|
    url = args[:url] || nil
    if url
      puts "url = #{url}"
      Downloader::Downloader.new(url: url).execute
    else
      puts 'URL для закачивания изображений не был передан !'
    end
  end
end
