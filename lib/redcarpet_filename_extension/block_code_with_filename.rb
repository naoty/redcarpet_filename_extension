require "redcarpet"
require "pygments"

module RedcarpetFilenameExtension
  class BlockCodeWithFilename < Redcarpet::Render::HTML
    INDENT = " " * 2

    def initialize(pyg_opts = {})
      super
      @pyg_opts = pyg_opts
    end

    def block_code(code, metadata)
      language, filename = metadata.split(":") if metadata
      rows = []
      rows << %(<div class="code-block">)
      if filename
        rows << %(#{INDENT}<div class="code-header">)
        rows << %(#{INDENT * 2}<span>#{filename}</span>)
        rows << %(#{INDENT}</div>)
      end
      rows << %(#{INDENT}<div class="code-body">)
      rows << %(#{INDENT * 2}#{Pygments.highlight(code, lexer: language, options: @pyg_opts)})
      rows << %(#{INDENT}</div>)
      rows << %(</div>)
      rows.join("\n")
    end
  end
end
