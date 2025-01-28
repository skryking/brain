require 'ollama'
include Ollama

ollama = Client.new(base_url: 'http://localhost:11434')
messages = Message.new(role: 'user', content: 'Why is the sky blue?')
ollama.chat(model: 'llama3.1', stream: true, messages:, &Print) 

