# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "jekyll-theme-coderic"
  spec.version       = "0.2.5"
  spec.authors       = ["Neftali Yagua"]
  spec.email         = ["coderic@coderic.org"]

  spec.summary       = "A premium, accessible Jekyll theme for enterprise portals and documentation."
  spec.homepage      = "https://github.com/Coderic/jekyll-theme-coderic"
  spec.license       = "MIT"

  # Páginas OAuth/API en la raíz; sitemap.xml en assets/ (ThemeAssetsReader Jekyll 4). robots.txt vive en cada portal.
  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_data|_layouts|_includes|_sass|LICENSE|README|_config\.yml|callback\.html|profile\.html|hello-world\.html)!i) }

  spec.add_runtime_dependency "jekyll", "~> 4.4"
  spec.add_runtime_dependency "jekyll-polyglot", "~> 1.12"
  spec.add_runtime_dependency "logger"
end
