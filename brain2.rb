require 'langchain'
require 'faraday'
llm = Langchain::LLM::Ollama.new(default_options: { chat_model: 'llama3.2:latest' })
weather = Langchain::Tool::Weather.new(api_key: ENV['b87c45f8dbd6025b41ae3589bbb8fd9a'])
assistant = Langchain::Assistant.new(
  llm: llm,
  tools: [weather]
)

response = assistant.add_message_and_run!(content: 'What will the weather be today in Joliet, IL?')

pp response.inspect
