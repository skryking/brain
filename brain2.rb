require 'langchain'
require 'faraday'
llm = Langchain::LLM::Ollama.new(default_options: { chat_model: 'llama3.2:latest' })

assistant = Langchain::Assistant.new(
  llm: llm
)

response = assistant.add_message_and_run!(content: 'how are you today?')

pp response.inspect
