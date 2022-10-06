module ApiHelpers
  def response_json
    @response_json ||= JSON.parse(response.body, symbolize_names: true)
  end

  def do_request(method, path, options = {})
    get path, options
  end
end