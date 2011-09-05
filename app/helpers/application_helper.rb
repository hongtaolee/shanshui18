# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def page_category
    [
      ['山村生活',1],
      ['感受四季',2],
      ['农家院研究',3]
    ]
  end

  def picture_category
    [
      ['农家菜肴', 1],
      ['温馨客房',2],
      ['农家院美景',3]
    ]
  end

  def picture_nav
    {'1' => ['农家菜肴','农家美食，时令鲜疏，特色野味，农家菜肴，找回家乡的味道'],
     '2' => ['温馨客房',"12个标准间，独立卫浴，太阳能热水，集中供暖，秦岭脚下放心舒适的家"],
     '3' => ['农家院美景',"农家院里的一花一草，一树一木，都在昭示着安静祥和的美好,您也可以把您的作品传给我们，放在网站上展示哦，您可以发送邮件到50868470@qq.com"]}
  end

  def post_nav
    {
      '0' => ['最新动态','农家最新动态，山村生活纪事，笑看四季变换，静听游客心声。'],
      '1' => ['山村生活','农家最新动态，山村生活纪事，笑看四季变换，静听游客心声。'],
      '2' => ['感受四季','农家最新动态，山村生活纪事，笑看四季变换，静听游客心声。'],
      '3' => ['农家乐研究','农家最新动态，山村生活纪事，笑看四季变换，静听游客心声。']
    }
  end

  def current_controller
    return self.controller_name.to_s.underscore.gsub(/_controller$/, '')
  end
  
  def current_action
    return self.action_name.underscore
  end

  def datetime_format(datetime)
    datetime.strftime("%Y-%m-%d %H:%m")
  end

  def manager?
    session[:auth] == 'asdf'
  end
  
end
