module ProcessPic
  require 'RMagick'
  def process_picture
    # validate the size of picture file, store it, and set picture_file_name
    if !picture.blank?
      if has_picture
        content_type = picture.content_type.chomp unless picture.original_filename.blank?
        unless content_type =~ /^image/i
          errors.add("picture", "您只能上传图片文件")
        else
          #if picture.size > Const::MAX_PICTURE_SIZE
          #  errors.add("picture", "系统只接受文件大小在2M之下的图片文件") 
          #else
            # store the file into file system and get the new file name
            pname = File.basename(self.picture.original_filename).downcase 
            pname.gsub!(/[^\w._-]/, '')
            pext = pname.match(/\.(\w+)$/)
            filename_no_extension = Digest::SHA1.hexdigest(Time.now.to_f.to_s + pname)
            basic_image_path = filename_no_extension + pext[0].downcase
            self.file_path =  basic_image_path
            # 保存原始大小文件
            real_path = "#{RAILS_ROOT}/public/uploads/#{self.class.name.downcase}img/"
            FileUtils.mkdir_p(real_path)
            pfile = File.new(real_path + basic_image_path, 'w')
            pfile.binmode
            pfile.write(self.picture.read)
            pfile.close
            
            img = Magick::Image.read(real_path+basic_image_path).first
            unless img
              errors.add("picture", "图片格式不对，请选择其它图片上传") and return
            end
            
            self.picture = nil # 防止调用 valid? 和 save 的时候重复生成图片文件名
          #end # size reasonable
        end # image file
      end # there is a file uploaded
    end # file will be uploaded
  end
  private
  def has_picture
    !(picture.original_filename.blank?)
  end  

end
