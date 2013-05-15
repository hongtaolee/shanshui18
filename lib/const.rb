class Const
  STATUS_NORMAL = 1
  STATUS_DELETED = -1
  STATUS_PENDING = 0

  # old
  # 农家乐研究 3  感受四季 2 山村生活 1
  POST_CATEGORY_HASH = {
    -1 => '风景娱乐',
    1 => "最新动态",
    2 => "土特产代购",
    3 => "农家乐新闻",
    4 => "外省农家乐资讯",
    5 => "农家乐问题研究",
    6 => "农家乐经营"
  }
  NJL_POST_CATEGORY = [3,4,5,6]
  NEWS_POST_CATEGORY = 1
  BUY_POST_CATEGORY = 2
  FUN_POST_CATEGORY = -1

  NJL_INFO = [3,4,5,6]
  POST_SEARCH_CATEGORY = [
    ['作者',1],
    ['标题',2]
  ]

  PICTURE_CATEGORY = {
    1 => "标准间",
    2 => "双人间",
    3 => "三人间",
    4 => "火炕间",
    5 => "多人间",
    11 => "特色推荐",
    12 => "时令家常菜",
    13 => "野菜类",
    14 => "野味类",
    15 => "烧烤类",
    16 => '真人cs'
    
  }
  HOUSE_CATEGORY = {
    1 => "标准间",
    2 => "双人间",
    3 => "三人间",
    4 => "火炕间",
    5 => "多人间"
  }

  FOOD_CATEGORY = {
    11 => "特色推荐",
    12 => "时令家常菜",
    13 => "野菜类",
    14 => "野味类",
    15 => "烧烤类"
  }

  CS_CATEGORY = {
    16 => '真人cs'
  }
  FUN_CATEGORY = {
    21 => "重点推荐",
    22 => "周边景点",
    23 => "户外休闲",
    24 => "室内娱乐"
  }
  IC_CATEGORY = {
    :buy => 1,
    :food => 2,
    :house => 3,
    :scene => 4,
    :fun => 5,
    :ask => 6,
    :house_info => 7,
    :food_info => 8,
    :cs_info => 9,
    :cs => 10
  }
  
  JINGDIAN_PAGES = {
    1 => '翠华山',
    2 => '秦岭草甸',
    3 => '南五台山',
    4 => '农家周边免费景区'
  }

  # TODO:替换成线上的实际id
  JINGDIAN_PAGE_IDS = {
    1 => 165,
    2 => 167,
    3 => 168,
    4 => 169 
  }

  XIUXIAN_PAGES = {
    1 => '垂钓',
    2 => '开心菜园',
    3 => '篝火晚会',
    4 => '山村乐趣休闲'
  }
  # TODO:替换成线上的实际id
  XIUXIAN_PAGE_IDS = {
    1 => 170,
    2 => 171,
    3 => 172,
    4 => 173 
  }
  YULE_PAGES = {
    1 => '2万首KTV歌库',
    2 => '自动麻将机',
    3 => '各种棋牌',
    4 => '喝茶聊天等'
  }
  # TODO:替换成线上的实际id
  YULE_PAGE_IDS = {
    1 => 174,
    2 => 175,
    3 => 176,
    4 => 177 
  }
  NAV_CLASS = {
    1 => 'title',
    2 => 'user',
    3 => 'time',
    4 => 'reply'
  }

end
