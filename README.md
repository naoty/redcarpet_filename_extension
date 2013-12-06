# Redcarpet filename extension

Redcarpet custom renderer for code blocks with filename.

## Usage

```rb
renderer = BlockCodeWithFilename.new
markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
markdown.render(markdown_content)
```

When you add filename after language in your fenced code block, this custom renderer will recognize the filename.

## Example

```markdown
```rb:greeter.rb
class Greeter
  def initialize(name)
    @name = name.capitalize
  end

  def salute
    puts "Hello #{@name}!"
  end
end

# Create a new object
g = Greeter.new("world")

# Output "Hello World!"
g.salute
\```
```

This fenced block code is rendered like this.

![screenshot](screenshot.png "screenshot")
