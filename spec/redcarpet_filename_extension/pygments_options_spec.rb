require "spec_helper"
require "redcarpet"
require "pathname"

describe RedcarpetFilenameExtension::BlockCodeWithFilename do
  let(:fixtures_path) { Pathname.new("../fixtures").expand_path(File.dirname(__FILE__)) }
  let(:sample_path) { fixtures_path.join("sample_with_filename.md") }

  context "When specified pygments lineno option" do
    let(:markdown) do
      renderer = described_class.new(linenos: 1)
      Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
    end

    it "generates lineno block by pygments" do
      html = markdown.render(sample_path.read)
      expect(html).to match /<div class="highlight">/
      expect(html).to match /<div class="linenodiv">/
    end
  end

  context "When not specified pygments lineno option" do
    let(:markdown) do
      renderer = described_class.new
      Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
    end

    it "doesn't generate lineno block by pygments" do
      html = markdown.render(sample_path.read)
      expect(html).to match /<div class="highlight">/
      expect(html).not_to match /<div class="linenodiv">/
    end
  end
end
