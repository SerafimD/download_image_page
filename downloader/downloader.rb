require 'open-uri'
require 'progress_bar'
require 'nokogiri'

module Downloader
  #
  # Класс управляющий процессом загрузки и формированием файлов
  #
  class Downloader
    NAME_TS_FORMAT = '%Y%m%d%H%M%S'.freeze
    def initialize(url:)
      @url = url
      r = Regexp.new(/https?:\/\/(?:[-\w]+\.)?([-\w]+)\.\w+(?:\.\w+)?\/?.*/i)
      @base_host = r.match(@url)[0]
      #binding.pry
    end

    # Паттерн "команда"
    def execute
      # Создаём папку для агрегации за текущую дату
      dir_name = "#{Time.now.strftime(NAME_TS_FORMAT)}"
      Dir.mkdir(dir_name)
      # Скачиваем в папку изображения
      download_img dir_name
    end

    #
    # Получаем ссылки на файлы и скачиваем их
    #
    def download_img(dir_name)
      doc = Nokogiri::HTML(open(@url))
      references = doc.xpath('//img')
      bar = ProgressBar.new references.size, :bar, :percentage, :eta
      references.each do |ref|
        bar.increment!
        ref = ref.attributes['src'].value
        download_file(ref, dir_name) if abs_ref? ref
      end
    end

    #
    # Убеждаемся что путь абсолютный
    #
    def abs_ref?(ref)
      return true if (ref =~ /https?:\/\/(?:[-\w]+\.)?([-\w]+)\.\w+(?:\.\w+)?\/?.*/i)
      false
    end

    #
    # Скачиваем файл
    #
    def download_file(ref, dir)
      uri = URI(ref)
      file_name = ref.split('/').last
      if type_validation file_name
        safe_call do
        Net::HTTP.start(uri.host, uri.port,  :use_ssl => uri.scheme == 'https') do |http|
          request = Net::HTTP::Get.new(uri)
          http.request request do |response|
            open "#{dir}/#{file_name}", 'wb' do |io|
              response.read_body { |chunk| io.write chunk }
            end
          end
        end
        end
      end
    end

    #
    # Блок безовасно выполнится и ничего не уронит 8)
    #
    def safe_call(default_value = [], &b)
      begin
        yield
      rescue StandardError => e
        puts e.message
      end
    end

    #
    # Простая проверка на тип файла
    #
    def type_validation(name)
      name =~ /(?i)\.(jpg|png|gif)$/
    end

  end
end
