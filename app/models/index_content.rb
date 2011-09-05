require 'RMagick'
class IndexContent < ActiveRecord::Base
  mattr_accessor :pic_1, :pic_2, :pic_3
  validate :proc_picture

  def self.get_content(category)
    ca = Const::IC_CATEGORY[category]
    if ic = IndexContent.find(:first, :conditions => ["category=?",ca])
    else
      ic = IndexContent.new
      ic.category = ca
    end
    return ic
  end

  def file_url(pic)
    case pic
    when 'pic1'
      return "/uploads/#{self.class.name.downcase}img/" + self.pic1 if !self.pic1.blank?
    when 'pic2'
      return "/uploads/#{self.class.name.downcase}img/" + self.pic2 if !self.pic1.blank?
    when 'pic3'
      return "/uploads/#{self.class.name.downcase}img/" + self.pic3 if !self.pic1.blank?
    end
    return ''
  end

  def process_picture(pic,f)
    if !pic.blank?
      if has_picture(pic)
        content_type = pic.content_type.chomp unless pic.original_filename.blank?
        unless content_type =~ /^image/i
          errors.add(f, "您只能上传图片文件")
        else
          pname = File.basename(pic.original_filename).downcase 
          pname.gsub!(/[^\w._-]/, '')
          pext = pname.match(/\.(\w+)$/)
          filename_no_extension = Digest::SHA1.hexdigest(Time.now.to_f.to_s + pname)
          basic_image_path = filename_no_extension + pext[0].downcase
          case f
          when 'pic1'
            self.pic1 =  basic_image_path
          when 'pic2'
            self.pic2 =  basic_image_path
          when 'pic3'
            self.pic3 =  basic_image_path
          end
          # 保存原始大小文件
          real_path = "#{RAILS_ROOT}/public/uploads/#{self.class.name.downcase}img/"
          FileUtils.mkdir_p(real_path)
          pfile = File.new(real_path + basic_image_path, 'w')
          pfile.binmode
          pfile.write(pic.read)
          pfile.close
          
          img = Magick::Image.read(real_path+basic_image_path).first
          unless img
            errors.add(f, "图片格式不对，请选择其它图片上传") and return
          end
          case f
          when 'pic1'
            self.pic_1 = nil
          when 'pic2'
            self.pic_2 = nil
          when 'pic3'
            self.pic_3 = nil
          end          
        end # image file
      else
        logger.info "there is a file uploaded"
      end # there is a file uploaded
    else
      logger.info ".blank?"
    end # file will be uploaded
  end
  private

  def has_picture(pic)
    !(pic.original_filename.blank?)
  end

  def proc_picture
    logger.info "----------------------------------------"
    process_picture(pic_1,'pic1') if !self.pic_1.blank?
    logger.info "+++++++#{self.pic1}"
    process_picture(pic_2,'pic2') if !self.pic_2.blank?
    process_picture(pic_3,'pic3') if !self.pic_3.blank?
  end
end
