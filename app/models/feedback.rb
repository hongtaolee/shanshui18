class Feedback < ActiveRecord::Base
  before_save :process_html_content
  after_create :sent_sms
    
  validates_presence_of :content,  :message => "内容不能为空"
  validates_presence_of :username,  :message => "请留下您的名字"
#  validates_presence_of :email,  :message => "请填写电子邮件地址"
#  validates_presence_of :phone,  :message => "请留下您的电话,方便联系"
  #
  def validate
    if !self.content.blank? && self.content =~ /http|script/
      errors.add("content","含有非法内容")
    end
  end
  
  def self.feedbacks_count
    sql =<<-EOF
      select count(id) from feedbacks
      where status > 0
    EOF
    Feedback.count_by_sql [sql]
  end

  def self.feedbacks(limit, offset=0)
    sql =<<-EOF
      select * from feedbacks
      where status > 0
      order by id desc
      limit ? offset ?
    EOF
    Feedback.find_by_sql [sql, limit, offset]
  end

  def remove!
    self.update_attribute(:status, Const::STATUS_DELETED)
  end

  private
  def sent_sms
    content = <<-EOF
    "#{self.username}-#{self.phone}-#{self.content}"
    EOF
    options = {
      'message' => "#{content}【山水农家乐】",
      'phone' => '18192298961'  #多个电话逗号隔开
    }

   YmtSmsT.process('sendsms', options)
 
  end
    
  def process_html_content
    self.html_content = simple_format(self.content)
    self.html_reply = simple_format(self.reply) if !self.reply.blank?
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
