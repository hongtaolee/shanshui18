#encoding: utf-8
require 'nokogiri'
require "open-uri"
require 'digest/md5'

class YmtSmsT

  def self.process(action, options = {})
    error_hash = {
      '-1' => '系统异常',
      '-101' => '操作不被支持',
      '-102' => '注册信息删除失败',
      '-103' => '注册信息更新失败',
      '-104' => '请求超过限制（与商务联系，通过协商为企业增加流量）',
      '-111' => '企业注册信息失败',
      '-117' => '发送信息失败',
      '-118' => '接收MO失败',
      '-119' => '接收Report失败',
      '-120' => '修改密码失败',
      '-121' => '注册激活状态失败',
      '-122' => '注销失败',
      '-123' => '查询单价失败',
      '-124' => '查询余额失败',
      '-125' => '设置转发失败',
      '-126' => '路由信息失败（联系亿美客服人员）',
      '-127' => '计费失败或零余额（联系亿美商务进行充值）',
      '-1100' => '序列号错误（非法用户）',
      '-1101' => '序列号密码错误（密码错）',
      '-1102' => '序列号密码错误（Key错误）Http版本Key=密码',
      '-1104' => '路由信息错（联系亿美客服-联系运维-解决问题）',
      '-1105' => '注册号状态异常',
      '-113' => '充值失败',
      '-1131' => '充值卡无效',
      '-1132' => '充值密码错误',
      '-1133' => '序号码绑定异常',
      '-1134' => '充值状态异常',
      '-1135' => '充值金额无效',
      '-190' => '数据库操作失败',
      '-1901' => '数据库插入失败',
      '-1902' => '数据库更新失败',
      '-1903' => '数据库删除失败'          
    }
    begin
      proxy_url = "http://sdk229ws.eucp.b2m.cn:8080/sdkproxy"
    
      cdkey= "9SDK-EMY-0229-JCSPQ"
      password = "000248"
    
      params = {}
      
      case action
      when 'regist', 'logout', 'getreport', 'querybalance', 'getmo'
        params = {
        'cdkey' => cdkey,
        'password' => password }
      when 'changepassword'
        params = {
        'cdkey' => cdkey,
        'password' => password ,
        'newpassword' => options['newpassword']}        
      when 'registdetailinfo'
        params = {
          'cdkey' => cdkey,
          'password' => password,
          'ename' => "西安途途国际旅行社有限公司",
          'linkman' => "李洪涛",
          'phonenum' => "02985411178",
          'mobile' => "18600640038",
          'email' => "lihongtao@17tutu.com",
          'fax' => "02985202082",
          'address' => "西安市碑林区会展国际大厦2205室",
          'postcode' => "710000"
        }
      when 'sendsms'
        params = {
          'cdkey' => cdkey,
          'password' => password,
          'message' => options['message'],
          'phone' => options['phone']
          #,
          #'addserial' => 
          #'sendtime' => 
          #'seqid' => 
          #'smspriority' =>
        }
      end
    
      params_string = params.keys.map{|k| "#{k}=#{URI::encode(params[k])}"}.join('&')
    
      uri = "#{proxy_url}/#{action}.action?#{params_string}"
      puts uri
      html_response = nil
      open(uri) do |http|
        html_response = http.read
      end
      puts html_response
    
      doc = Nokogiri.XML(html_response)
      result = doc.search('response error').first.content
      return result.to_i == 0 ? 'success' : "failed:#{result}-#{error_hash[result]}"
    rescue Exception => e
      return "error:#{e.to_s}"
    end
  end
  
end