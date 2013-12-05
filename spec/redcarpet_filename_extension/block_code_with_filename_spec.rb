require "spec_helper"
require "redcarpet"
require "pathname"

describe RedcarpetFilenameExtension::BlockCodeWithFilename do
  let(:markdown) do
    renderer = described_class.new
    Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
  end
  let(:fixtures_path) { Pathname.new("../fixtures").expand_path(File.dirname(__FILE__)) }

  context "When the block code is given filename" do
    it "generates the header of block code" do
      sample_path = fixtures_path.join("sample_with_filename.md")
      html = markdown.render(sample_path.read)
      expect(html).to match /<div class="code-block">/
      expect(html).to match /<div class="code-header">/
      expect(html).to match /<div class="code-body">/
    end
  end

  context "When the block code is not given filename" do
    it "doesn't generate the header of block code" do
      sample_path = fixtures_path.join("sample_without_filename.md")
      html = markdown.render(sample_path.read)
      expect(html).to match /<div class="code-block">/
      expect(html).not_to match /<div class="code-header">/
      expect(html).to match /<div class="code-body">/
    end
  end
end
