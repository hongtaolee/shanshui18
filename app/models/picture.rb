require 'process_pic'
class Picture < ActiveRecord::Base
  include ProcessPic
  mattr_accessor :picture
  STATUS_NORMAL = 1
  STATUS_DELETED = -1
  
  validates_presence_of :name,  :message => "图片名不能为空"
  validates_presence_of :category,  :message => "类别不能为空"
  validates_uniqueness_of :name, :message => "该图片名已经存在"

  def validate
    if self.picture.blank?
      errors.add("picture", "请上传图片文件") if self.new_record?
    else
      process_picture
    end
  end

  def file_url
    "/uploads/#{self.class.name.downcase}img/" + self.file_path
  end

  def self.all(category=nil, limit=10, offset=0)
    if category
      Picture.find :all, :conditions=>["status>0 and category=?", category], :order=>'id desc', :limit=>limit, :offset=>offset
    else
      Picture.find :all, :conditions=>["status>0"], :order=>'id desc', :limit=>limit, :offset=>offset
    end
  end

  def self.pictures_count(category=nil)
    if category
      Picture.count 'id', :conditions=>["status>0 and category=?", category]
    else
      Picture.count 'id', :conditions=>["status>0"]
    end

  end
end
