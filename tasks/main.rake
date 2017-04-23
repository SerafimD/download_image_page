require 'pry'
require 'pry-byebug'
require_relative '../downloader/downloader'
require_relative '../algorithm/search'

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

  desc '2) Массивы целых чисел'
  task :array_of_number do
    arr_t1 = [1,2,3,5,6,8,9,10] # 4, 7 missed
    arr_t2 = [1,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,20] # 2, 12 missed

    Algorithm::Search.new(arr_t1).find_missed
    puts '---------------------------------------'
    Algorithm::Search.new(arr_t2).find_missed
  end
end
