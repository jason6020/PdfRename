#
# @name: PdfFileName
# @created by: yang jie
# @time: 2013-06-01
#

require 'rubygems'
require 'pdf/reader'

#read file path

if ARGV.size != 1
  print("Need enter file path ...\n")
  exit
end

$filePath = ARGV[0].to_s
print("filePath => ", $filePath, "\n")

$filePathArr = Array.new

#reverse file path, find pdf file
def traverse_dir(file_path)

  if File.directory? file_path
    Dir.foreach(file_path) do |file|
      if file != "." and file != ".."
        traverse_dir(file_path + "/" + file)
      end
    end
  else
    if /.pdf/ =~ file_path

      print("FileName is => ", file_path, "\n")

      filename = file_path
      reader = PDF::Reader.new(filename)
      title = nil

      begin
        if reader.info != nil
          title = reader.info[:Title]
          print("PDF Title => ", title, "\n")
        end
      rescue PDF::Reader::MalformedPDFError
        print("PDF::Reader::MalformedPDFError  => ", filename, "\n")
      end

      if title != nil and title.length > 0
        print("rename title => ", title, "\n")
        File.rename(filename, File.dirname(filename) + "/" + title + File.extname(filename))
      end
    end
  end
end

traverse_dir($filePath)
































