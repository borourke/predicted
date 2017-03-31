class PredictitApi
  # Kind of a janky api that they provide, but you can find more here:
  # https://predictit.freshdesk.com/support/solutions/articles/12000001878-does-predictit-make-market-data-available-via-an-api-
  attr_reader :connection

  def initialize
    @connection = faraday_connection
  end

  def list_all_markets
    get(path: "all").first.last
  end

  def market(market_id:)
    get(path: "ticker/#{market_id}")
  end

  def contract(contract_id:)
    get(path: "ticker/#{contract_id}")["Contracts"].select do |contract|
      contract["TickerSymbol"] == contract_id
    end.first
  end

  def group(group_id:)
    get(path: "group/#{group_id}")
  end

  def category(category_id:)
    get(path: "category/#{category_id}")
  end

  private

  def get(path:)
    response = connection.get do |req|
      req.url "#{api_base}/#{path}"
      req.headers['Content-Type'] = 'application/json'
    end
    JSON.parse(response.body)
  end

  def api_base
    '/api/marketdata'
  end

  def predictit_api_url
    'https://www.predictit.org'
  end

  def faraday_connection
    Faraday.new(url: predictit_api_url)
  end
end