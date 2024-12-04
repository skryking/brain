require 'ollama-ai'

client = Ollama.new(
  credentials: { address: 'http://localhost:11434' },
  options: { server_sent_events: true }
)
result = client.request(
  'api/tags',
  request_method: 'GET',
  server_sent_events: true
)

@models = result[0]['models'].map { |item| pp item['model'] }

pp @models
