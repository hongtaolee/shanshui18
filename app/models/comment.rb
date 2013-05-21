class Comment < ActiveRecord::Base
  STATUS_NORMAL = 1
  STATUS_DELETED = -1
  belongs_to :post

  before_save :process_html_content

  validates_presence_of :content, :on => :create, :message => "内容不能为空"
  validates_presence_of :username, :on => :create, :message => "用户名不能为空"
 
  def validate
    if !self.content.blank? && self.content =~ /http|script/
      errors.add("content","含有非法内容")
    end
  end

  private
  def process_html_content
    self.html_content = simple_format(self.content)
  end

  def simple_format(text)
    format_text = ""
    format_text << "<p>"
    format_text << text.to_s.
      gsub(/\r\n?/, "\n").                    # \r\n and \r -> \n
      gsub(/\n\n+/, "</p>\n\n<p>").           # 2+ newline  -> paragraph
      gsub(/([^\n]\n)(?=[^\n])/, '\1<br />')  # 1 newline   -> br  
    format_text << "</p>"
  end

end
