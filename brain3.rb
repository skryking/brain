#!/usr/bin/env ruby
require 'ollama'
include Ollama

ollama = Client.new(base_url: 'http://localhost:11434')
messages = Message.new(role: 'user', content: 'Why is the sky blue?')
ollama.chat(model: 'deepseek-r1:8b', stream: true, messages:, &Print)