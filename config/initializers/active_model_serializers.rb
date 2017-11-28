require 'active_model_serializers/register_jsonapi_renderer'

# OR config.adapter = :json_api

ActiveModelSerializers.config.tap do |config|
  config.adapter = :json
end