require 'rest-client'
module Etherscanio
  class Call
    attr_accessor :mod,
                  :action,
                  :api_key,
                  :address,
                  :tag,
                  :startblock,
                  :endblock,
                  :sort,
                  :page,
                  :offset,
                  :sort,
                  :blocktype,
                  :txhash,
                  :blockno
    def initialize(mod, action)
      @base = 'http://api.etherscan.io/api?'
      @mod = mod
      @action = action
      @api_key = false
    end

    def fetch
      res = RestClient.get(to_s, {}).body
      parsed = JSON.parse(res)
      JSON.generate(parsed)
    end

    def to_s
      uri = 'module=' + mod + '&action=' + action
      uri += '&apikey=' + api_key if api_key
      uri += address_fragment
      uri += '&startblock=' + startblock.to_s if startblock
      uri += '&endblock=' + endblock.to_s if endblock
      uri += '&blocktype=' + blocktype if blocktype
      uri += '&txhash=' + txhash if txhash
      uri += '&blockno=' + blockno.to_s if blockno
      uri += '&offset=' + offset.to_s if offset
      uri += '&sort=' + sort if sort
      uri += '&page=' + page.to_s if page
      uri += '&tag=' + tag if tag
      @base + uri
    end

    private

    def address_fragment
      res = ''
      res += '&address=' + address if address && !address.is_a?(Array)
      res += '&address=' + address.join(',') if address && address.is_a?(Array)
      res
    end
  end
end
