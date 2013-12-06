require File.expand_path("../lib/redcarpet_filename_extension", File.dirname(__FILE__))
require "erb"
require "pathname"
require "pygments"

class Converter
  def initialize
    @layout = ERB.new(home.join("layout.erb").read)
    @markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
  end

  def convert
    content = @markdown.render(home.join("sample.md").read)
    context = Context.new(content)
    html = @layout.result(context.to_binding)
    home.join("index.html").open("wb") { |file| file.write(html) }
  end

  def generate_syntax_style(style)
    style = Pygments.css(style: style)
    home.join("syntax.css").open("wb") { |file| file.write(style) }
  end

  private

  def home
    Pathname.new(".").expand_path(File.dirname(__FILE__))
  end

  def renderer
    RedcarpetFilenameExtension::BlockCodeWithFilename.new
  end

  class Context
    def initialize(content)
      @content = content
    end

    def to_binding
      binding
    end
  end
end

converter = Converter.new
converter.convert
converter.generate_syntax_style("monokai")
