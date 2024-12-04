# frozen_string_literal: true

require 'glimmer-dsl-libui'
require 'ollama-ai'

class Form
  include Glimmer
  attr_accessor :input

  def initialize
    @output = String.new
  end

  # overriding how accessor works so I'm defining them
  attr_reader :output

  def output=(new_output)
    @output += "\n#{new_output}"
  end

  def launch
    @selected_model = 'llama3.2:latest'

    @client = Ollama.new(
      credentials: { address: 'http://localhost:11434' },
      options: { server_sent_events: true }
    )

    @models = @client.request(
      'api/tags',
      request_method: 'GET',
      server_sent_events: true
    )[0]['models'].map { |item| pp item['model'] }

    window('Brain', 800, 600) do
      vertical_box do
        combobox do
          stretchy false
          items @models
          selected_item @selected_model
          on_selected do |c|
            @selected_model = c.selected_item
          end
        end
        multiline_entry do
          read_only true
          text <= [self, :output]
        end
        entry do
          stretchy false
          label 'Input' # label property is available when control is nested under form
          text <=> [self, :input]
        end

        button('send') do
          stretchy false

          on_clicked do
            result = @client.generate(
              { model: @selected_model,
                prompt: input,
                stream: false }
            )
            self.output = result[0]['response']
          end
        end
      end
    end.show
  end
end

Form.new.launch
